local dap = require('dap')
dap.adapters.lldbrust = {
  type = "executable",
  attach = { pidProperty = "pid", pidSelect = "ask" },
  -- 这里指向lldb-vscode的实际路径
  command = "/home/liuzehao/source/llvm-root/build/bin/lldb-vscode",
  env = { LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES" },
}

dap.adapters.rust = dap.adapters.lldbrust
dap.configurations.rust = {
  {
    type = "rust",
    request = "launch",
    name = "lldbrust",
    program = function()
      vim.fn.system "cargo build"
      local metadata_json = vim.fn.system "cargo metadata --format-version 1 --no-deps"
      local metadata = vim.fn.json_decode(metadata_json)
      if not metadata then
        print "Failed to execute cargo metadata to find the main executable."
        return
      end
      local target_name = metadata.packages[1].targets[1].name
      local target_dir = metadata.target_directory
      return target_dir .. "/debug/" .. target_name
    end,
    args = function()
      local inputstr = vim.fn.input("CommandLine Args:", "")
      local params = {}
      -- local sep = "%s"
      for param in string.gmatch(inputstr, "[^%s]+") do
        table.insert(params, param)
      end
      return params
    end,
  },
}
