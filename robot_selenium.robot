*** Settings ***
Library    Selenium2Library

*** Variables ***
${SERVER}    poczta.wp.pl
${BROWSER}    Firefox
${DELAY}    0
${VALID_USER}    testerwsb_t1
${VALID_PASSWORD}    adam1234
${LOGIN_URL}    https://${SERVER}/
${LOGIN_FIELD}    //*[@id="login"]
${PASSWORD_FIELD}    //*[@id="password"]
${LOGIN_BUTTON}    //*[@id="btnSubmit"]
${ASSERT_TEXT}    //*[@title="Odebrane"]

*** Test Cases ***
TC_01 - LogIn to mail server - valid user
    Open Browser To Login Page
    Input UserName    ${VALID_USER}
    Input Password    ${VALID_PASSWORD}
    Submit credentials
    Sleep    5
    Assert Text    Odebrane
    Close All Browsers

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

Input UserName
    [Arguments]    ${username}
    Input Text    ${LOGIN_FIELD}    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    ${PASSWORD_FIELD}    ${password}

Submit credentials
    Click Button    ${LOGIN_BUTTON}

Assert Text
    [Arguments]    ${assert_text}
    Page Should Contain    ${ASSERT_TEXT}    ${assert_text}
