*** Settings ***
Library           SeleniumLibrary
Documentation       The test cases are used to test the functionality of the features in TSAO Capstone Records Webpage.

*** Variables ***
${URL}            http://127.0.0.1:5501/login.html
@{CHROME_OPTIONS}  headless  disable-gpu  window-size=1920,1080  ignore-certificate-errors  disable-extensions  no-sandbox  disable-dev-shm-usage
@{FIREFOX_OPTIONS}  headless  disable-gpu  window-size=1920,1080
*** Variables ***
${admin_username}    lkh2
${admin_password}    password
${user_username}    isabellepak
${user_password}    pa$$w0rd
${login_username}    xpath://*[@id="username"]
${login_password}    xpath://*[@id="password"]
${login_button}    xpath://*[@id="loginButton"]
${create_entry_url}    http://127.0.0.1:5500/createentry.html
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
${invalid_varchar500}    NgF6zYtmQWyB01eFV8EsJftF4O5BxN8yejWPZ4ohh3qxqjzE0cFkMmOfY7j0c6PV6tdA6D4PdnX2G0tnWEchGOBYNvRSRPnpKcNTTcGvkmWtsr738CFFDYNNgcrnpnmS9jUp047Q25xCMEDhgD2yE6tyTOqWHChtCB5gDsXUYn41afkqQxeR60zs8vn7A3Th515E8sk3VZqVYD0TZDmY4tM5xKEcaoQMDGZrjzJj3a5c7oNxMGFkPoSqtrenomAOtStzxjS1Qzg2godMskzgZX6vO9nuzo9R0oG8VP1Zne9qqy4uhK69mV4meHZe0uhttxted4MchpzrOZ7aGUUpvM9nVBHUgsjYNxSx6hjgK6co1a1m5xmvk6Hb6oQGt19Gv315ZEExWsqwGGY2Fph1GmyCv9q3CwOXKQCPuU3w6wy1yNhaGrXuxOr4sFyovtscd6DOVytMUEeW4x2kr43YjQ13NURjwr439XNm7DYWkmvDUjyefQeX!@#

*** Test Cases ***
Verify Login Page Opens Successfully
    [Documentation]    Verifies the login page has been successfully open.
    [Tags]    Login
    [Setup]    Open Browser
    Go To Site
    Title Should Be    TSA Office Records System
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When Valid Admin Credentials are Entered into Login Page
    [Documentation]    Verifies the admin able to login with valid login credentials.
    [Tags]    Login
    [Setup]    Open Browser
    Go To Site
    Title Should Be    TSA Office Records System
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept 
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When Valid User Credentials are Entered into Login Page
    [Documentation]    Verifies the user able to login with valid login credentials.
    [Tags]    Login
    [Setup]    Open Browser
    Go To Site
    Title Should Be    TSA Office Records System
    Input Username    ${user_username}
    Input Password    ${user_password}
    Submit Login
    Handle Alert    action=accept 
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When Invalid Username is Entered into Login Page
    [Documentation]    Verifies the error message appears when user login with invalid username.
    [Tags]    Login
    [Setup]    Open Browser
    Go To Site
    Input Username    qwerty
    Input Password    ${user_password}
    Submit Login
    Page Should Contain    Error: Incorrect username or password! Please try again.
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When Invalid Password is Entered into Login Page
    [Documentation]    Verifies the error message appears when user login with invalid password.
    [Tags]    Login
    [Setup]    Open Browser
    Go To Site
    Input Username    ${user_username}
    Input Password    password123
    Submit Login
    Page Should Contain    Error: Incorrect username or password! Please try again.
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When no Input then Click on Login Button
    [Documentation]    Verifies the error message appears when no input has been entered into the login page.
    [Tags]    Login
    [Setup]    Open Browser
    Go To Site
    Submit Login
    Page Should Contain    Error: Incorrect username or password! Please try again.
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When Only Username is Entered in Login Page
    [Documentation]    Verifies the error message appears when only username is entered into the login page.
    [Tags]    Login
    [Setup]    Open Browser
    Go To Site
    Input Username    ${admin_username}
    Submit Login
    Page Should Contain    Error: Incorrect username or password! Please try again.
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When Only Password is Entered in Login Page
    [Documentation]    Verifies the error message appears when only password is entered into the login page.
    [Tags]    Login
    [Setup]    Open Browser
    Go To Site
    Input Password   ${admin_password}
    Submit Login
    Page Should Contain    Error: Incorrect username or password! Please try again.
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When Admin Clicks on Logout Button
    [Documentation]    Verifies the response when an admin clicks on the logout button.  
    [Tags]    Logout   
    [Setup]    Open Browser
    Go To Site
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept 
    Click Logout Button
    Title Should Be    TSA Office Records System
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When User Clicks on Logout Button
    [Documentation]    Verifies the response when a user clicks on the logout button.
    [Tags]    Logout   
    [Setup]    Open Browser
    Go To Site
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept 
    Click Logout Button
    Title Should Be    TSA Office Records System
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When User Create New Account With Valid Inputs
    [Documentation]    Verifies the response when user attempt to create new account with valid inputs.
    [Tags]    Create Account 
    [Setup]    Open Browser 
    Go To Site
    Click Create Button
    Wait Until Page Contains    Create New Account
    Input Text    id=name    John Doe
    Input Text    id=username    john_doe123
    Input Text    id=password    securePassword123
    Click Element    id=createNewAccButton
    Handle Alert    action=accept
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When User Create New Account With Invalid Inputs
    [Documentation]    Verifies the response when user attempt to create new account with invalid inputs.
    [Tags]    Create Account
    [Setup]    Open Browser
    Go To Site
    Click Create Button
    Wait Until Page Contains    Create New Account
    Input Text    id=name    ${null}
    Input Text    id=username    lkh2
    Input Text    id=password    1234
    Click Element    id=createNewAccButton
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When User Create New Account Without Inputs
    [Documentation]    Verifies the response when user attempt to create new account without inputs.
    [Tags]    Create Account
    [Setup]    Open Browser
    Go To Site
    Click Create Button
    Wait Until Page Contains    Create New Account
    Click Element    id=createNewAccButton
    [Teardown]    Close Browser

Check Response When User Create New Entry With Valid Inputs
    [Documentation]    Verifies the response when user attempt to create new Capstone entry with valid inputs.
    [Tags]    Create New Entry 
    [Setup]    Open Browser 
    Go To Site
    Input Username    ${user_username}
    Input Password    ${user_password}
    Submit Login
    Handle Alert    action=accept
    Wait Until Page Contains    Welcome to the TSAO Capstone Records System
    Click Element    xpath://*[@id="roleButtons"]/a[1]
    Click Element    ${create_entry_role_student}
    Click Element    ${create_entry_no_of_students}
    Input Text    ${create_entry_no_of_students}   5
    Click Element    ${create_entry_academic_year}
    Input Text    ${create_entry_academic_year}    2023/24
    Click Element    ${create_entry_capstone_title}
    Input Text    ${create_entry_capstone_title}    DevOps Project
    Click Element    ${create_entry_name_of_company}
    Input Text    ${create_entry_name_of_company}    ABC Pte Ltd
    Click Element    ${create_entry_companyPOC}
    Input Text    ${create_entry_companyPOC}    Tan BB
    Click Element    ${create_entry_project_description}
    Input Text    ${create_entry_project_description}    I LOVE DevOps.
    Click Button    ${create_entry_save}
    Handle Alert    action=accept
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When User Create New Entry With Invalid Inputs
    [Documentation]    Verifies the response when user attempt to create new Capstone entry with invalid inputs.
    [Tags]    Create New Entry 
    [Setup]    Open Browser 
    Go To Site
    Input Username    ${user_username}
    Input Password    ${user_password}
    Submit Login
    Handle Alert    action=accept
    Wait Until Page Contains    Welcome to the TSAO Capstone Records System
    Click Element    xpath://*[@id="roleButtons"]/a[1]
    Click Element    ${create_entry_no_of_students}
    Input Text    ${create_entry_no_of_students}   qwerty
    Click Element    ${create_entry_academic_year}
    Input Text    ${create_entry_academic_year}    qwerty
    Click Element    ${create_entry_capstone_title}
    Input Text    ${create_entry_capstone_title}    ${invalid_varchar100}
    Click Element    ${create_entry_name_of_company}
    Input Text    ${create_entry_name_of_company}    ${invalid_varchar100}
    Click Element    ${create_entry_companyPOC}
    Input Text    ${create_entry_companyPOC}    ${invalid_varchar100}
    Click Element    ${create_entry_project_description}
    Input Text    ${create_entry_project_description}    ${invalid_varchar500}
    Click Button    ${create_entry_save}
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When User Create New Entry Without Inputs
    [Documentation]    Verifies the response when user attempt to create new Capstone entry without inputs.
    [Tags]    Create New Entry 
    [Setup]    Open Browser 
    Go To Site
    Input Username    ${user_username}
    Input Password    ${user_password}
    Submit Login
    Handle Alert    action=accept
    Wait Until Page Contains    Welcome to the TSAO Capstone Records System
    Click Element    xpath://*[@id="roleButtons"]/a[1]
    Click Element    ${create_entry_no_of_students}
    Input Text    ${create_entry_no_of_students}   ${null}
    Click Element    ${create_entry_academic_year}
    Input Text    ${create_entry_academic_year}    ${null}
    Click Element    ${create_entry_capstone_title}
    Input Text    ${create_entry_capstone_title}    ${null}
    Click Element    ${create_entry_name_of_company}
    Input Text    ${create_entry_name_of_company}    ${null}
    Click Element    ${create_entry_companyPOC}
    Input Text    ${create_entry_companyPOC}    ${null}
    Click Element    ${create_entry_project_description}
    Input Text    ${create_entry_project_description}    ${null}
    Click Button    ${create_entry_save}
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When User Click on Cancel Button at Create New Entry Page
    [Documentation]    Verifies the response when user click on cancel button at create new entry page.
    [Tags]    Cancel
    [Setup]    Open Browser   
    Go To Site
    Input Username    ${user_username}
    Input Password    ${user_password}
    Submit Login
    Handle Alert    action=accept
    Wait Until Page Contains    Welcome to the TSAO Capstone Records System
    Click Element    xpath://*[@id="roleButtons"]/a[1]
    Click Element    xpath://*[@id="cancel"]
    Wait Until Page Contains    Welcome to the TSAO Capstone Records System
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When Admin Attempt to Modify Account Details With Valid Details
    [Documentation]    Verifies the response when admin making valid changes on specific account details.
    [Tags]    Modify Account 
    [Setup]    Open Browser
    Go To Site  
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept
    Wait Until Page Contains    Welcome to the TSAO Capstone Records System
    Click Element    xpath://*[@id="roleButtons"]/a[2]
    Click Element    xpath://*[@id="accountsTable"]/tr[2]/td[7]/button[1]
    Click Element    xpath://*[@id="name"]
    Input Text    xpath://*[@id="name"]    CZY
    Click Element    xpath://*[@id="username"]
    Input Text    xpath://*[@id="username"]    YouYou
    Click Button    xpath://*[@id="role"]
    Click Element    xpath://*[@id="layout-wrapper"]/div/div/div/div[2]/div/div/div[1]/form/div[3]/div/div/a[1]
    Click Button    xpath://*[@id="editAccButton"]
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When Admin Attempt to Modify Account With Invalid Details
    [Documentation]    Verifies the response when admin making invalid changes on specific account details.
    [Tags]    Modify Account 
    [Setup]    Open Browser   
    Go To Site
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept
    Wait Until Page Contains    Welcome to the TSAO Capstone Records System
    Click Element    xpath://*[@id="roleButtons"]/a[2]
    Click Element    xpath://*[@id="accountsTable"]/tr[1]/td[7]/button[1]
    Click Element    xpath://*[@id="name"]
    Input Text    xpath://*[@id="name"]    ${null}
    Click Element    xpath://*[@id="username"]
    Input Text    xpath://*[@id="username"]    lkh2
    Click Button    xpath://*[@id="editAccButton"]
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When Admin Click Cancel Button at Account Management Page
    [Documentation]    Verifies the response when admin click cancel button at account management page.
    [Tags]    Cancel 
    [Setup]    Open Browser   
    Go To Site
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept
    Wait Until Page Contains    Welcome to the TSAO Capstone Records System
    Click Element    xpath://*[@id="roleButtons"]/a[2]
    Click Element    xpath://*[@id="accountsTable"]/tr[1]/td[7]/button[1]
    Click Element    xpath://*[@id="cancelButton"]
    Wait Until Page Contains    Account Management
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When Admin Attempt to Modify Account Password With Valid Details
    [Documentation]    Verifies the response when admin making valid changes on specific account password.
    [Tags]    Modify Account 
    [Setup]    Open Browser
    Go To Site  
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept
    Wait Until Page Contains    Welcome to the TSAO Capstone Records System
    Click Element    xpath://*[@id="roleButtons"]/a[2]
    Click Element    xpath://*[@id="accountsTable"]/tr[1]/td[7]/button[2]
    Click Element    xpath://*[@id="password1"]
    Input Text    xpath://*[@id="password1"]    Pa$$w0rd
    Click Element    xpath://*[@id="password2"]
    Input Text    xpath://*[@id="password2"]    Pa$$w0rd
    Click Button    xpath://*[@id="changePasswordButton"]
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When Admin Attempt to Modify Account Password With Invalid Input
    [Documentation]    Verifies the response when admin making invalid changes on specific account password.
    [Tags]    Modify Account 
    [Setup]    Open Browser   
    Go To Site
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept
    Wait Until Page Contains    Welcome to the TSAO Capstone Records System
    Click Element    xpath://*[@id="roleButtons"]/a[2]
    Click Element    xpath://*[@id="accountsTable"]/tr[1]/td[7]/button[2]
    Click Element    xpath://*[@id="password1"]
    Input Text    xpath://*[@id="password1"]    Pa$$W0rd
    Click Element    xpath://*[@id="password2"]
    Input Text    xpath://*[@id="password2"]    1234
    Click Button    xpath://*[@id="changePasswordButton"]
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When Admin Click on Cancel Button at Change Account Password Page
    [Documentation]    Verifies the response when admin click on cancel button at change account password page.
    [Tags]    Cancel
    [Setup]    Open Browser   
    Go To Site
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept
    Wait Until Page Contains    Welcome to the TSAO Capstone Records System
    Click Element    xpath://*[@id="roleButtons"]/a[2]
    Click Element    xpath://*[@id="accountsTable"]/tr[1]/td[7]/button[2]
    Click Element    xpath://*[@id="cancelButton"]
    Wait Until Page Contains    Account Management
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When Admin Click on Delete Button and Confirm at Account Management Page
    [Documentation]    Verifies the response when admin click on delete button and confirm at account management page.
    [Tags]    Delete Account
    [Setup]    Open Browser   
    Go To Site
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept
    Wait Until Page Contains    Welcome to the TSAO Capstone Records System
    Click Element    xpath://*[@id="roleButtons"]/a[2]
    Click Element    xpath://*[@id="accountsTable"]/tr[1]/td[7]/button[3]
    Click Element    xpath:/html/body/div[2]/div/div[6]/button[1]
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When Admin Click on Delete Button and Cancel at Account Management Page
    [Documentation]    Verifies the response when admin click on delete button and cancel at account management page.
    [Tags]    Delete Account
    [Setup]    Open Browser   
    Go To Site
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept
    Wait Until Page Contains    Welcome to the TSAO Capstone Records System
    Click Element    xpath://*[@id="roleButtons"]/a[2]
    Click Element    xpath://*[@id="accountsTable"]/tr[1]/td[7]/button[3]
    Click Element    xpath:/html/body/div[2]/div/div[6]/button[3]
    Capture Page Screenshot
    [Teardown]  Close Browser

*** Keywords ***
Open Browser
    [Arguments]    ${browser}=chrome
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].${browser.capitalize()}Options()    sys, selenium.webdriver
    ${browser_options}=    Run Keyword If    '${browser}' == 'chrome'    Set Chrome Options    ${options}
    ...    ELSE IF    '${browser}' == 'firefox'    Set Firefox Options    ${options}
    Create Webdriver    ${browser.capitalize()}    options=${browser_options}

Set Chrome Options
    [Arguments]    ${options}
    FOR    ${arg}    IN    @{CHROME_OPTIONS}
        Call Method    ${options}    add_argument    ${arg}
    END

    RETURN    ${options}

Set Firefox Options
    [Arguments]    ${options}
    FOR    ${arg}    IN    @{FIREFOX_OPTIONS}
        Call Method    ${options}    add_argument    ${arg}
    END

    RETURN    ${options}

Go To Site
    Go To    ${URL}

Input Username
    [Arguments]    ${username}
    Input Text    id=username    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    id=password    ${password}

Submit Login
    Click Element    id=loginButton

Click Create Button
    Click Element    xpath://*[@id="newAccountButton"]

Click Logout Button
    Click Element    id=logoutButton

Fill New Entry Form
    [Arguments]    ${name}    ${capstone_title}    ${role_of_contact}    ${num_of_students}    ${academic_year}    ${company_name}    ${contact_person}    ${project_description}
    Input Text    id=nameInput    ${name}
    Input Text    id=capstoneTitleInput    ${capstone_title}
    Select From List by Value    id=roleOfContactSelect    ${role_of_contact}
    Input Text    id=numOfStudentsInput    ${num_of_students}
    Input Text    id=academicYearInput    ${academic_year}
    Input Text    id=companyNameInput    ${company_name}
    Input Text    id=contactPersonInput    ${contact_person}
    Input Text    id=projectDescriptionInput    ${project_description}

Click Save Button
    Click Element    id=saveButton