*** Settings ***
Documentation     This file contains end-to-end tests validating the successful flow of creating, retrieving, updating, and deleting inmate records.

Resource         ../resources/keywords.robot
Resource         ../resources/variables.robot

Suite Setup      Create Session On Mock Server
Suite Teardown   Delete All Sessions



*** Test Cases ***
1.1 Create New Inmate Booking Successfully
    Generate Random Inmate Data
    Send Valid Booking Request And Verify Success
    Store Created Inmate Data

1.2 Get Created Inmate By ID
    Get Inmate Using Stored ID
    Verify Retrieved Inmate Matches Original Data

1.3 Update Inmate Priority Successfully
    Prepare Valid Priority Update
    Send Update Request And Confirm Success

1.4 Delete Inmate And Confirm Deletion
    Delete Inmate By Stored ID
    Try Getting Deleted Inmate Should Return 404