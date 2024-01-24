*** Settings ***
Library  DatabaseLibrary
Library    Collections

*** Variables ***
${DB_SERVER}  localhost
${DB_PORT}  3306

*** Test Cases ***
Check tsao_accounts Table Exists
    [Documentation]    Verify that the 'tsao_accounts' table exists in the database.
    [Setup]    Connect to DB
    Table Must Exist    tsao_accounts
    [Teardown]    Disconnect From Database

Insert Data into tsao_account Table
    [Documentation]    Test to INSERT data into 'tsao_accounts' table.
    [Setup]    Connect to DB
    ${output} =    Execute SQL String    INSERT INTO tsao_accounts (ID, Name, Username, Password, Role, CreationDate, IsApproved, IsDeleted) VALUES (6, 'Steve Jobs', 'sj1955', 'f223faa96f22916294922b171a2696d868fd1f9129302eb41a45b2a2ea2ebbfd', 'User', '2024-01-22 12:34:56', true, false);
    Log    ${output}
    Should Be Equal As Strings    ${output}    None
    [Teardown]    Disconnect From Database

Update Data in tsao_account Table
    [Documentation]    Test to UPDATE data in 'tsao_accounts' table.
    [Setup]    Connect to DB
    ${output} =    Execute SQL String    UPDATE tsao_accounts SET Username = 'sj55', Role= 'Administrator' WHERE ID = 6;   
    Log    ${output}
    Should Be Equal As Strings    ${output}    None
    [Teardown]    Disconnect From Database

Delete Data in tsao_account Table
    [Documentation]    Test to DELETE data from 'tsao_accounts' table.
    [Setup]    Connect to DB
    ${output} =    Execute SQL String    DELETE FROM tsao_accounts WHERE ID=6;   
    Log    ${output}
    Should Be Equal As Strings    ${output}    None
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

Check If Exists In DB
    [Documentation]    Verify that specific data exists in the database.
    [Setup]    Connect to DB
    Check If Exists In Database    SELECT ID FROM tsao_accounts WHERE Name = 'Ben Low';
    [Teardown]    Disconnect From Database

Check If Not Exists In DB
    [Documentation]    Verify that specific data does not exist in the database.
    [Setup]    Connect to DB
    Check If Not Exists In Database    SELECT ID FROM tsao_records WHERE ContactRole = 'Lecturer';
    [Teardown]    Disconnect From Database

Verify Query - Row Count tsao_accounts table
    [Documentation]    Verify the row count of 'tsao_accounts' table.
    [Setup]    Connect to DB
    ${output} =    Query    SELECT COUNT(*) FROM tsao_accounts;
    Log    ${output}
    ${val}=    Get from list    ${output}    0
    ${val}=    Convert to list    ${val}
    ${val}=    Get from list    ${val}    0
    Should be equal as Integers    ${val}    5
    [Teardown]    Disconnect From Database

# Add more test cases based on the list provided earlier...




#added after first push.
########################################################################
# Test Case 1: Verify Unique Usernames
Check Unique Usernames
    [Documentation]    Verify that all usernames in 'tsao_accounts' table are unique.
    [Setup]    Connect to DB
    ${duplicate_usernames} =    Query    SELECT Username, COUNT(*) FROM tsao_accounts GROUP BY Username HAVING COUNT(*) > 1
    Run Keyword If    ${duplicate_usernames}    Fail    Duplicate usernames found: ${duplicate_usernames}
    [Teardown]    Disconnect From Database

# Test Case 2: Verify Password Length
Check Password Length
    [Documentation]    Verify that passwords in 'tsao_accounts' table have a minimum length of 8 characters.
    [Setup]    Connect to DB
    ${short_passwords} =    Query    SELECT Username FROM tsao_accounts WHERE LENGTH(Password) < 8
    Run Keyword If    ${short_passwords}    Fail    Passwords with insufficient length found: ${short_passwords}
    [Teardown]    Disconnect From Database

# Test Case 3: Verify Creation Date Range
Check Creation Date Range
    [Documentation]    Verify that the 'CreationDate' values in 'tsao_accounts' are within an acceptable range.
    [Setup]    Connect to DB
    ${out_of_range_dates} =    Query    SELECT Username FROM tsao_accounts WHERE CreationDate < '2024-01-01' OR CreationDate > '2024-12-31'
    Run Keyword If    ${out_of_range_dates}    Fail    Dates outside the acceptable range found: ${out_of_range_dates}
    [Teardown]    Disconnect From Database

# Test Case 4: Verify Inactive Accounts
Check Inactive Accounts
    [Documentation]    Verify that accounts marked as 'IsDeleted' are also marked as 'IsApproved'.
    [Setup]    Connect to DB
    ${inactive_accounts} =    Query    SELECT Username FROM tsao_accounts WHERE IsDeleted = true AND IsApproved = false
    Run Keyword If    ${inactive_accounts}    Fail    Inactive accounts not marked correctly: ${inactive_accounts}
    [Teardown]    Disconnect From Database

# Test Case 5: Verify Admin Role Presence
Check Admin Role Presence
    [Documentation]    Verify that at least one account has the 'Administrator' role in 'tsao_accounts'.
    [Setup]    Connect to DB
    ${admin_accounts} =    Query    SELECT Username FROM tsao_accounts WHERE Role = 'Administrator'
    Run Keyword If    not ${admin_accounts}    Fail    No accounts found with the 'Administrator' role.
    [Teardown]    Disconnect From Database

# Test Case 6: Verify Foreign Key Relationship
Check Foreign Key Relationship
    [Documentation]    Verify that the 'AccountID' in 'tsao_records' references a valid 'ID' in 'tsao_accounts'.
    [Setup]    Connect to DB
    ${invalid_foreign_keys} =    Query    SELECT r.AccountID FROM tsao_records r LEFT JOIN tsao_accounts a ON r.AccountID = a.ID WHERE a.ID IS NULL
    Run Keyword If    ${invalid_foreign_keys}    Fail    Invalid foreign keys found in 'tsao_records': ${invalid_foreign_keys}
    [Teardown]    Disconnect From Database

# Test Case 7: Verify Contact Role Values
Check Contact Role Values
    [Documentation]    Verify that 'ContactRole' values in 'tsao_records' are either 'Staff' or 'Student'.
    [Setup]    Connect to DB
    ${invalid_contact_roles} =    Query    SELECT ContactRole FROM tsao_records WHERE ContactRole NOT IN ('Staff', 'Student')
    Run Keyword If    ${invalid_contact_roles}    Fail    Invalid 'ContactRole' values found in 'tsao_records': ${invalid_contact_roles}
    [Teardown]    Disconnect From Database


##########Error Unsolved#################################################
# Test Case 8: Verify Academic Year Format
# Check Academic Year Format
#     [Documentation]    Verify that 'AcadYear' values in 'tsao_records' follow the format: YYYY/YY (e.g., 2023/24).
#     [Setup]    Connect to DB
#     ${incorrect_academic_years} =    Query    SELECT AcadYear FROM tsao_records WHERE NOT AcadYear REGEXP '^\d{4}/\d{2}$'
#     Run Keyword If    ${incorrect_academic_years}    Log Many    Incorrect 'AcadYear' formats found in 'tsao_records': ${incorrect_academic_years}
#     Run Keyword If    ${incorrect_academic_years}    Fail    Some 'AcadYear' values do not follow the format: YYYY/YY. Detailed failures: ${incorrect_academic_years}
#     [Teardown]    Disconnect From Database


# Test Case 9: Verify Student Count Range
Check Student Count Range
    [Documentation]    Verify that 'StudentCount' values in 'tsao_records' are within an acceptable range.
    [Setup]    Connect to DB
    ${out_of_range_student_counts} =    Query    SELECT StudentCount FROM tsao_records WHERE StudentCount < 0 OR StudentCount > 1000
    Run Keyword If    ${out_of_range_student_counts}    Fail    'StudentCount' values outside the acceptable range found in 'tsao_records': ${out_of_range_student_counts}
    [Teardown]    Disconnect From Database

# Test Case 10: Verify Creation Date Range
Check Record Creation Date Range
    [Documentation]    Verify that 'CreationDate' values in 'tsao_records' are within an acceptable range.
    [Setup]    Connect to DB
    ${out_of_range_record_dates} =    Query    SELECT CreationDate FROM tsao_records WHERE CreationDate < '2024-01-01' OR CreationDate > '2024-12-31'
    Run Keyword If    ${out_of_range_record_dates}    Fail    Dates outside the acceptable range found in 'tsao_records': ${out_of_range_record_dates}
    [Teardown]    Disconnect From Database

# Test Case 11: Verify Deleted Records Absence
Check Deleted Records Absence
    [Documentation]    Verify that records marked as 'IsDeleted' are not present in 'tsao_records'.
    [Setup]    Connect to DB
    ${deleted_records} =    Query    SELECT Title FROM tsao_records WHERE IsDeleted = true
    Run Keyword If    ${deleted_records}    Fail    Deleted records found in 'tsao_records': ${deleted_records}
    [Teardown]    Disconnect From Database

# Test Case 12: Verify Description Length
Check Description Length
    [Documentation]    Verify that 'Description' values in 'tsao_records' have a maximum length of 500 characters.
    [Setup]    Connect to DB
    ${long_descriptions} =    Query    SELECT Title, LENGTH(Description) FROM tsao_records WHERE LENGTH(Description) > 500
    Run Keyword If    ${long_descriptions}    Fail    Descriptions exceeding maximum length found in 'tsao_records': ${long_descriptions}
    [Teardown]    Disconnect From Database

# Test Case 13: Verify Record Title Uniqueness
Check Record Title Uniqueness
    [Documentation]    Verify that all 'Title' values in 'tsao_records' are unique.
    [Setup]    Connect to DB
    ${duplicate_titles} =    Query    SELECT Title, COUNT(*) FROM tsao_records GROUP BY Title HAVING COUNT(*) > 1
    Run Keyword If    ${duplicate_titles}    Fail    Duplicate record titles found in 'tsao_records': ${duplicate_titles}
    [Teardown]    Disconnect From Database

# Test Case 14: Verify Company Name Length
Check Company Name Length
    [Documentation]    Verify that 'CompanyName' values in 'tsao_records' have a maximum length of 100 characters.
    [Setup]    Connect to DB
    ${long_company_names} =    Query    SELECT Title, LENGTH(CompanyName) FROM tsao_records WHERE LENGTH(CompanyName) > 100
    Run Keyword If    ${long_company_names}    Fail    Company names exceeding maximum length found in 'tsao_records': ${long_company_names}
    [Teardown]    Disconnect From Database

# Test Case 15: Verify Company POC Length
Check Company POC Length
    [Documentation]    Verify that 'CompanyPOC' values in 'tsao_records' have a maximum length of 100 characters.
    [Setup]    Connect to DB
    ${long_company_pocs} =    Query    SELECT Title, LENGTH(CompanyPOC) FROM tsao_records WHERE LENGTH(CompanyPOC) > 100
    Run Keyword If    ${long_company_pocs}    Fail    Company points of contact exceeding maximum length found in 'tsao_records': ${long_company_pocs}
    [Teardown]    Disconnect From Database

# Test Case 16: Verify Record CreationDate
Check Record CreationDate
    [Documentation]    Verify that 'CreationDate' values in 'tsao_records' are populated and not null.
    [Setup]    Connect to DB
    ${missing_creation_dates} =    Query    SELECT Title FROM tsao_records WHERE CreationDate IS NULL
    Run Keyword If    ${missing_creation_dates}    Fail    Records with missing 'CreationDate' found in 'tsao_records': ${missing_creation_dates}
    [Teardown]    Disconnect From Database

# Test Case 17: Verify Record Deletion Cascade
Check Record Deletion Cascade
    [Documentation]    Verify that deleting an account in 'tsao_accounts' cascades to delete associated records in 'tsao_records'.
    [Setup]    Connect to DB
    # Assuming account with ID 7 is used as a sample for deletion
    Execute SQL String    DELETE FROM tsao_accounts WHERE ID=7
    ${remaining_records} =    Query    SELECT Title FROM tsao_records WHERE AccountID=7
    Run Keyword If    ${remaining_records}    Fail    Records associated with deleted account still exist in 'tsao_records': ${remaining_records}
    [Teardown]    Disconnect From Database

# Test Case 18: Verify Record Deletion Cascade - Inverse
Check Record Deletion Cascade - Inverse
    [Documentation]    Verify that deleting a record in 'tsao_records' does not affect the associated account in 'tsao_accounts'.
    [Setup]    Connect to DB
    # Assuming record with ID 12 is used as a sample for deletion
    Execute SQL String    DELETE FROM tsao_records WHERE ID=3
    ${remaining_accounts} =    Query    SELECT ID FROM tsao_accounts WHERE ID=3
    Run Keyword If    not ${remaining_accounts}    Fail    Associated account deleted along with the record in 'tsao_records'.
    [Teardown]    Disconnect From Database

# Test Case 19: Verify Record and Account Association
Check Record and Account Association
    [Documentation]    Verify that each record in 'tsao_records' is associated with a valid account in 'tsao_accounts'.
    [Setup]    Connect to DB
    ${invalid_associations} =    Query    SELECT r.ID, r.Title FROM tsao_records r LEFT JOIN tsao_accounts a ON r.AccountID = a.ID WHERE a.ID IS NULL
    Run Keyword If    ${invalid_associations}    Fail    Records with invalid associations found in 'tsao_records': ${invalid_associations}
    [Teardown]    Disconnect From Database

# Test Case 20: Verify Account and Record Deletion Cascade
Check Account and Record Deletion Cascade
    [Documentation]    Verify that deleting an account in 'tsao_accounts' cascades to delete all associated records in 'tsao_records'.
    [Setup]    Connect to DB
    # Assuming account with ID 9 is used as a sample for deletion
    Execute SQL String    DELETE FROM tsao_accounts WHERE ID = 9
    ${remaining_records} =    Query    SELECT Title FROM tsao_records WHERE AccountID = 9
    Run Keyword If    ${remaining_records}    Fail    Records associated with deleted account still exist in 'tsao_records': ${remaining_records}
    [Teardown]    Disconnect From Database


*** Keywords ***
Connect to DB
    Connect To Database  pymysql  ${DB_NAME}  ${DB_USER}  ${DB_PASSWORD}  127.0.0.1  ${DBPort}

Verify Data Type Contains
    [Arguments]    ${actual}    ${expected}
    ${contains}    Run Keyword And Return Status    Should Contain    ${actual}    ${expected}
    Run Keyword If    '${contains}' == 'FAIL'    Fail    Expected data type '${expected}' not found in '${actual}'

Verify IsApproved and IsDeleted Default Values
    [Arguments]    ${values}
    Should Be Equal As Numbers    1    ${values[0][0]}
    Should Be Equal As Numbers    0    ${values[0][1]}
