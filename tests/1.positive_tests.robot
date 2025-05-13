*** Settings ***
Documentation    This file contains the test cases for the present mini-project.

Resource         ../resources/keywords.robot
Resource         ../resources/variables.robot

Suite Setup      Create Session On Mock Server
Suite Teardown   Delete All Sessions



*** Test Cases ***
1.1 Validate Successful Booking Response
    Generate Random Booking Data
    Send Valid Booking Request
    Validate POST Successful Response

1.2 Verify Inmate By Booking ID Returns Correct Data
    List All Inmate Bookings
    Choose Random Inmate Booking
    Validate GET Successful Response

1.3 Confirm Booking Sync With RMS
    Generate Random Booking Data
    Send Valid Booking Request
    Retrieve Booking ID From Request
    Compare Booking Record With RMS

1.4 Validate All Required Fields From Booking Response
    Generate Random Booking Data
    Send Valid Booking Request
    Validate POST All Fields Response

1.5 Delete Inmate Booking Successfully
    List All Inmate Bookings
    Choose Random Inmate Booking
    Delete Inmate Booking