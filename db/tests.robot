*** Settings ***
Library  DatabaseLibrary

*** Variables ***
${DB_TYPE}  mysql-connector-python
${DB_SERVER}  localhost
${DB_PORT}  3306

*** Test Cases ***
Check tsao_accounts Table Exists
    [Setup]  Connect to DB
    ${exists}=  Check If Exists In Database  SELECT * FROM tsao_accounts
    Should Be True  ${exists}

*** Keywords ***
Connect to DB
    Connect To Database  ${DB_TYPE}  ${DB_SERVER}  ${DB_NAME}  ${DB_USER}  ${DB_PASSWORD}  ${DB_PORT}