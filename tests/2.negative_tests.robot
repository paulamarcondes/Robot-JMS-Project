*** Settings ***
Documentation     This file verifies the APIs ability to handle invalid data inputs and operations on nonexistent inmate records.

Resource         ../resources/keywords.robot
Resource         ../resources/variables.robot

Suite Setup      Create Session On Mock Server
Suite Teardown   Delete All Sessions



*** Test Cases ***
2.1 Fail to Create Inmate With Missing Required Fields
    Generate Incomplete Inmate Data
    Send Invalid Booking Request And Expect 400

2.2 Fail to Create Inmate With Invalid Date Format
    Generate Inmate With Invalid Date Format
    Send Invalid Booking Request And Expect 400

2.3 Fail to Retrieve Inmate With Malformed ID
    Request Inmate Using Invalid ID
    Verify Response Is 404 Not Found

2.4 Fail to Update Inmate That Does Not Exist
    Try Updating Inmate With Invalid ID
    Verify Response Is 404 Not Found

2.5 Fail to Delete Inmate That Does Not Exist
    Try Deleting Inmate With Invalid ID
    Verify Response Is 404 Not Found