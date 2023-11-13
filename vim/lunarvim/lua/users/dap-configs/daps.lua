-- codelldb debug 配置
-- cpp,c debug配置
require('users.dap-configs.dap-codelldb.cfg')
-- python debug配置
require('users.dap-configs.dap-python.cfg')
-- go debug 配置
require('users.dap-configs.dap-go.cfg')
-- rust debug 配置
-- 也可以使用rust-tools下RustDebugee命令触发(相关配置在插件配置内需要vscode下载lldb插件)
require('users.dap-configs.dap-rust.cfg')
-- js ts debug 配置
require('users.dap-configs.dap-firefox.cfg')
