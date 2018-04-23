*** Settings ***
Library    Selenium2Library

*** Variables ***
${SERVER}    github.com/
${BROWSER}    Firefox
${DELAY}    4
${VALID_USER}    just-for-test-login
${VALID_PASSWORD}    tester123
${NOT_VALID_PASSWORD}    tester1234
${LOGIN_URL}    https://${SERVER}/

${SIGNIN_MAINSITE_BTN}    //*[@href="/login"]
${SIGNIN_LOGINSITE_BTN}    //*[@value="Sign in"]
${LOGIN_FIELD}    //*[@id="login_field"]
${PASSWORD_FIELD}    //*[@id="password"]
${ASSERT_TEXT_AT_LOGINSITE}    //h1[contains(.,'Sign in to GitHub')]
${ASSERT_TEXT_AFTER_LOGIN}    //*[@class="shelf-title"]
${ALERT_TEXT_WRONG_PASSWORD}    //*[@class='container']

*** Test Cases ***
TC_01 - Try to LogIn to Github.com using valid credentials
    Open Browser And Maximize
    Capture Page Screenshot
    Click SignIn Button At Mainsite
    Wait few seconds
    Verify Text Present Login Site    Sign in to GitHub
    Capture Page Screenshot
    Input Valid UserName    ${VALID_USER}
    Input Valid Password    ${VALID_PASSWORD}
    Click SignIn Button At LoginSite
    Wait few seconds
    Verify Text Present After Correct Login    Learn Git and GitHub without any code!
    Capture Page Screenshot
    Close All Browsers

TC_02 - Try to LogIn to Github.com using NOT valid credentials
    Open Browser And Maximize
    Capture Page Screenshot
    Click SignIn Button At Mainsite
    Wait few seconds
    Verify Text Present Login Site    Sign in to GitHub
    Capture Page Screenshot
    Input Valid UserName    ${VALID_USER}
    Input Not Valid Password    ${NOT_VALID_PASSWORD}
    Click SignIn Button At LoginSite
    Wait few seconds
    Verify Wrong Password Alert Present
    Capture Page Screenshot
    Close All Browsers

*** Keywords ***
Open Browser And Maximize
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

Click SignIn Button At Mainsite
    Click Element    ${SIGNIN_MAINSITE_BTN}

Verify Text Present Login Site
    [Arguments]    ${text_at_login_site}
    Element Should Contain    ${ASSERT_TEXT_AT_LOGINSITE}    ${text_at_login_site}

Input Valid UserName
    [Arguments]    ${username}
    Input Text    ${LOGIN_FIELD}    ${username}

Input Valid Password
    [Arguments]    ${password}
    Input Text    ${PASSWORD_FIELD}    ${password}

Input Not Valid Password
    [Arguments]    ${wrong_password}
    Input Text    ${PASSWORD_FIELD}    ${wrong_password}

Click SignIn Button At LoginSite
    Click Element   ${SIGNIN_LOGINSITE_BTN}


Verify Text Present After Correct Login
    [Arguments]    ${text_correct_login}
    Element Should Contain    ${ASSERT_TEXT_AFTER_LOGIN}    ${text_correct_login}

Verify Wrong Password Alert Present
    Element Should Be Visible    //*[@class='container']

Wait few seconds
    Sleep    ${DELAY}
