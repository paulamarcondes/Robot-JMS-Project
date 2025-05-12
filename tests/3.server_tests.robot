*** Settings ***
Documentation    This file contains the test cases for the present mini-project.

Resource         ../resources/keywords.robot
Resource         ../resources/variables.robot

Suite Setup      Create Session On Mock Server
Suite Teardown   Delete All Sessions



*** Test Cases ***
3.1 Handle RMS Unavailability Properly
    [Documentation]    Important: This Test expects server to be down, and will fail!
    Generate Random Booking Data
    Send Booking Request And Verify Error
    Confirm If Booking Was Saved Or Log Server Down