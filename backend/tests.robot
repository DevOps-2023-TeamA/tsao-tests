*** Settings ***
Library           RequestsLibrary

*** Test Cases ***
Verify HTTP Get Request
    Create Session    MySession    http://localhost:8001/api/records
    ${response}    Get On Session    MySession    /
    Should Be Equal As Strings    ${response.status_code}    200
    Delete All Sessions

