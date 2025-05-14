*** Settings ***
Documentation        This file contains basic test cases to explore Integration API tests.

Resource             ../resources/keywords.robot
Resource             ../resources/variables.robot

Suite Setup          Create Session On Mock Server
Suite Teardown       Delete All Sessions



*** Test Cases ***
0.1 Testing Main Requests From Mock API (Positive)
    Create New Inmate Booking
    List All Inmate Bookings
    List Specific Inmate Booking
    Update Existing Inmate Booking
    Delete Inmate Booking


# 0.2 Testing Main Requests From Mock API (Negative)
