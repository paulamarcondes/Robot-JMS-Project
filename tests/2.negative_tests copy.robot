*** Settings ***
Documentation    This file contains the test cases for the present mini-project.

Resource         ../resources/keywords.robot
Resource         ../resources/variables.robot

Suite Setup      Create Session On Mock Server
Suite Teardown   Delete All Sessions



*** Test Cases ***
2.1 Handle Missing Required Fields in Booking Request
    Generate Random Booking Data
    Send Invalid Booking Request
    Validate POST Error Response

2.2 Handle Same Name Booking Without Error
    List All Inmate Bookings
    Choose Random Inmate Name
    Post New Booking With Same Name
    Validate POST Successful Response

2.3 Handle Invalid ID Request Error
    Generate Invalid ID Number
    Get Inmate By Invalid ID
    Validate GET Error Response