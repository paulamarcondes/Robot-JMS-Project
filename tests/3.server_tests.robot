*** Settings ***
Documentation     This file simulates server-side failures and ensures the system correctly handles downtime or unexpected backend errors.

Resource         ../resources/keywords.robot
Resource         ../resources/variables.robot

Suite Setup      Create Session On Mock Server
Suite Teardown   Delete All Sessions



*** Test Cases ***
3.1 Handle Server Down During Inmate Creation
    [Documentation]    Manually stop the Flask server before running this test.
    Simulate Server Down
    Try Creating Inmate Booking
    Verify Connection Error Or Status 500

3.2 Handle Server Down During Inmate Retrieval
    Simulate Server Down
    Try Getting Inmate By ID
    Verify Connection Error Or Status 500