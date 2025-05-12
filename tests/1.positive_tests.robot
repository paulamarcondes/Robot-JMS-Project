*** Settings ***
Documentation    This file contains the test cases for the present mini-project.

Resource         ../resources/keywords.robot
Resource         ../resources/variables.robot

Suite Setup      Create Session On Mock Server
Suite Teardown   Delete All Sessions



*** Test Cases ***
# 1.1 Validate Successful Jail Booking Response
#     Generate Random Booking Data
#     Send Valid Booking Request
#     Validade POST Successful Response

# 1.2 Verify Inmate By Booking ID Returns Correct Data
#     List All Inmate Bookings
#     Choose Random Inmate Booking
#     Validate Return Of Correct Data

# 1.3 Confirm Jail Booking Sync With RMS
#     Generate Random Booking Data
#     Send Valid Booking Request
#     Retreive Booking ID From Request
#     Compare Booking Record With RMS