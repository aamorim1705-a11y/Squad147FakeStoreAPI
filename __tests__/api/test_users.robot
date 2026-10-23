# Casos de Teste
*** Settings ***
Library    RequestsLibrary
Library    Collections
Variables    ../../resources/variables.py

*** Test Cases ***
Post User
    ${headers}    Create Dictionary    Content-Type=${content_type}
    ${body}    Evaluate    json.loads(open('../../fixtures/json/users1.json').read())

     # Validar os dados enviados
    Should Be Equal    ${body}[username]    ${username}
    Should Be Equal    ${body}[email]       ${email}
    Should Be Equal    ${body}[password]    ${password}

    ${response}    POST    url=${url}/users    json=${body}    headers=${headers}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    Status: ${response.status_code}
    Log To Console    Body: ${response.text}

    # 1. Validar o status HTTP
    Status Should Be    201    ${response}

    # 2. Validar a existência do ID
    Dictionary Should Contain Key    ${response_body}    id
    Should Be True    ${response_body}[id] > 0

Get Sigle User
    ${response}    GET    url=${url}/users/${user_id}   

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    Status: ${response.status_code}

    # 1. Validar o status HTTP
    Status Should Be    200    ${response}

    # 2. Validar os dados de negócio
    Should Be Equal As Integers    ${response_body}[id]    ${user_id}
    Should Be Equal    ${response_body}[username]           ${get_username}
    Should Be Equal    ${response_body}[email]         ${get_email}
    
Update User
    ${body}    Create Dictionary    id=${update_user_id}    username=${update_username}    email=${update_email}    password=${update_password}

    ${response}    PUT    url=${url}/users/${update_user_id}    json=${body}    
    
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    Status: ${response.status_code}
    Log To Console    User updated successfully

    # 1. Validar o status HTTP
    Status Should Be    200    ${response}

    # 2. Validar a existência do ID
    Dictionary Should Contain Key    ${response_body}    id

    # 3. Validar os dados de negócio
    Should Be Equal As Integers    ${response_body}[id]    ${update_user_id}
    Should Be Equal    ${response_body}[username]           ${update_username}
    Should Be Equal    ${response_body}[email]         ${update_email}
    
    