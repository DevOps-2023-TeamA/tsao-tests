*** Settings ***
Library  DatabaseLibrary

*** Variables ***
${DB_SERVER}  localhost
${DB_PORT}  3306

*** Test Cases ***
Check tsao_accounts Table Exists
    [Setup]  Connect to DB
    Row Count Is Equal To X     SELECT * FROM tsao_accounts    5

*** Keywords ***
Connect to DB
    Connect To Database  pymysql  ${DB_NAME}  ${DB_USER}  ${DB_PASSWORD}  127.0.0.1  ${DBPort}
