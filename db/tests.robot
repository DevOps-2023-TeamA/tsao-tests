*** Settings ***
Library  DatabaseLibrary

*** Variables ***
${DB_SERVER}  localhost
${DB_PORT}  3306

*** Test Cases ***
Check tsao_accounts Table Exists
    [Setup]  Connect to DB
    Table Must Exist    tsao_accounts

*** Keywords ***
Connect to DB
    Connect To Database  pymysql  ${DB_NAME}  ${DB_USER}  ${DB_PASSWORD}  127.0.0.1  ${DBPort}
