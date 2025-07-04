*** Settings ***
Library    RequestsLibrary
Library    DataDriver    ../fixtures/csv/users.csv    dialect=excel
Variables    ../resources/variables.py
Test Template    Post user DDT


*** Test Cases ***
TC001    ${id}    ${username}    ${firstname}    ${lastname}    ${email}    ${password}    ${phone}    ${user_status}


*** Keywords ***
Post user DDT
    # configura
    [Arguments]    ${id}     ${username}     ${firstname}     ${lastname}     ${email}     ${password}     ${phone}     ${user_status}

    ${id}    Convert To Integer    ${id}
    ${user_status}    Convert To Integer    ${user_status}

    ${body}    Create Dictionary    id=${id}    username=${username}    firstName=${firstname}    
    ...                             lastName=${lastname}    email=${email}    password=${password}    phone=${phone}    userStatus=${user_status}
    
    # executar
    ${response}    POST    url=${url}    json=${body}

    # validar
    ${response_body}    Set Variable    ${response.json()}    # Recebe o conteudo da outra variavel
    Log To Console      ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]       ${{int(200)}}
    Should Be Equal    ${response_body}[type]       unknown
    Should Be Equal    ${response_body}[message]    ${{str($id)}}