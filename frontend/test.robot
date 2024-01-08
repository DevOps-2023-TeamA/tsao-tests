*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
URL Test
    Open Browser    https://google.com    chrome
    Title Should Be    Google