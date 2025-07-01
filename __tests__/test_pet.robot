*** Settings ***
# Bibliotecas e Configurações
Library    RequestsLibrary

*** Variables ***
# Objetos, atributos e variaveis
${url}    https://petstore.swagger.io/v2/pet

${id}    17354901                     # $ variavel simples
${pet_name}    Luke
&{category}    id=1    name=cachorro  # & lista com campos fixos
@{photoUrls}                          # @ lista com varios registros
&{tag}    id=1    name=vacinado
@{tags}    ${tag}                     # lista de outras listas
${status}    available

*** Test Cases ***
# Descritivo de Negocio + Passos de Automação
Post pet
    # montar a mensagem/body
    ${body}    Create Dictionary    id=${id}    category=${category}    name=${pet_name}    
    ...                             photoUrls=${photoUrls}    tags=${tags}    status=${status}
    
    # executar
    ${response}    POST    url=${url}    json=${body}

    # validar
    ${response_body}    Set Variable    ${response.json()}    # Recebe o conteudo da outra variavel
    Log To Console      ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]               ${{int($id)}}
    Should Be Equal    ${response_body}[name]             ${pet_name}
    Should Be Equal    ${response_body}[tags][0][id]      ${{int(${tag}[id])}}
    Should Be Equal    ${response_body}[tags][0][name]    ${tag}[name]
    Should Be Equal    ${response_body}[status]           ${status}

Get pet
    # executar
    ${response}    GET    ${{$url + '/' + $id}}
    
    #validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]                ${{int($id)}}
    Should Be Equal    ${response_body}[name]              ${pet_name}
    Should Be Equal    ${response_body}[category][id]      ${{int(${category}[id])}}
    Should Be Equal    ${response_body}[category][name]    ${category}[name]
    

Put pet
    # montar a mensage/body com a mudança
    ${body}    Evaluate    json.loads(open('./fixtures/json/pet2.json').read())

    # executar
    ${response}    PUT    url=${url}    json=${body}

    # validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]                ${{int($id)}}
    Should Be Equal    ${response_body}[category][id]      ${{int(${category}[id])}}
    Should Be Equal    ${response_body}[category][name]    ${category}[name]
    Should Be Equal    ${response_body}[name]              ${pet_name}
    Should Be Equal    ${response_body}[tags][0][id]       ${{int(${tag}[id])}}
    Should Be Equal    ${response_body}[tags][0][name]     ${tag}[name]
    Should Be Equal    ${response_body}[status]            sold

Delete pet
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