*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
URL Test
    Open Browser    https://google.com    Google Chrome
    Title Should Be    Google