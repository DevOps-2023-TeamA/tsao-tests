*** Settings ***
Library           SeleniumLibrary

Documentation       The test cases are used to test the functionality of the features in TSAO Capstone Records Webpage.

*** Variables ***
${URL}            http://localhost:8080
@{CHROME_OPTIONS}  headless  disable-gpu  window-size=1920,1080  ignore-certificate-errors  disable-extensions  no-sandbox  disable-dev-shm-usage
@{FIREFOX_OPTIONS}  headless  disable-gpu  window-size=1920,1080
*** Variables ***
${admin_username}    lkh2
${admin_password}    password
${user_username}    lkh
${user_password}    password
${login_username}    xpath://*[@id="username"]
${login_password}    xpath://*[@id="password"]
${login_button}    xpath://*[@id="loginButton"]
${create_entry_url}    http://127.0.0.1:5500/createentry.html
${create_entry_name}    xpath://*[@id="create-entry"]/div/div/div[1]/div[1]/div/div/div[1]/div/input
${create_entry_save}    xpath://*[@id="save"]
${create_entry_role_staff}    xpath://*[@id="create-entry"]/div/div/div[1]/div[1]/div/div/div[2]/div[1]/div/div[1]/input
${create_entry_no_of_students}    xpath://*[@id="create-entry"]/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div[1]/input
${create_entry_academic_year}    xpath://*[@id="create-entry"]/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div[2]/input
${create_entry_capstone_title}    xpath://*[@id="create-entry"]/div/div/div[1]/div[2]/div[1]/div/div/input
${create_entry_name_of_company}    xpath://*[@id="create-entry"]/div/div/div[1]/div[2]/div[2]/div/div/input
${create_entry_companyPOC}    xpath://*[@id="create-entry"]/div/div/div[1]/div[2]/div[3]/div/div/input
${create_entry_project_description}    xpath://*[@id="create-entry"]/div/div/div[2]/div/textarea
${invalid_varchar100}    bSJFOn7S31SXKnYu3nvGTs03SNjhuCywonO39qjWt4ytOHTGQWWoq6PVtsQo9jraWEM9cZQD4GRAD1VW9mDmS5ors2GMGa4beDHeqju0u9dQTvQhtrhQAdxh!@#
${invalid_varchat500}    NgF6zYtmQWyB01eFV8EsJftF4O5BxN8yejWPZ4ohh3qxqjzE0cFkMmOfY7j0c6PV6tdA6D4PdnX2G0tnWEchGOBYNvRSRPnpKcNTTcGvkmWtsr738CFFDYNNgcrnpnmS9jUp047Q25xCMEDhgD2yE6tyTOqWHChtCB5gDsXUYn41afkqQxeR60zs8vn7A3Th515E8sk3VZqVYD0TZDmY4tM5xKEcaoQMDGZrjzJj3a5c7oNxMGFkPoSqtrenomAOtStzxjS1Qzg2godMskzgZX6vO9nuzo9R0oG8VP1Zne9qqy4uhK69mV4meHZe0uhttxted4MchpzrOZ7aGUUpvM9nVBHUgsjYNxSx6hjgK6co1a1m5xmvk6Hb6oQGt19Gv315ZEExWsqwGGY2Fph1GmyCv9q3CwOXKQCPuU3w6wy1yNhaGrXuxOr4sFyovtscd6DOVytMUEeW4x2kr43YjQ13NURjwr439XNm7DYWkmvDUjyefQeX!@#

${admin_username}    lkh2
${admin_password}    password
${user_username}    lkh
${user_password}    password

*** Test Cases ***
Open Website
    Open Browser    
    Go To Site
    Title Should Be    TSA Office Records System
    Capture Page Screenshot
    [Teardown]  Close Browser

Verify Login Page Opens Successfully
    [Setup]    Open Browser
    Go To Site
    Title Should Be    TSA Office Records System
    [Teardown]    Close Browser

Check Response for Valid Admin Credentials
    Open Browser
    Go To Site
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept 
    Page Should Contain     Welcome to the TSAO Capstone Records System

Verify Login Page Open Successfully
    [Setup]    Open Browser
    Go To Site
    Title Should Be    TSA Office Records System
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When Valid Admin Credentials are Entered into Login Page
    Open Browser
    Go To Site
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept 
    Page Should Contain     Welcome to the TSAO Capstone Records System
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When no Input then Click on Login Button
    Open Browser
    Go To Site
    Submit Login
    Sleep    2s  
    Page Should Contain    Error: Account does not exist
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When Only Username is Entered in Login Page
    Open Browser
    Go To Site
    Input Username    ${admin_username}
    Submit Login
    Sleep    2s 
    Page Should Contain    Error: Account does not exist
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When Admin/User Clicks on Logout Button
    [Documentation]    Verifies the response when an admin/user clicks on the logout button.
    Open Browser    
    Go To Site
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept 
    Click Logout Button
    Title Should Be    Login | TSA Office Records System
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When User Create New Account
    Open Browser    
    Go To Site
    Click Create Button
    Wait Until Page Contains    Create New Account
    Input Text    id=name    John Doe
    Input Text    id=username    john_doe123
    Input Text    id=password    securePassword123
    Click Element    id=createNewAccButton
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When User Click on Create Records Button
    Open Browser    
    Go To Site
    Title Should Be    TSA Office Records Systems
    Click Element    ${login_username}
    Sleep    2s
    Input Text    ${login_username}    lkh2
    Sleep    2s
    Click Element    ${login_password}
    Sleep    2s
    Input Text    ${login_password}    password
    Sleep    2s
    Click Button    ${login_button}
    Press Keys    ENTER
    Sleep    2s
    Title Should Be    Home | TSAO Records Systems
    Click Element    xpath://*[@id="roleButtons"]/a[1]
    Sleep    2s
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When User Click on Modify Accounts Button
    Open Browser    
    Go To Site
    Title Should Be    TSA Office Records Systems
    Click Element    ${login_username}
    Sleep    2s
    Input Text    ${login_username}    lkh2
    Sleep    2s
    Click Element    ${login_password}
    Sleep    2s
    Input Text    ${login_password}    password
    Sleep    2s
    Click Button    ${login_button}
    Press Keys    ENTER
    Sleep    2s
    Title Should Be    Home | TSAO Records Systems
    Click Element    xpath://*[@id="roleButtons"]/a[2]
    Sleep    2s
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When User Click on Return Button
    Open Browser    
    Go To Site
    Title Should Be    TSA Office Records Systems
    Click Element    ${login_username}
    Sleep    2s
    Input Text    ${login_username}    lkh2
    Sleep    2s
    Click Element    ${login_password}
    Sleep    2s
    Input Text    ${login_password}    password
    Sleep    2s
    Click Button    ${login_button}
    Press Keys    ENTER
    Sleep    2s
    Title Should Be    Home | TSAO Records Systems
    Click Element    xpath://*[@id="returnButton"]
    Sleep    2s
    Title Should Be    Home | TSAO Records Systems
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When User Click on Query Records Button
    Open Browser    
    Go To Site
    Title Should Be    TSA Office Records Systems
    Click Element    ${login_username}
    Sleep    2s
    Input Text    ${login_username}    lkh2
    Sleep    2s
    Click Element    ${login_password}
    Sleep    s2
    Input Text    ${login_password}    password
    Sleep    2s
    Click Button    ${login_button}
    Press Keys    ENTER
    Sleep    2s
    Title Should Be    Home | TSAO Records Systems
    Click Element    xpath://*[@id="roleButtons"]/a[3]
    Sleep    2s
    Capture Page Screenshot
    [Teardown]  Close Browser

Verify Login Page Open Successfully
    [Setup]    Open Browser
    Go To Site
    Title Should Be    TSA Office Records System
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When Valid Admin Credentials are Entered into Login Page
    Open Browser
    Go To Site
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept 
    Page Should Contain     Welcome to the TSAO Capstone Records System
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When no Input then Click on Login Button
    Open Browser
    Go To Site
    Submit Login
    Sleep    2s  
    Page Should Contain    Error: Account does not exist
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When Only Username is Entered in Login Page
    Open Browser
    Go To Site
    Input Username    ${admin_username}
    Submit Login
    Sleep    2s 
    Page Should Contain    Error: Account does not exist
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When Admin/User Clicks on Logout Button
    [Documentation]    Verifies the response when an admin/user clicks on the logout button.
    Open Browser    
    Go To Site
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept 
    Click Logout Button
    Title Should Be    Login | TSA Office Records System
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When User Create New Account
    Open Browser    
    Go To Site
    Click Create Button
    Wait Until Page Contains    Create New Account
    Input Text    id=name    John Doe
    Input Text    id=username    john_doe123
    Input Text    id=password    securePassword123
    Click Element    id=createNewAccButton
    Capture Page Screenshot
    [Teardown]    Close Browser

Check Response When User Click on Create Records Button
    Open Browser    
    Go To Site
    Title Should Be    TSA Office Records Systems
    Click Element    ${login_username}
    Sleep    2s
    Input Text    ${login_username}    lkh2
    Sleep    2s
    Click Element    ${login_password}
    Sleep    2s
    Input Text    ${login_password}    password
    Sleep    2s
    Click Button    ${login_button}
    Press Keys    ENTER
    Sleep    2s
    Title Should Be    Home | TSAO Records Systems
    Click Element    xpath://*[@id="roleButtons"]/a[1]
    Sleep    2s
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When User Click on Modify Accounts Button
    Open Browser    
    Go To Site
    Title Should Be    TSA Office Records Systems
    Click Element    ${login_username}
    Sleep    2s
    Input Text    ${login_username}    lkh2
    Sleep    2s
    Click Element    ${login_password}
    Sleep    2s
    Input Text    ${login_password}    password
    Sleep    2s
    Click Button    ${login_button}
    Press Keys    ENTER
    Sleep    2s
    Title Should Be    Home | TSAO Records Systems
    Click Element    xpath://*[@id="roleButtons"]/a[2]
    Sleep    2s
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When User Click on Return Button
    Open Browser    
    Go To Site
    Title Should Be    TSA Office Records Systems
    Click Element    ${login_username}
    Sleep    2s
    Input Text    ${login_username}    lkh2
    Sleep    2s
    Click Element    ${login_password}
    Sleep    2s
    Input Text    ${login_password}    password
    Sleep    2s
    Click Button    ${login_button}
    Press Keys    ENTER
    Sleep    2s
    Title Should Be    Home | TSAO Records Systems
    Click Element    xpath://*[@id="returnButton"]
    Sleep    2s
    Title Should Be    Home | TSAO Records Systems
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When User Click on Query Records Button
    Open Browser    
    Go To Site
    Title Should Be    TSA Office Records Systems
    Click Element    ${login_username}
    Sleep    2s
    Input Text    ${login_username}    lkh2
    Sleep    2s
    Click Element    ${login_password}
    Sleep    s2
    Input Text    ${login_password}    password
    Sleep    2s
    Click Button    ${login_button}
    Press Keys    ENTER
    Sleep    2s
    Title Should Be    Home | TSAO Records Systems
    Click Element    xpath://*[@id="roleButtons"]/a[3]
    Sleep    2s
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When Valid Inputs are Entered into Create New Entry Page
    Open Browser
    Go To Create New Capstone Entry Page
    Title Should Be   TSA Office Records Systems
    Click Element    ${create_entry_name}
    Sleep    2s
    Input Text   ${create_entry_name}    Low KH
    Sleep    2s
    Click Button    xpath://*[@id="create-entry"]/div/div/div[1]/div[1]/div/div/div[2]/div[1]/div/div[2]/input
    Sleep    2s
    Click Element    ${create_entry_no_of_students}
    Sleep    2s
    Input Text   ${create_entry_no_of_students}    5
    Sleep    2s
    Click Element    ${create_entry_academic_year}
    Sleep    2s
    Input Text    ${create_entry_academic_year}    2022/23
    Sleep    2s
    Click Element    ${create_entry_capstone_title}
    Sleep    2s
    Input Text    ${create_entry_capstone_title}    DevOps Project
    Sleep    2s
    Click Element    ${create_entry_name_of_company}
    Sleep    2s
    Input Text    ${create_entry_name_of_company}    ABC Pte Ltd
    Sleep    2s
    Click Element    ${create_entry_companyPOC}
    Sleep    2s
    Input Text    ${create_entry_companyPOC}    Tan BB
    Sleep    2s
    Click Element    ${create_entry_project_description}
    Sleep    2s
    Input Text    ${create_entry_project_description}    I LOVE DevOps.
    Sleep    2s
    Click Button    ${create_entry_save}
    Capture Page Screenshot 
    [Teardown]    Close Browser

Check error message when no input were made
    Open Browser
    Go To Site
    Submit Login
    Sleep    1s  
    Page Should Contain    Error: Incorrect username or password! Please try again.
    [Teardown]    Close Browser


Check Response When Admin/User Clicks on Logout Button
    [Documentation]    Verifies the response when an admin/user clicks on the logout button.
    Open Browser    
    Go To Site
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept 
    Click Logout Button
    Title Should Be    Login | TSAO Capstone Records System
    Go To Create New Capstone Entry Page
    Title Should Be   TSA Office Records Systems
    Click Element    ${create_entry_name}
    Sleep    2s
    Input Text   ${create_entry_name}    Low!23
    Sleep    2s
    Click Element    ${create_entry_no_of_students}
    Sleep    2s
    Input Text   ${create_entry_no_of_students}    ZXC
    Sleep    2s
    Click Element    ${create_entry_academic_year}
    Sleep    2s
    Input Text    ${create_entry_academic_year}    ZXC
    Sleep    2s
    Click Element    ${create_entry_capstone_title}
    Sleep    2s
    Input Text    ${create_entry_capstone_title}    ${invalid_varchar100}
    Sleep    2s
    Click Element    ${create_entry_name_of_company}
    Sleep    2s
    Input Text    ${create_entry_name_of_company}    ${invalid_varchar100}
    Sleep    2s
    Click Element    ${create_entry_companyPOC}
    Sleep    2s
    Input Text    ${create_entry_companyPOC}    ${invalid_varchar100}
    Sleep    2s
    Click Element    ${create_entry_project_description}
    Sleep    2s
    Input Text    ${create_entry_project_description}    ${invalid_varchat500}
    Sleep    2s
    Click Button    ${create_entry_save}    
    Capture Page Screenshot

    [Teardown]    Close Browser

Check Response When only username is entered
    Open Browser
    Go To Site
    Input Username    ${admin_username}
    Submit Login
    Sleep    2s 
    Page Should Contain    Error: Incorrect username or password! Please try again.
    [Teardown]    Close Browser

CreateNewAccount
    Open Browser    
    Go To Site
    Click Create Button
    Wait Until Page Contains    Create New Account
    Input Text    id=name    John Doe
    Input Text    id=username    john_doe123
    Input Text    id=password    securePassword123
    Click Element    id=createNewAccButton
    Go To Create New Capstone Entry Page
    Title Should Be   TSA Office Records Systems
    Click Element    ${create_entry_name}
    Sleep    2s
    Clear Element Text   ${create_entry_name}    
    Sleep    2s
    Click Element    ${create_entry_no_of_students}
    Sleep    2s
    Clear Element Text   ${create_entry_no_of_students}
    Sleep    2s
    Click Element    ${create_entry_academic_year}
    Sleep    2s
    Clear Element Text    ${create_entry_academic_year}
    Sleep    2s
    Click Element    ${create_entry_capstone_title}
    Sleep    2s
    Clear Element Text    ${create_entry_capstone_title}
    Sleep    2s
    Click Element    ${create_entry_name_of_company}
    Sleep    2s
    Clear Element Text    ${create_entry_name_of_company}
    Sleep    2s
    Click Element    ${create_entry_companyPOC}
    Sleep    2s
    Clear Element Text    ${create_entry_companyPOC}
    Sleep    2s
    Click Element    ${create_entry_project_description}
    Sleep    2s
    Clear Element Text   ${create_entry_project_description}
    Sleep    2s
    Click Button    ${create_entry_save}    
    Capture Page Screenshot
    [Teardown]    Close Browser


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

Go To Create New Capstone Entry Page
    Go To    ${create_entry_url}

Input Username
    [Arguments]    ${username}
    Input Text    id=username    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    id=password    ${password}

Submit Login
    Click Element    id=loginButton

Click Create Button
    Click Element    id=newAccountButton

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