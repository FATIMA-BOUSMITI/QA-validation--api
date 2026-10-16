*** Settings ***
Documentation               Users endpoint read tests

Resource                    ../resources/base.resource

Suite Setup                 Create API Session
Suite Teardown              Delete All Sessions

*** Test Cases ***
Get All Users Returns The Documented Collection
    [Tags]                   smoke    regressi     positive
    ${response}              Get Resource Collection    users
    ${users}                 Set Variable    ${response.json()}
    ${first_user}            Get From List    ${users}    0

    Should Be Equal As Integers    ${response.status_code}    200
    Length Should Be               ${users}    10
    Should Be Equal As Integers    ${first_user}[id]    1
    Dictionary Should Contain Key  ${first_user}    name
    Dictionary Should Contain Key  ${first_user}    email

Get A User By ID Returns Its JSON Resource
    [Tags]                   regression    positive
    ${fixture}               Load Fixture Data    users.json
    ${user_id}               Get JSON Value    ${fixture}    existing_user_id
    ${response}              Get Resource By ID    users    ${user_id}
    ${user}                  Set Variable    ${response.json()}

    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Integers    ${user}[id]    ${user_id}
    Dictionary Should Contain Key  ${user}    username
    Dictionary Should Contain Key  ${user}    email

Get A Nonexistent User Returns Not Found
    [Tags]                   regression    negative
    ${fixture}               Load Fixture Data    users.json
    ${missing_id}            Get JSON Value    ${fixture}    missing_user_id
    ${response}              Get Resource By ID    users    ${missing_id}

    Should Be Equal As Integers    ${response.status_code}    404
    Should Be Equal               ${response.json()}    ${{dict()}}
Get User With Invalid ID
    [Documentation]    Verify API behavior when user ID is not numeric
    [Tags]    regression    negative    invalid-input

    ${response}=    Get Resource By ID    users    abc

    Should Be Equal As Integers    ${response.status_code}    404
    Should Be Equal    ${response.json()}    ${{dict()}}
Get User With Negative ID
    [Documentation]    Verify API behavior with a negative user ID
    [Tags]    regression    negative    boundary

    ${response}=    Get Resource By ID    users    -1

    Should Be Equal As Integers    ${response.status_code}    404
    Should Be Equal    ${response.json()}    ${{dict()}}
Get Unknown Resource Returns 404
    [Documentation]    Verify behavior for an unknown endpoint
    [Tags]    regression    negative

    ${response}=    Get Resource Collection    unknownresource

    Should Be Equal As Integers    ${response.status_code}    404
    