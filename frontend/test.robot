*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
URL Test
    Open Headless Chrome Browser
    Open Browser    https://google.com    Google Chrome
    Title Should Be    Google
    Close Browser

*** Keywords ***
Open Headless Chrome Browser
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Set Window Size    1920    1080
