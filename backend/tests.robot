*** Settings ***
Library           RequestsLibrary

*** Test Cases ***
Verify HTTP Get Request
    Create Session    MySession    http://localhost:8001/api/
    ${response}    Get On Session    MySession    records
    Should Be Equal As Strings    ${response.status_code}    202
    Delete All Sessions
