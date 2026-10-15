*** Settings ***
Documentation               Shared JSONPlaceholder API configuration

Resource                    services.resource

*** Variables ***
${BASE_URL}                 https://jsonplaceholder.typicode.com
${SESSION_ALIAS}            JSONPlaceholder
&{DEFAULT_HEADERS}          Accept=application/json

*** Keywords ***
Create API Session
    Create Session           alias=${SESSION_ALIAS}
    ...                      url=${BASE_URL}
    ...                      headers=${DEFAULT_HEADERS}
    ...                      verify=True
