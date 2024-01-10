*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        chrome
${URL}            http://localhost:8080
@{CHROME_OPTIONS}  headless  disable-gpu  window-size=1920,1080  ignore-certificate-errors  disable-extensions  no-sandbox  disable-dev-shm-usage

*** Test Cases ***
Open Website
    Open Browser
    Go To Site
    Title Should Be    TSA Office Records Systems
    [Teardown]  Close Browser

*** Keywords ***
Open Browser
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    FOR    ${arg}    IN    @{CHROME_OPTIONS}
        Call Method    ${options}    add_argument    ${arg}
    END
    Create Webdriver    Chrome    options=${options}

Go To Site
    Go To    ${URL}