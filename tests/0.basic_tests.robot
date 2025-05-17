*** Settings ***
Documentation        This file covers the essential positive and negative API actions to validate endpoint availability and expected HTTP behaviors.

Resource             ../resources/keywords.robot
Resource             ../resources/variables.robot

Suite Setup          Create Session On Mock Server
Suite Teardown       Delete All Sessions



*** Test Cases ***
0.1 Validate API Availability and Core Endpoints
    Check API is Up and Running
    List All Inmates Should Return 200
    Create Inmate With Valid Data Should Return 201
    Get Specific Inmate By ID Should Return 200
    Update Inmate With Valid Data Should Return 200
    Delete Inmate Should Return 204

0.2 Validate API Error Handling on Invalid Input
    Try Creating Inmate With Missing Fields Should Return 400
    Try Getting Inmate With Invalid ID Should Return 404
    Try Updating Nonexistent Inmate Should Return 404
    Try Deleting Nonexistent Inmate Should Return 404