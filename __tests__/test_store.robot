*** Settings ***
# Bibliotecas e Configurações
Library    RequestsLibrary

*** Variables ***
# Objetos, atributos e variaveis
${url}    https://petstore.swagger.io/v2/store/order

${id}             1735499001                     
${pet_id}         173549035
${quantity}       1
${ship_date}      2025-07-03T12:32:10.613+0000
${status}         placed
${complete}       True

*** Test Cases ***
# Descritivo de Negocio + Passos de Automação
Post store
    # montar a mensagem/body
    ${body}    Create Dictionary    id=${id}    petId=${pet_id}    quantity=${quantity}    
    ...                             shipDate=${ship_date}    status=${status}    complete=${complete}
    
    # executar
    ${response}    POST    url=${url}    json=${body}

    # validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console      ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]             ${{int($id)}}
    Should Be Equal    ${response_body}[shipDate]       ${ship_date}
    Should Be Equal    ${response_body}[complete]       ${{bool($complete)}}
    

Get store
    # executar
    ${response}    GET    ${{$url + '/' + $id}}
    
    #validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]                ${{int($id)}}
    Should Be Equal    ${response_body}[petId]             ${{int($pet_id)}}
    Should Be Equal    ${response_body}[shipDate]          ${ship_date}
    
Delete store
    #executar
    ${response}    DELETE    ${{$url + '/' + $id}}

    #validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]       ${{int(200)}}
    Should Be Equal    ${response_body}[type]       unknown
    Should Be Equal    ${response_body}[message]    ${id}

*** Keywords ***
# Descritivo de Negocio (se estruturar separadamente)
# DSL = Domain Specific Language = Linguagem Especifica de Dominio