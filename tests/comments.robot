*** Settings ***
Documentation               Comments endpoint read tests

Resource                    ../resources/base.resource

Suite Setup                 Create API Session
Suite Teardown              Delete All Sessions

*** Test Cases ***
Get All Comments Returns The Documented Collection
    [Tags]                   smoke    regression    positive
    ${response}              Get Resource Collection    comments
    ${comments}              Set Variable    ${response.json()}
    ${first_comment}         Get From List    ${comments}    0

    Should Be Equal As Integers    ${response.status_code}    200
    Length Should Be               ${comments}    500
    Should Be Equal As Integers    ${first_comment}[id]    1
    Dictionary Should Contain Key  ${first_comment}    postId
    Dictionary Should Contain Key  ${first_comment}    email
    Dictionary Should Contain Key  ${first_comment}    body

Get A Comment By ID Returns Its JSON Resource
    [Tags]                   regression    positive
    ${fixture}               Load Fixture Data    comments.json
    ${comment_id}            Get JSON Value    ${fixture}    existing_comment_id
    ${response}              Get Resource By ID    comments    ${comment_id}
    ${comment}               Set Variable    ${response.json()}

    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Integers    ${comment}[id]    ${comment_id}
    Dictionary Should Contain Key  ${comment}    postId
    Dictionary Should Contain Key  ${comment}    email
    Dictionary Should Contain Key  ${comment}    body

Get A Nonexistent Comment Returns Not Found
    [Tags]                   regression    negative
    ${fixture}               Load Fixture Data    comments.json
    ${missing_id}            Get JSON Value    ${fixture}    missing_comment_id
    ${response}              Get Resource By ID    comments    ${missing_id}

    Should Be Equal As Integers    ${response.status_code}    404
    Should Be Equal               ${response.json()}    ${{dict()}}
