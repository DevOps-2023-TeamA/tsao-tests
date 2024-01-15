*** Settings ***
Library  DatabaseLibrary

*** Variables ***
${DB_TYPE}  MySQL
${DB_SERVER}  localhost

*** Test Cases ***
Check tsao_accounts Table Exists
    [Setup]  Connect To Database  ${DB_TYPE}  ${DB_SERVER}  ${DB_NAME}  ${DB_USER}  ${DB_PASSWORD}
    ${exists}=  Check If Exists In Database  SELECT * FROM tsao_accounts
    Should Be True  ${exists}

