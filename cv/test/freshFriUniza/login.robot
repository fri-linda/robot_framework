*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BASE URL}                 https://fresh.fri.uniza.sk
${LOGIN URL}                ${BASE URL}/login

# Input data
${USERNAME}                 #TODO
${PASSWORD}                 #TODO
${SCREENSHOT_NAME}          user.png


# Locators
${USERNAME_FIELD}        xpath=//input[@type='text']
${PASSWORD_FIELD}        id=password
${LOGIN_BUTTON}          xpath=//button[@type='submit']
${WELCOME_MESSAGE}       xpath=//*[@id="app"]/div/div[1]/div[4]/div[2]
${FRI_LOGO}              xpath=//*[@id="app"]/div/div[1]/div[1]/div[1]/a
${LOGOUT_BUTTON}         xpath=//*[@id="app"]/div/div[6]/div[2]/div/span/span/a/span/span

# Output data
${EX_WELCOME_MESSAGE_VALUE}    Student

*** Keywords ***
Open Browser And Navigate To Login
    Open Browser    ${LOGIN URL}    Chrome
    Maximize Browser Window

Login As Student
    Wait Until Element Is Visible    ${USERNAME_FIELD}    timeout=10s
    Input Text    ${USERNAME_FIELD}    ${USERNAME}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Capture element screenshot  ${USERNAME_FIELD}    ${SCREENSHOT_NAME}
    Click Button    ${LOGIN_BUTTON}

Verify Login Success
    Wait Until Element Contains    ${WELCOME_MESSAGE}    ${EX_WELCOME_MESSAGE_VALUE}    timeout=10s

Log Out
    Click Element    ${FRI_LOGO}
    Wait Until Element Is Visible    ${LOGOUT_BUTTON}    timeout=10s
    Click Element    ${LOGOUT_BUTTON}

*** Test Cases ***
Verify Login Button Behavior
    [Documentation]    This test case should test login functionality on fresh.fri.uniza.sk with valid login data
    [Tags]  login

    [Setup]    Open Browser And Navigate To Login

    Login As Student
    Verify Login Success
    Log Out

    [Teardown]    Close Browser




