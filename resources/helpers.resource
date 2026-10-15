*** Settings ***
Documentation               Test data and JSON response helpers

Library                     Collections
Library                     JSONLibrary

*** Keywords ***
Load Fixture Data
    [Arguments]              ${fixture_file}

    ${fixture}               Load Json From File
    ...                      ${EXECDIR}/resources/fixtures/${fixture_file}
    ...                      encoding=UTF-8
    RETURN                   ${fixture}

Get JSON Value
    [Arguments]              ${json_object}    ${key}

    ${value}                 Get From Dictionary    ${json_object}    ${key}
    RETURN                   ${value}
