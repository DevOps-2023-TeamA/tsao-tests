*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}            http://localhost:8080
@{CHROME_OPTIONS}  headless  disable-gpu  window-size=1920,1080  ignore-certificate-errors  disable-extensions  no-sandbox  disable-dev-shm-usage
@{FIREFOX_OPTIONS}  headless  disable-gpu  window-size=1920,1080

*** Test Cases ***
Open Website
    Open Browser    ${browser}
    Go To Site
    Title Should Be    TSA Office Records Systems
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