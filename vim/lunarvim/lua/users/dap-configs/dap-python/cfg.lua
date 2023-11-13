local dap = require('dap')

dap.adapters.python = {
  type = "executable";
  command = '/usr/bin/python';
  -- 此处要先使用pip安装debugpy模块
  args = { '-m', 'debugpy.adapter' };
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

dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = 'launch file';
    program = '${file}';
    args = get_args,
    pythonpath = function()
      return '/usr/bin/python'
    end;
    -- 可以让python在debug时动态输入参数，但是不能回到normal模式，得自己点击到代码窗口内，才是normal模式
    console = "integratedTerminal",
  },
}
