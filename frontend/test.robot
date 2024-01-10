*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        chrome
${URL}            http://google.com
@{CHROME_OPTIONS}  headless  disable-gpu  window-size=1920,1080  ignore-certificate-errors  disable-extensions  no-sandbox  disable-dev-shm-usage

*** Test Cases ***
Open Website And Print Title
    Open Browser
    Go To Site
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