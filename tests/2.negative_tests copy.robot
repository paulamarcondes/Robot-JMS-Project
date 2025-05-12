*** Settings ***
Documentation    This file contains the test cases for the present mini-project.

Resource         ../resources/keywords.robot
Resource         ../resources/variables.robot

Suite Setup      Create Session On Mock Server
Suite Teardown   Delete All Sessions



*** Test Cases ***
# 2.1 Handle Missing Required Fields in Booking Request
#     Generate Random Booking Data
#     Send Valid Booking Request
#     Verify 400 Error Response

# 2.2 Handle Duplicate Name Booking Gracefully
#     List All Inmate Bookings
#     Choose Random Inmate Name
#     Try New Booking With Same Name