*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}            http://localhost:8080
@{CHROME_OPTIONS}  headless  disable-gpu  window-size=1920,1080  ignore-certificate-errors  disable-extensions  no-sandbox  disable-dev-shm-usage
@{FIREFOX_OPTIONS}  headless  disable-gpu  window-size=1920,1080
${admin_username}    lkh2
${admin_password}    password
${user_username}    lkh
${user_password}    password

*** Test Cases ***
Open Website
    Open Browser    
    Go To Site
    Title Should Be    Login | TSAO Capstone Records System
    Capture Page Screenshot
    [Teardown]  Close Browser

Verify Login Page Opens Successfully
    [Setup]    Open Browser
    Go To Site
    Title Should Be    Login | TSAO Capstone Records System
    [Teardown]    Close Browser

Check Response for Valid Admin Credentials
    Open Browser
    Go To Site
    Input Username    ${admin_username}
    Input Password    ${admin_password}
    Submit Login
    Handle Alert    action=accept 
    Page Should Contain     Welcome to the TSAO Capstone Records System
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


#####################################################################GUOJUN
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