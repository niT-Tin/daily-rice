
(add-hook 'sql-mode-hook 'lsp)
(setq lsp-sqls-workspace-config-path "/path/to/.sql/config.json")
(setq lsp-sqls-connections
      '(
	((driver . "mysql") (dataSourceName . "username:password@tcp(host:port)/db_name"))
	))

(provide 'projects-sql)
