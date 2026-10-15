*** Settings ***
Documentation               Posts endpoint CRUD tests

Resource                    ../resources/base.resource

Suite Setup                 Create API Session
Suite Teardown              Delete All Sessions

*** Test Cases ***
Get All Posts Returns The Documented Collection
    [Tags]                   smoke    regression    positive
    ${response}              Get Resource Collection    posts
    ${posts}                  Set Variable    ${response.json()}
    ${first_post}             Get From List    ${posts}    0

    Should Be Equal As Integers    ${response.status_code}    200
    Length Should Be               ${posts}    100
    Should Be Equal As Integers    ${first_post}[id]    1
    Dictionary Should Contain Key  ${first_post}    title
    Dictionary Should Contain Key  ${first_post}    body
    Dictionary Should Contain Key  ${first_post}    userId

Get A Post By ID Returns Its JSON Resource
    [Tags]                   smoke    regression    positive
    ${fixture}               Load Fixture Data    posts.json
    ${post_id}               Get JSON Value    ${fixture}    existing_post_id
    ${response}              Get Resource By ID    posts    ${post_id}
    ${post}                  Set Variable    ${response.json()}
    ${returned_id}           Get JSON Value    ${post}    id

    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Integers    ${returned_id}    ${post_id}
    Dictionary Should Contain Key  ${post}    title
    Dictionary Should Contain Key  ${post}    body
    Dictionary Should Contain Key  ${post}    userId

Get A Nonexistent Post Returns Not Found
    [Tags]                   regression    negative
    ${fixture}               Load Fixture Data    posts.json
    ${missing_id}            Get JSON Value    ${fixture}    missing_post_id
    ${response}              Get Resource By ID    posts    ${missing_id}

    Should Be Equal As Integers    ${response.status_code}    404
    Should Be Equal               ${response.json()}    ${{dict()}}

Create A Post Returns The Submitted Data
    [Tags]                   regression    positive
    ${fixture}               Load Fixture Data    posts.json
    ${payload}               Get JSON Value    ${fixture}    create
    ${response}              Create Resource    posts    ${payload}
    ${created_post}          Set Variable    ${response.json()}

    Should Be Equal As Integers    ${response.status_code}    201
    Should Be Equal               ${created_post}[title]    ${payload}[title]
    Should Be Equal               ${created_post}[body]    ${payload}[body]
    Should Be Equal As Integers   ${created_post}[userId]    ${payload}[userId]
    Dictionary Should Contain Key    ${created_post}    id

Replace A Post Returns The Submitted Representation
    [Tags]                   regression    positive
    ${fixture}               Load Fixture Data    posts.json
    ${payload}               Get JSON Value    ${fixture}    replace
    ${post_id}               Get JSON Value    ${fixture}    existing_post_id
    ${response}              Replace Resource    posts    ${post_id}    ${payload}
    ${updated_post}          Set Variable    ${response.json()}

    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Integers    ${updated_post}[id]    ${post_id}
    Should Be Equal               ${updated_post}[title]    ${payload}[title]
    Should Be Equal               ${updated_post}[body]    ${payload}[body]
    Should Be Equal As Integers   ${updated_post}[userId]    ${payload}[userId]

Partially Update A Post Returns The Patched Field
    [Tags]                   regression    positive
    ${fixture}               Load Fixture Data    posts.json
    ${payload}               Get JSON Value    ${fixture}    patch
    ${post_id}               Get JSON Value    ${fixture}    existing_post_id
    ${response}              Partially Update Resource    posts    ${post_id}    ${payload}
    ${updated_post}          Set Variable    ${response.json()}

    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Integers    ${updated_post}[id]    ${post_id}
    Should Be Equal               ${updated_post}[title]    ${payload}[title]

Delete A Post Returns An Empty JSON Object
    [Tags]                   regression    positive
    ${fixture}               Load Fixture Data    posts.json
    ${post_id}               Get JSON Value    ${fixture}    existing_post_id
    ${response}              Delete Resource    posts    ${post_id}

    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal               ${response.json()}    ${{dict()}}
