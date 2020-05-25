***Settings***
Documentation       POST /auth
...                 Testes do serviço de autorização

Resource            ../../resources/services.robot

**Test Cases***
Successfuly Login
    ${payload}=         Get Json        login_ok.json

    ${resp}=            Post Token      ${payload}           

    Status Should Be    200     ${resp}

Incorrect Password
    ${payload}=         Create Dictionary   email=cintia@ninjapixel.com         pass=${EMPTY}

    ${resp}=            Post Token    ${payload}   

    Status Should Be    401     ${resp}
