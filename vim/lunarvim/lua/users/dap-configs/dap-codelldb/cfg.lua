local dap = require('dap')

dap.adapters.lldb = {
  type = "executable",
  command = "/home/liuzehao/source/llvm-root/build/bin/lldb-vscode",
  name = "lldb",
}

local get_args = function()
  -- 获取输入命令行参数
  local cmd_args = vim.fn.input('CommandLine Args:')
  local params = {}
  -- 定义分隔符(%s在lua内表示任何空白符号)
  local sep = "%s"
  for param in string.gmatch(cmd_args, "[^%s]+") do
    table.insert(params, param)
  end
  return params
end;

local function get_executable_from_cmake(path)
  -- 使用awk获取CMakeLists.txt文件内要生成的可执行文件的名字
  local get_executable = 'awk "BEGIN {IGNORECASE=1} /add_executable\\s*\\([^)]+\\)/ {match(\\$0, /\\(([^\\)]+)\\)/,m);match(m[1], /([A-Za-z_]+)/, n);printf(\\"%s\\", n[1]);}" '
      .. path .. "CMakeLists.txt"
  return vim.fn.system(get_executable)
end

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "lldb",
    request = "launch",
    program = function()
      local exec_prompt = "Path to executable: "
      local current_path = vim.fn.getcwd() .. "/"
      -- 使用find命令找到Makefile或者makefile
      local fd_make = string.format('find %s -maxdepth 1 -name [m\\|M]akefile', current_path)
      local fd_make_result = vim.fn.system(fd_make)
      if (fd_make_result ~= "")
      then
        local mkf = vim.fn.system(fd_make)
        -- 使用awk默认提取Makefile(makefile)中第一个的将要生成的可执行文件名称
        local cmd = 'awk "\\$0 ~ /:/ { match(\\$1, \\"([A-Za-z_]+)\\", m); printf(\\"%s\\", m[1]); exit; }" '
            .. mkf
        local exe = vim.fn.system(cmd)
        -- 执行make命令
        if (os.execute('make CXXFLAGS="-g"'))
        then
          return current_path .. exe
        end
      end
      -- 查找CMakeLists.txt文件
      local fd_cmake = string.format("find %s -name CMakeLists.txt -type f", current_path)
      local fd_cmake_result = vim.fn.system(fd_cmake)
      if (fd_cmake_result == "")
      then
        return vim.fn.input(exec_prompt, current_path, "file")
      end
      -- 查找build文件夹
      local fd_build = string.format("find %s -name build -type d", current_path)
      local fd_build_result = vim.fn.system(fd_build)
      if (fd_build_result == "")
      then
        -- 不存在则创建build文件夹
        if (not os.execute(string.format('mkdir -p %sbuild', current_path)))
        then
          return vim.fn.input(exec_prompt, current_path, "file")
        end
      end
      local cmd = 'cd ' .. current_path .. "build && cmake .. -DCMAKE_BUILD_TYPE=Debug"
      -- 开始构建项目
      print("Building The Project...")
      vim.fn.system(cmd)
      local exec = get_executable_from_cmake(current_path)
      local make = 'cd ' .. current_path .. 'build && make'
      local res = vim.fn.system(make)
      if (exec == "" or res == "")
      then
        return vim.fn.input(exec_prompt, current_path, "file")
      end
      return current_path .. "build/" .. exec
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = get_args,
  },
}
dap.configurations.c = dap.configurations.cpp
