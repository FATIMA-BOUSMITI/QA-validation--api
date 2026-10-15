*** Settings ***
Documentation               HTTP operations for JSONPlaceholder resources

Library                     RequestsLibrary
Resource                    helpers.resource

*** Keywords ***
Get Resource Collection
    [Arguments]              ${resource}

    ${response}              GET On Session
    ...                      alias=${SESSION_ALIAS}
    ...                      url=/${resource}
    ...                      expected_status=any
    RETURN                   ${response}

Get Resource By ID
    [Arguments]              ${resource}    ${resource_id}

    ${response}              GET On Session
    ...                      alias=${SESSION_ALIAS}
    ...                      url=/${resource}/${resource_id}
    ...                      expected_status=any
    RETURN                   ${response}

Create Resource
    [Arguments]              ${resource}    ${payload}

    ${response}              POST On Session
    ...                      alias=${SESSION_ALIAS}
    ...                      url=/${resource}
    ...                      json=${payload}
    ...                      expected_status=any
    RETURN                   ${response}

Replace Resource
    [Arguments]              ${resource}    ${resource_id}    ${payload}

    ${response}              PUT On Session
    ...                      alias=${SESSION_ALIAS}
    ...                      url=/${resource}/${resource_id}
    ...                      json=${payload}
    ...                      expected_status=any
    RETURN                   ${response}

Partially Update Resource
    [Arguments]              ${resource}    ${resource_id}    ${payload}

    ${response}              PATCH On Session
    ...                      alias=${SESSION_ALIAS}
    ...                      url=/${resource}/${resource_id}
    ...                      json=${payload}
    ...                      expected_status=any
    RETURN                   ${response}

Delete Resource
    [Arguments]              ${resource}    ${resource_id}

    ${response}              DELETE On Session
    ...                      alias=${SESSION_ALIAS}
    ...                      url=/${resource}/${resource_id}
    ...                      expected_status=any
    RETURN                   ${response}
