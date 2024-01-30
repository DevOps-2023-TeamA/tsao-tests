*** Settings ***
Library           SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Dialogs
Library    RequestsLibrary
Documentation       The test cases are used to test the functionality of the features in TSAO Capstone Records Webpage.
Resource    variables.robot

*** Variables ***
${URL}            http://localhost:8080
@{CHROME_OPTIONS}  headless  disable-gpu  window-size=1920,1080  ignore-certificate-errors  disable-extensions  no-sandbox  disable-dev-shm-usage
@{FIREFOX_OPTIONS}  headless  disable-gpu  window-size=1920,1080

*** Test Cases ***
Open Website
    Open Browser    
    Go To Site
    Title Should Be    TSA Office Records Systems
    Capture Page Screenshot
    [Teardown]  Close Browser

Check Response When Valid Inputs are Entered into Create New Entry Page
    Open Browser
    Go To Create New Capstone Entry Page
    Title Should Be   TSA Office Records Systems
    Capture Page Screenshot
    Click Element    ${create_entry_name}
    Sleep    5s
    Input Text   ${create_entry_name}    Low KH
    Sleep    5s
    Click Button    ${create_entry_role_student}
    Sleep    5s
    Click Element    ${create_entry_no_of_students}
    Sleep    5s
    Input Text   ${create_entry_no_of_students}    5
    Sleep    5s
    Click Element    ${create_entry_academic_year}
    Sleep    5s
    Input Text    ${create_entry_academic_year}    2022/23
    Sleep    5s
    Click Element    ${create_entry_capstone_title}
    Sleep    5s
    Input Text    ${create_entry_capstone_title}    DevOps Project
    Sleep    5s
    Click Element    ${create_entry_name_of_company}
    Sleep    5s
    Input Text    ${create_entry_name_of_company}    ABC Pte Ltd
    Sleep    5s
    Click Element    ${create_entry_companyPOC}
    Sleep    5s
    Input Text    ${create_entry_companyPOC}    Tan BB
    Sleep    5s
    Click Element    ${create_entry_project_description}
    Sleep    5s
    Input Text    ${create_entry_project_description}    I LOVE DevOps.
    Sleep    5s
    Click Button    ${create_entry_save}
    Capture Page Screenshot
    Sleep    5s    
    [Teardown]    Close Browser
Check Response When Invalid Inputs are Entered into Create New Entry Page
    Open Browser
    Go To Create New Capstone Entry Page
    Title Should Be   TSA Office Records Systems
    Capture Page Screenshot
    Click Element    ${create_entry_name}
    Sleep    5s
    Input Text   ${create_entry_name}    Low!23
    Sleep    5s
    Click Element    ${create_entry_no_of_students}
    Sleep    5s
    Input Text   ${create_entry_no_of_students}    ZXC
    Sleep    5s
    Click Element    ${create_entry_academic_year}
    Sleep    5s
    Input Text    ${create_entry_academic_year}    ZXC
    Sleep    5s
    Click Element    ${create_entry_capstone_title}
    Sleep    5s
    Input Text    ${create_entry_capstone_title}    ${invalid_varchar100}
    Sleep    5s
    Click Element    ${create_entry_name_of_company}
    Sleep    5s
    Input Text    ${create_entry_name_of_company}    ${invalid_varchar100}
    Sleep    5s
    Click Element    ${create_entry_companyPOC}
    Sleep    5s
    Input Text    ${create_entry_companyPOC}    ${invalid_varchar100}
    Sleep    5s
    Click Element    ${create_entry_project_description}
    Sleep    5s
    Input Text    ${create_entry_project_description}    ${invalid_varchat500}
    Sleep    5s
    Click Button    ${create_entry_save}    
    Capture Page Screenshot
    Sleep    5s
    [Teardown]    Close Browser

Check Response When No Input is Entered into Create New Entry Page
    Open Browser
    Go To Create New Capstone Entry Page
    Title Should Be   TSA Office Records Systems
    Capture Page Screenshot
    Click Element    ${create_entry_name}
    Sleep    5s
    Clear Element Text   ${create_entry_name}    
    Sleep    5s
    Click Element    ${create_entry_no_of_students}
    Sleep    5s
    Clear Element Text   ${create_entry_no_of_students}
    Sleep    5s
    Click Element    ${create_entry_academic_year}
    Sleep    5s
    Clear Element Text    ${create_entry_academic_year}
    Sleep    5s
    Click Element    ${create_entry_capstone_title}
    Sleep    5s
    Clear Element Text    ${create_entry_capstone_title}
    Sleep    5s
    Click Element    ${create_entry_name_of_company}
    Sleep    5s
    Clear Element Text    ${create_entry_name_of_company}
    Sleep    5s
    Click Element    ${create_entry_companyPOC}
    Sleep    5s
    Clear Element Text    ${create_entry_companyPOC}
    Sleep    5s
    Click Element    ${create_entry_project_description}
    Sleep    5s
    Clear Element Text   ${create_entry_project_description}
    Sleep    5s
    Click Button    ${create_entry_save}    
    Capture Page Screenshot
    Sleep    5s
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
    [Return]    ${options}
    RETURN    ${options}

Set Firefox Options
    [Arguments]    ${options}
    FOR    ${arg}    IN    @{FIREFOX_OPTIONS}
        Call Method    ${options}    add_argument    ${arg}
    END
    [Return]    ${options}
    RETURN    ${options}

Go To Site
    Go To    ${URL}

Go To Create New Capstone Entry Page
    Go To    ${create_entry_url}