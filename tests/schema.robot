*** Settings ***
Documentation               JSON Schema validation for public API resources

Resource                    ../resources/base.resource

Suite Setup                 Create API Session
Suite Teardown              Delete All Sessions

*** Test Cases ***
Posts Collection Matches Its JSON Schema
    [Tags]                   regression    positive    schema
    ${response}              Get Resource Collection    posts

    Should Be Equal As Integers    ${response.status_code}    200
    Validate Json By Schema File
    ...                      ${response.json()}
    ...                      ${EXECDIR}/resources/schemas/posts.json

Users Collection Matches Its JSON Schema
    [Tags]                   regression    positive    schema
    ${response}              Get Resource Collection    users

    Should Be Equal As Integers    ${response.status_code}    200
    Validate Json By Schema File
    ...                      ${response.json()}
    ...                      ${EXECDIR}/resources/schemas/users.json

Comments Collection Matches Its JSON Schema
    [Tags]                   regression    positive    schema
    ${response}              Get Resource Collection    comments

    Should Be Equal As Integers    ${response.status_code}    200
    Validate Json By Schema File
    ...                      ${response.json()}
    ...                      ${EXECDIR}/resources/schemas/comments.json
