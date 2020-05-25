***Settings***
Documentation       GET /products
...                 Consulta de produtos consumindo a API

Resource            ../../resources/services.robot

Suite Setup         Set Suite Var Auth Token  ${user_email}   ${user_pass}

**Test Cases***
Get Unique product
    [tags]      success

    ${payload}=         Get Json        get_unique.json
    ${unique}=          Post Product    ${payload}        before_remove

    ${id}=              Convert To String           ${unique.json()['id']}

    ${resp}=            Get Product     ${id}

    Status Should Be    200             ${resp}

    Should Be Equal     ${resp.json()['title']}     ${payload['title']} 

Product Not Found
    [tags]      not_found

    ${resp}=        Get Product     1500

    Status Should Be    404             ${resp}

Get Product List
    [tags]      success

    ${list}=        Get Json        list.json
    ${items}=       Set Variable    ${list['data']}

    FOR         ${item}     IN      @{items}
        Post Product    ${item}     before_ remove
    END

    ${resp}=        Get Products

    Status Should Be    200             ${resp}
    Should Not Be Empty                 ${resp.json()['data']}