local M = {}

local Input = require("nui.input")
local url = 'https://start.spring.io'
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local list_cache_file = "spring-boot-cache.json"
local param_cache_file = "spring-boot-param-cache.json"
local ttype = "Rel"
local para = "Parameter"
local id = "Id"
local whole_cmd = ""
local pdata, selected_rel, selected_deps, default_param, default_funs = {}, "gradle-project", {}, {}, {}
local default_sep = "AllDefault"
local default_dir = "."
-- spring boot uri to download
-- template:
-- 	 curl -G https://start.spring.io/starter.tgz -d dependencies=web,data-jpa \
-- 		   -d type=gradle-project -d baseDir=my-dir | tar -xzvf -

local function raw_fetch()
  local res = vim.fn.system("curl -s https://start.spring.io")
  local lines = vim.split(res, '\n')
  local content_pattern = "%|(.*%|)"
  local table_sep_pattern = "%+%-.*%-%+"
  local table_limit = 3
  local table_limit_count = 0
  local tables = {}
  local ress = {}
  for _, line in ipairs(lines) do
    local content_match = line:gmatch(content_pattern)
    local sep_match = string.match(line, table_sep_pattern)
    if sep_match ~= nil then
      table_limit_count = table_limit_count + 1
      if table_limit_count == table_limit then
        table.insert(tables, ress)
        ress = {}
        table_limit_count = 0
        goto continue
      end
    end
    for content in content_match do
      if not string.match(content, "^%s*%|") and string.match(content, "%w") then
        table.insert(ress, content)
      end
    end
    ::continue::
  end
  return tables
end

local function gcol(l)
  local head_words = {}
  for head_word in l:gmatch("%s*([^|]+)%s*|") do
    table.insert(head_words, head_word:match("^%s*(.-)%s*$"))
  end
  return head_words
end

local function isIn(v, t)
  for _, value in ipairs(t) do
    if value == v then
      return true
    end
  end
  return false
end

local function format_data()
  local matches = raw_fetch()
  local result, tmpl, tmps, hws = {}, {}, {}, {}
  for _, match in ipairs(matches) do
    for j, line in ipairs(match) do
      if j == 1 then
        hws = gcol(line)
        goto continue
      end
      local data = gcol(line)
      for k, _ in ipairs(hws) do
        tmps[hws[k]] = data[k] or ""
      end
      table.insert(tmpl, tmps)
      tmps = {}
      ::continue::
    end
    -- 为每一个表添加key
    if isIn(ttype, hws) then
      result[ttype] = tmpl
    end
    if isIn(para, hws) then
      result[para] = tmpl
    end
    if isIn(id, hws) then
      result[id] = tmpl
    end
    tmpl = {}
  end
  return result
end

local function highlight(name, msg)
  local cmd = "echohl " .. name .. " | echo '" .. msg .. "' | echohl None"
  vim.cmd(cmd)
end

-- cache things
local function read_cache(file_name)
  local cached_file = vim.fn.stdpath('cache') .. '/' .. file_name
  local data = {}
  local file = io.open(cached_file, 'r')
  if file then
    local content = file:read('*all')
    file:close()
    data = vim.fn.json_decode(content) or {}
  end
  return data
end

local function write_cache(data, file_name)
  local cached_file = vim.fn.stdpath('cache') .. '/' .. file_name
  local file = io.open(cached_file, 'w')
  if file then
    file:write(vim.fn.json_encode(data))
    file:close()
  end
end


M.sp = function()
  -- local script = debug.getinfo(1, "S").source:sub(2)
  -- local folder_path = script:match("(.*/)"):sub(1, -2)
  -- local awks = folder_path .. '/psp.awk'
  -- local cmd = "curl -s  " .. url .. " | awk -f " .. awks
  -- vim.cmd('highlight MyRedColor guifg=#FF0000')
  -- vim.cmd('highlight MyGreenColor guifg=#00FF00')
  -- vim.fn.jobstart({"curl", "-s", url, "|", "awk", "-f", awks}, {
  --   on_stdout = function(job_id, data, event)
  --    pdata = format_data(table.concat(data, "\n"))
  --   end,
  --   on_exit = function (job_id, code, event)
  --     if code == 0 then
  --       vim.fn.chanclose(job_id, "stdin")
  --       highlight('MyGreenColor', 'spring boot project data has been fetched')
  --     else
  --       print(code)
  --       -- highlight('MyRedColor', 'spring boot init failed')
  --     end
  --   end
  -- })
  -- local res = vim.fn.system(cmd)
  pdata = format_data()
  -- return result
  -- require('spec.test').toJson(result)
end

local function gen_default_param(chked_data)
  local param_cached = read_cache(param_cache_file)
  if string.len(vim.inspect(param_cached)) > 200 then
    default_param = param_cached
    return
  end
  for _, v in ipairs(chked_data) do
    local param = string.match(v[3], "%w*:(.*)")
    if param == "type" then
      goto continue
    end
    if param == "dependencies" then
      goto continue
    end
    local default_value = string.match(v[1], "%w*:(.*)")
    if param == "baseDir" then
      default_value = "my-dir"
    end
    default_param[param] = default_value
    -- table.insert(default_param, param .. "=" .. default_value)
    ::continue::
  end
  write_cache(default_param, param_cache_file)
end

-- modified_data should be a dict
local function alter_default_param(modified_data)
  for k, v in pairs(modified_data) do
    default_param[k] = v
  end
end


local function display_maker(tbl)
  local item = tbl.value
  return string.match(item[2], "%w*:(.*)") .. ": " .. string.match(item[1], "%w*:(.*)")
end

local function process(pre_data)
  pre_data = pre_data or {}
  local result = {}
  for _, v in pairs(pre_data) do
    local sreult = {}
    for k, vv in pairs(v) do
      table.insert(sreult, k .. ":" .. vv)
    end
    table.sort(sreult)
    table.insert(result, sreult)
  end
  return result
end

local function picker_finder(d, dm)
  return finders.new_table {
    results = d,
    entry_maker = function(entry)
      table.sort(entry)
      local ord = ""
      if entry == nil then
        return {
          value = entry,
          display = dm,
          ordinal = ord,
        }
      end
      -- means Rel
      if #entry == 2 or string.match(entry[2], "(%w*):.*") == id then
        ord = string.match(entry[2], "%w*:(.*)")
      else
        ord = string.match(entry[3], "%w*:(.*)")
      end
      return {
        value = entry,
        display = dm,
        ordinal = ord,
      }
    end,
  }
end

-- can be selected
local function gettype(raw_data)
  raw_data = raw_data or {}
  local pre_data = raw_data[ttype]
  local cked_data = process(pre_data)
  local tpy = function(opts)
    opts = opts or {}
    pickers.new(opts, {
      prompt_title = 'Rel',
      finder = picker_finder(cked_data, display_maker),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          -- 获取多选个数
          -- tab键多选
          local selection = action_state.get_selected_entry()
          local raw_rel = string.match(selection["value"][2], "%w*:(.*)")
          selected_rel = string.match(raw_rel, "^([%w|%-]+)")
        end)
        return true
      end,
    }):find()
  end
  tpy(require('telescope.themes').get_dropdown {})
end

-- should be inputed
local function getparameters(raw_data)
  local height = vim.fn.winheight(0) * 0.2
  local width = vim.fn.winwidth(0) * 0.4
  local input = Input({
    position = {
      row = height,
      col = width,
    },
    size = {
      width = 25,
      height = 10,
    },
    border = {
      style = "single",
      text = {
        top = "[Modify]",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    prompt = "> ",
    default_value = "default",
    on_close = function()
      print("Input Closed!")
    end,
    on_submit = function(value)
      local selection = action_state.get_selected_entry()
      local selected = string.match(selection["value"][3], "%w*:(.*)")
      if value == "default" then
        print("Input Submitted: " .. selected .. "=" .. default_param[selected])
        return
      end
      local moded = { [selected] = value }
      alter_default_param(moded)
      print("Input Submitted: " .. selected .. "=" .. value)
    end,
  })
  raw_data = raw_data or {}
  local pre_data = raw_data[para]
  local cked_data = process(pre_data)
  table.insert(cked_data, { "Parameter:" .. default_sep, "Description:" .. default_sep, "DefaultValue:" .. default_sep })
  local par = function(opts)
    opts = opts or {}
    pickers.new(opts, {
      prompt_title = 'Rel',
      finder = picker_finder(cked_data, function(tbl)
        local item = tbl.value
        return string.match(item[3], "%w*:(.*)") ..
            ": " ..
            "(default)" .. string.match(item[1], "%w*:(.*)") .. " Description: " .. string.match(item[2], "%w*:(.*)")
      end),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          -- actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if string.match(selection["value"][3], "%w*:(.*)") == default_sep then
            actions.close(prompt_bufnr)
            input:unmount()
          else
            input:mount()
          end
        end)
        return true
      end,
    }):find()
  end
  par(require('telescope.themes').get_dropdown {})
end

-- can be selected
local function getdependencies(raw_data)
  raw_data = raw_data or {}
  local pre_data = raw_data[id]
  local cked_data = process(pre_data)
  local dep = function(opts)
    opts = opts or {}
    pickers.new(opts, {
      prompt_title = 'Dependencies',
      finder = picker_finder(cked_data, display_maker),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local picker = action_state.get_current_picker(prompt_bufnr)
          actions.close(prompt_bufnr)
          -- 获取多选个数
          -- tab键多选
          local num_selections = #picker:get_multi_selection()
          if num_selections > 1 then
            local selections = picker:get_multi_selection()
            for _, selection in ipairs(selections) do
              -- selection排序之后，Id选项排在第二
              table.insert(selected_deps, string.match(selection.value[2], "%w*:(.*)"))
            end
          else
            local selection = action_state.get_selected_entry()
            table.insert(selected_deps, string.match(selection.value[2], "%w*:(.*)"))
            -- vim.api.nvim_put({ selection["value"][2] }, "", false, true)
          end
        end)
        return true
      end,
    }):find()
  end
  dep(require('telescope.themes').get_dropdown {})
end

local function gen_command()
  local udep = "-d dependencies="
  for k, v in pairs(selected_deps) do
    if k == 1 then
      udep = udep .. v
      goto continue
    end
    udep = udep .. "," .. v
    ::continue::
  end
  local utype = "-d type="
  utype = utype .. selected_rel
  local upar = ""
  -- default_file_name = default_param["applicationName"] .. ".tgz" or default_file_name .. ".tgz"
  for k, v in pairs(default_param) do
    if string.match(v, "%s") then
      upar = upar .. "--data-urlencode " .. "'" .. k .. "=" .. v .. "' "
    else
      upar = upar .. "-d " .. k .. "=" .. v .. " "
    end
  end
  whole_cmd = "(cd " ..
      default_dir ..
      ";curl -sG " .. url .. "/starter.tgz " .. udep .. " " .. utype .. " " .. upar .. " | tar -zxvf - 1>/dev/null)"
end

local function chose_dir()
  local height = vim.fn.winheight(0) * 0.2
  local width = vim.fn.winwidth(0) * 0.4
  local input = Input({
    position = {
      row = height,
      col = width,
    },
    size = {
      width = 25,
      height = 10,
    },
    border = {
      style = "single",
      text = {
        top = "[Dir]",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    prompt = "> ",
    default_value = ".",
    on_close = function()
      print("Input Closed!")
    end,
    on_submit = function(value)
      local path = vim.fn.expand(value)
      default_dir = path or default_dir
      print("Input Submitted: " .. default_dir)
    end,
  })
  input:mount()
end

--[[
-- export functions
--]]

M.init = function()
  if string.len(vim.inspect(pdata)) > 4096 then
    return
  end
  local cache = read_cache(list_cache_file)
  if string.len(vim.inspect(cache)) > 4096 then
    pdata = cache
    local pre_data = pdata[para]
    local cked_data = process(pre_data)
    gen_default_param(cked_data)
    vim.cmd('highlight MyGreenColor guifg=#00FF00')
    highlight('MyGreenColor', 'spring boot project data has been fetched')
    return
  end
  M.sp()
  write_cache(pdata, list_cache_file)
  local pre_data = pdata[para]
  local cked_data = process(pre_data)
  gen_default_param(cked_data)
  if string.len(vim.inspect(pdata)) < 4096 then
    vim.cmd('highlight MyRedColor guifg=#FF0000')
    highlight('MyRedColor', 'spring boot init failed')
  else
    vim.cmd('highlight MyGreenColor guifg=#00FF00')
    highlight('MyGreenColor', 'spring boot project data has been fetched')
  end
end

M.getdep = function()
  getdependencies(pdata)
end

M.gettype = function()
  -- local raw_d = M.sp()
  gettype(pdata)
end

M.getpar = function()
  getparameters(pdata)
end

M.chose_dir = function()
  chose_dir()
end

local function format_show(title, data, format)
  data = data or {}
  print(title)
  for k, v in pairs(data) do
    print(string.format(format, k, v))
  end
end

M.show_dep = function()
  format_show("deps: ", selected_deps, "%5d. %s")
end

M.show_rel = function()
  format_show("rel: ", { selected_rel }, "%5d. %s")
end

M.show_par = function()
  if string.len(vim.inspect(default_param)) < 200 then
    local param_cached = read_cache(param_cache_file)
    default_param = param_cached
  end
  print("par: ")
  for k, v in pairs(default_param) do
    print(string.format("%s", k .. "=" .. v))
  end
end

M.show_selected = function()
  format_show("rel: ", { selected_rel }, "%5d. %s")
  format_show("deps: ", selected_deps, "%5d. %s")
  M.show_par()
end

M.create_project = function()
  M.init()
  if string.len(vim.inspect(default_param)) < 200 then
    local param_cached = read_cache(param_cache_file)
    default_param = param_cached
  end
  gen_command()
  vim.fn.system(whole_cmd)
  vim.cmd('highlight MyGreenColor guifg=#00FF00')
  highlight('MyGreenColor', 'spring boot project has been initialized')
end

M.menu = function(opts)
  M.init()
  default_funs["getdep"] = M.getdep
  default_funs["gettype"] = M.gettype
  default_funs["getpar"] = M.getpar
  default_funs["chose_dir"] = M.chose_dir
  default_funs["show_dep"] = M.show_dep
  default_funs["show_rel"] = M.show_rel
  default_funs["show_par"] = M.show_par
  default_funs["show_selected"] = M.show_selected
  default_funs["create_project"] = M.create_project
  default_funs["init"] = M.init
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Functions",
    finder = finders.new_table({
      results = {
        { "init",           "init" },
        { "getdep",         "get dependencies" },
        { "gettype",        "get project type" },
        { "getpar",         "get project parameters" },
        { "chose_dir",      "chose project directory" },
        { "show_dep",       "show selected dependencies" },
        { "show_rel",       "show selected project type" },
        { "show_par",       "show selected project parameters" },
        { "show_selected",  "show all selected" },
        { "create_project", "create project" },
      },
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry[1] .. ": " .. entry[2],
          ordinal = entry[1],
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        default_funs[selection.value[1]]()
      end)
      return true
    end,
  }):find()
end

M.test_dir = function()
  -- local script = debug.getinfo(1, "S").source:sub(2)
  -- local folder_path = script:match("(.*/)"):sub(1, -2)
  local script_path = debug.getinfo(1, "S").source:sub(2)        -- 去掉路径前缀的 '@' 字符
  local current_folder = vim.fn.fnamemodify(script_path, ":h")   -- 获取当前文件夹路径
  local parent_folder = vim.fn.fnamemodify(current_folder, ":h") -- 获取上一级文件夹路径
  print(parent_folder)
end

M.setup = function()
  M.init()
end

return M
