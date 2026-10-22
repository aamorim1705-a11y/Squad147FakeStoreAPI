# Settings e Keywords
*** Settings ***
Library    RequestsLibrary

*** Keywords ***
Post Login
    [Arguments]    ${url}

    ${body}    Create Dictionary    username=mor_2314    password=83r5^_
    ${response}    POST    url=${url}/auth/login    json=${body}

    Status Should Be    201
    ${token}    Set Variable    ${response.json()}[token]
    Set Suite Variable    ${token}
    Log To Console    Login realizado com sucesso