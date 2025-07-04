*** Settings ***
# Bibliotecas e Configurações
Library    RequestsLibrary

*** Variables ***
# Objetos, atributos e variaveis
${url}    https://petstore.swagger.io/v2/user

${id}             173549301                     
${username}       donmartin
${firstname}      Don
${lastname}       Martin
${email}          don.martin@bol.com
${password}       pass123
${phone}          17275000213
${user_status}    0

*** Test Cases ***
# Descritivo de Negocio + Passos de Automação
Post user
    # montar a mensagem/body
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
    Should Be Equal    ${response_body}[message]    ${id}
    

Get user
    # executar
    ${response}    GET    ${{$url + '/' + $username}}
    
    #validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]                ${{int($id)}}
    Should Be Equal    ${response_body}[username]          ${username}
    Should Be Equal    ${response_body}[firstName]         ${firstname}
    Should Be Equal    ${response_body}[lastName]          ${lastname}
    Should Be Equal    ${response_body}[email]             ${email}
    Should Be Equal    ${response_body}[phone]             ${phone}
    

Put user
    # montar a mensage/body com a mudança
    ${body}    Evaluate    json.loads(open('./fixtures/json/user2.json').read())

    # executar
    ${response}    PUT    ${{$url + '/' + $username}}    json=${body}

    # validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]       ${{int(200)}}
    Should Be Equal    ${response_body}[type]       unknown
    Should Be Equal    ${response_body}[message]    ${id}

Delete user
    #executar
    ${response}    DELETE    ${{$url + '/' + $username}}

    #validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]       ${{int(200)}}
    Should Be Equal    ${response_body}[type]       unknown
    Should Be Equal    ${response_body}[message]    ${username}

*** Keywords ***
# Descritivo de Negocio (se estruturar separadamente)
# DSL = Domain Specific Language = Linguagem Especifica de Dominio