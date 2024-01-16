*** Settings ***
Library  DatabaseLibrary
Library    Collections


*** Variables ***
${DB_SERVER}     localhost
${DB_PORT}       3306
${DB_NAME}       tsao
${DB_USER}       root
${DB_PASSWORD}   Guojun@00

*** Test Cases ***
Check tsao_accounts Table Exists
    [Setup]    Connect to DB
    Table Must Exist    tsao_accounts
    [Teardown]    Disconnect From Database

Verify Columns Existence
    [Documentation]    Verify that all columns exist in the 'tsao_accounts' table.
    [Setup]    Connect to DB
    ${columns}    Query    SHOW COLUMNS FROM tsao_accounts
    @{column_names}=    Create List
    FOR    ${column}    IN    @{columns}
        Append To List    ${column_names}    ${column[0]}  # Use index 0 to access the 'Field' value
    END
    List Should Contain Value    ${column_names}    ID
    List Should Contain Value    ${column_names}    Name
    List Should Contain Value    ${column_names}    Username
    List Should Contain Value    ${column_names}    Password
    List Should Contain Value    ${column_names}    Role
    List Should Contain Value    ${column_names}    CreationDate
    List Should Contain Value    ${column_names}    IsApproved
    List Should Contain Value    ${column_names}    IsDeleted
    [Teardown]    Disconnect From Database
Verify PrimaryKey
    [Documentation]    Verify the primary key and auto-increment for the 'ID' column.
    [Setup]    Connect to DB
    ${id_attributes}    Query    SHOW COLUMNS FROM tsao_accounts WHERE Field='ID'
    ${attribute_info}    Set Variable    ${id_attributes[0]}
    ${attribute_list}    Create List    ${attribute_info[3]}
    List Should Contain Value    ${attribute_list}    PRI
    ${auto_increment}    Set Variable If    '${attribute_info[5]}' != 'NO'    ${attribute_info[5]}    NOT FOUND
    Should Not Be Equal As Strings    ${auto_increment}    NOT FOUND
    Should Not Be Equal As Strings    ${auto_increment}    NO
    [Teardown]    Disconnect From Database

Verify ColumnDataTypes
    [Documentation]    Verify the data types of each column.
    [Setup]    Connect to DB
    ${data_types}    Query    SHOW COLUMNS FROM tsao_accounts

    FOR    ${column_info}    IN    @{data_types}
        ${column_data_type}    Set Variable    ${column_info[1]}
        Log    Column Data Type: ${column_data_type}
        Run Keyword    Verify Data Type Contains    ${column_data_type.lower()}    int
        Run Keyword    Verify Data Type Contains    ${column_data_type.lower()}    varchar(100)
        Run Keyword    Verify Data Type Contains    ${column_data_type.lower()}    varchar(100)
        Run Keyword    Verify Data Type Contains    ${column_data_type.lower()}    char(64)
        Run Keyword    Verify Data Type Contains    ${column_data_type.lower()}    enum('Administrator', 'User')
        Run Keyword    Verify Data Type Contains    ${column_data_type.lower()}    datetime
        Run Keyword    Verify Data Type Contains    ${column_data_type.lower()}    bool
        Run Keyword    Verify Data Type Contains    ${column_data_type.lower()}    bool
    END

    [Teardown]    Disconnect From Database
Verify UniqueConstraint
    [Documentation]    Verify the unique constraint on the 'Username' column.
    [Setup]    Connect to DB
    ${unique_constraint}    Query    SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS WHERE table_name = 'tsao_accounts' AND column_name = 'Username' AND non_unique = 0

    Run Keyword If    ${unique_constraint[0][0]} > 0    Log    Unique constraint exists for the 'Username' column
    Run Keyword If    ${unique_constraint[0][0]} == 0    Fail    No unique constraint found for the 'Username' column

    [Teardown]    Disconnect From Database
Verify EnumValues
    [Documentation]    Verify that the 'Role' column only accepts values 'Administrator' and 'User'.
    [Setup]    Connect to DB
    ${enum_values}    Query    SELECT DISTINCT Role FROM tsao_accounts
    List Should Contain Value    ${enum_values[0]}    Administrator
    List Should Contain Value    ${enum_values[1]}    User
    [Teardown]    Disconnect From Database

Verify DefaultValues
    [Documentation]    Verify default values for 'IsApproved' and 'IsDeleted'.
    [Setup]    Connect to DB
    ${default_values}    Query    SELECT IsApproved, IsDeleted FROM tsao_accounts WHERE ID=1

    Run Keyword If    ${default_values}    Verify IsApproved and IsDeleted Default Values    ${default_values}
    Run Keyword If    not ${default_values}    Fail    No default values found for the 'IsApproved' and 'IsDeleted' columns

    [Teardown]    Disconnect From Database

# Add more test cases based on the list provided earlier...

*** Keywords ***
Connect to DB
    Connect To Database    pymysql    ${DB_NAME}    ${DB_USER}    ${DB_PASSWORD}    ${DB_SERVER}    ${DB_PORT}
Verify Data Type Contains
    [Arguments]    ${actual}    ${expected}
    ${contains}    Run Keyword And Return Status    Should Contain    ${actual}    ${expected}
    Run Keyword If    '${contains}' == 'FAIL'    Fail    Expected data type '${expected}' not found in '${actual}'

Verify IsApproved and IsDeleted Default Values
    [Arguments]    ${values}
    Should Be Equal As Numbers    1    ${values[0][0]}
    Should Be Equal As Numbers    0    ${values[0][1]}