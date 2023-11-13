vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.cmdheight = 2

local capabilities = require('lvim.lsp').common_capabilities()

local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  vim.notify "JDTLS not found, install with `:LspInstall jdtls`"
  return
end
--[[
 注意这些操作在neovim下，安装了nvim-jdtls是没有问题的(这个文件在~/.config/nvim/ftplugin/下)，但是我当前实在lvim下，所以需要手动去lunarvim的目录(~/.local/share/lunarvim/site/after/ftplugin) 下，把对应的java.lua文件内的启动注释掉，或者删除这个文件。否则会有两个jdtls客户端启动。(不知道是不是版本问题)每次更新lunarvim，也需要这么做。
--]]
-- 之后init_options的选项
local bundles = {}
local mason_path = vim.fn.glob(vim.fn.stdpath('data') .. "/mason/")

-- 通过mason安装的jdtls
local JDTLS_LOCATION = mason_path .. "packages/jdtls"

-- 这两个extend将vscode-java-test和java-debug的jar包导入，即用于debug
-- 这些包可以去对应仓库从源码编译，也可以直接下载jar包，建议直接使用mason下载两个对应的jar包
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n"))

vim.list_extend(
  bundles,
  vim.split(
    vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
    "\n"
  )
)

-- vim.fn.system("echo" ..  .. " > /home/liuzehao/bundle.txt")

-- Data directory - change it to your liking
local HOME = os.getenv "HOME"

-- workspace用于存储eclipse.jdt.ls对应每个项目的数据，为了不污染项目，直接另外新建了一个文件夹存储
local WORKSPACE_PATH = HOME .. "/workspace/java/"

-- Only for Linux and Mac
local SYSTEM = "linux"
if vim.fn.has "mac" == 1 then
  SYSTEM = "mac"
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- 根据每个项目的名字进行存储
local workspace_dir = WORKSPACE_PATH .. project_name

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
  cmd = {
    -- 记得将JAVA_HOME加入系统PATH环境变量
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. HOME .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(JDTLS_LOCATION .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    JDTLS_LOCATION .. "/config_" .. SYSTEM,
    "-data",
    workspace_dir,
  },
  -- on_attach = require("config.lsp").on_attach,
  capabilities = capabilities,
  root_dir = root_dir,
  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",

        runtimes = {
          {
            name = "JavaSE-1.8",
            path = "~/applications/jdks/jdk1.8.0_361",
          },
          {
            name = "JavaSE-17",
            path = "~/applications/jdks/jdk-17.0.6",
          },
          {
            name = "JavaSE-11",
            path = "~/applications/jdks/jdk-11.0.18",
          },
          {
            name = "JavaSE-19",
            path = "~/applications/jdks/jdk-19.0.2",
          },
        }
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all",
        },
      },
      format = {
        enabled = true,
        settings = {
          -- 代码格式化风格
          url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    contentProvider = { preferred = "fernflower" },
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },
  flags = {
    allow_incremental_sync = true,
  },
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = bundles
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.


config["on_attach"] = function(client, bufnr)
  local _, _ = pcall(vim.lsp.codelens.refresh)
  -- 要使用dap下面两行是必要配置
  -- 发现主类
  require("jdtls.dap").setup_dap_main_class_configs()
  -- 启动dap
  jdtls.setup_dap({ hotcodereplace = "auto" })
  require("lvim.lsp").common_on_attach(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    if desc then
      desc = desc
    end

    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
  end

  map("n", "<Leader>ao", jdtls.organize_imports, "Organize Imports")
  map("n", "<Leader>av", jdtls.extract_variable, "Extract Variable")
  map("n", "<Leader>ac", jdtls.extract_constant, "Extract Constant")
  map("n", "<Leader>at", jdtls.test_nearest_method, "Test Method")
  map("n", "<Leader>aT", jdtls.test_class, "Test Class")
  map("n", "<Leader>au", "<Cmd>JdtUpdateConfig<CR>", "Update Config")
  map("v", "<Leader>av", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", "Extract Variable")
  map("v", "<Leader>ac", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", "Extract Constant")
  map("v", "<Leader>am", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "Extract Method")
end


vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
})

jdtls.start_or_attach(config)

vim.cmd(
  [[command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)]]
)

-- Add the commands
require("jdtls.setup").add_commands()
-- vim.api.nvim_exec(
--   [[
-- command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
-- command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
-- command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
-- command! -buffer JdtJol lua require('jdtls').jol()
-- command! -buffer JdtBytecode lua require('jdtls').javap()
-- command! -buffer JdtJshell lua require('jdtls').jshell(),
--   ]],
--   false
-- )
