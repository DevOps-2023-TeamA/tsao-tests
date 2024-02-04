*** Variables ***
${admin_username}    lkh2
${admin_password}    password
${user_username}    lkh
${user_password}    password
${login_username}    xpath://*[@id="username"]
${login_password}    xpath://*[@id="password"]
${login_button}    xpath://*[@id="loginButton"]
${main_create_records}    xpath://*[@id="roleButtons"]/a[1]
${main_modify_accounts}    xpath://*[@id="roleButtons"]/a[2]
${main_query_records}    xpath://*[@id="roleButtons"]/a[3]
${account_mgmt_return}    xpath://*[@id="returnButton"]
${create_entry_url}    http://127.0.0.1:5500/tsao-frontend-svc/createentry.html
${create_entry_name}    xpath://*[@id="create-entry"]/div/div/div[1]/div[1]/div/div/div[1]/div/input
${create_entry_save}    xpath://*[@id="save"]
${create_entry_role_staff}    xpath://*[@id="create-entry"]/div/div/div[1]/div[1]/div/div/div[2]/div[1]/div/div[1]/input
${create_entry_role_student}    xpath://*[@id="create-entry"]/div/div/div[1]/div[1]/div/div/div[2]/div[1]/div/div[2]/input
${create_entry_no_of_students}    xpath://*[@id="create-entry"]/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div[1]/input
${create_entry_academic_year}    xpath://*[@id="create-entry"]/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div[2]/input
${create_entry_capstone_title}    xpath://*[@id="create-entry"]/div/div/div[1]/div[2]/div[1]/div/div/input
${create_entry_name_of_company}    xpath://*[@id="create-entry"]/div/div/div[1]/div[2]/div[2]/div/div/input
${create_entry_companyPOC}    xpath://*[@id="create-entry"]/div/div/div[1]/div[2]/div[3]/div/div/input
${create_entry_project_description}    xpath://*[@id="create-entry"]/div/div/div[2]/div/textarea
${invalid_varchar100}    bSJFOn7S31SXKnYu3nvGTs03SNjhuCywonO39qjWt4ytOHTGQWWoq6PVtsQo9jraWEM9cZQD4GRAD1VW9mDmS5ors2GMGa4beDHeqju0u9dQTvQhtrhQAdxh!@#
${invalid_varchat500}    NgF6zYtmQWyB01eFV8EsJftF4O5BxN8yejWPZ4ohh3qxqjzE0cFkMmOfY7j0c6PV6tdA6D4PdnX2G0tnWEchGOBYNvRSRPnpKcNTTcGvkmWtsr738CFFDYNNgcrnpnmS9jUp047Q25xCMEDhgD2yE6tyTOqWHChtCB5gDsXUYn41afkqQxeR60zs8vn7A3Th515E8sk3VZqVYD0TZDmY4tM5xKEcaoQMDGZrjzJj3a5c7oNxMGFkPoSqtrenomAOtStzxjS1Qzg2godMskzgZX6vO9nuzo9R0oG8VP1Zne9qqy4uhK69mV4meHZe0uhttxted4MchpzrOZ7aGUUpvM9nVBHUgsjYNxSx6hjgK6co1a1m5xmvk6Hb6oQGt19Gv315ZEExWsqwGGY2Fph1GmyCv9q3CwOXKQCPuU3w6wy1yNhaGrXuxOr4sFyovtscd6DOVytMUEeW4x2kr43YjQ13NURjwr439XNm7DYWkmvDUjyefQeX!@#


