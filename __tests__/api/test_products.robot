# Casos de Teste
*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource    ../../resources/common.resource
Variables    ../../resources/variables.py
Suite Setup    Post Login    ${url}

*** Test Cases ***
Post Products
    ${headers}    Create Dictionary    Content-Type=${content_type}
    ${body}    Evaluate    json.loads(open('../../fixtures/json/products1.json').read())

    ${response}    POST    url=${url}/products    json=${body}    headers=${headers}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    # 1. Validar o status HTTP
    Status Should Be    201    ${response}

    # 2. Validar a existência do ID
    Dictionary Should Contain Key    ${response_body}    id
    Should Be True    ${response_body}[id] > 0

    # 3. Validar os dados de negócio
    Should Be Equal    ${response_body}[title]           ${title}
    Should Be Equal    ${response_body}[price]         ${price}
    Should Be Equal    ${response_body}[description]        ${description}
    Should Be Equal    ${response_body}[category]    ${category}
    