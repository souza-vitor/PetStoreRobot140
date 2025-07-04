*** Settings ***
Library    RequestsLibrary
Library    DataDriver    ../fixtures/csv/delete_users.csv    dialect=excel
Variables    ../resources/variables.py
Test Template    Delete user DDT


*** Test Cases ***
TC001    ${username}


*** Keywords ***
Delete user DDT
    # configura
    [Arguments]    ${username}

    # executar
    ${response}    DELETE    ${{$url + '/' + $username}}

    #validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]       ${{int(200)}}
    Should Be Equal    ${response_body}[type]       unknown
    Should Be Equal    ${response_body}[message]    ${username}