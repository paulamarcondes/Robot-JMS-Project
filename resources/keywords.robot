*** Settings ***
Documentation    This file contains all the custom keywords for the present mini-project.
Library          RequestsLibrary
Library          Collections
Library          FakerLibrary
Library          String

Resource         variables.robot



*** Keywords ***
Create Session On Mock Server
    Create Session    jail_api    ${BASE_URL}
    Log    Session Created Successfully On Mock Server



### --- Basic Tests Keywords --- ###
Generate Random Inmate Data
    ${random_name}=        Name
    ${random_date}=        Date    pattern='%Y-%m-%d'
    ${random_facility}=    Random Element    ${FACILITIES}
    ${random_crime}=       Random Element    ${CRIME_TYPES}
    ${random_priority}=    Random Element    ${PRIORITY}
    
    &{random_data}=    Create Dictionary
    ...    name=${random_name}
    ...    bookingDate=${random_date}
    ...    facility=${random_facility}
    ...    crimeType=${random_crime}
    ...    priority=${random_priority}
    
    Set Suite Variable    ${random_data}
    RETURN    ${random_data}



Check API Is Up and Running
    ${response}=    GET On Session    jail_api    /inmates
    Should Be Equal As Integers    ${response.status_code}    200
    Log    API is up and returned ${response.status_code}.

List All Inmates Should Return 200
    ${response}=    GET On Session    jail_api    /inmates
    Should Be Equal As Integers    ${response.status_code}    200
    Log    List response: ${response.json()}.

Create Inmate With Valid Data Should Return 201
    ${data}=    Generate Random Inmate Data
    ${response}=    POST On Session    jail_api    /inmates    json=${data}
    Should Be Equal As Integers    ${response.status_code}    201
    Set Suite Variable    ${created_inmate}    ${response.json()}
    Log    Inmate created: ${created_inmate}.

Get Specific Inmate By ID Should Return 200
    ${id}=    Set Variable    ${created_inmate["id"]}
    ${response}=    GET On Session    jail_api    /inmates/${id}
    Should Be Equal As Integers    ${response.status_code}    200
    Log    Retrieved inmate: ${response.json()}.

Update Inmate With Valid Data Should Return 200
    ${id}=    Set Variable    ${created_inmate["id"]}
    ${update}=    Create Dictionary    priority=Urgent
    ${response}=    PUT On Session    jail_api    /inmates/${id}    json=${update}
    Should Be Equal As Integers    ${response.status_code}    200
    Log    Inmate updated: ${response.json()}.

Delete Inmate Should Return 204
    ${id}=    Set Variable    ${created_inmate["id"]}
    ${response}=    DELETE On Session    jail_api    /inmates/${id}
    Should Be Equal As Integers    ${response.status_code}    204
    Log    Inmate deleted: ${id}.

Try Creating Inmate With Missing Fields Should Return 400
    ${invalid}=    Create Dictionary    name=Only Name
    ${result}=    Run Keyword And Ignore Error    
    ...    POST On Session    jail_api    /inmates    json=${invalid}
    ${status}=    Set Variable    ${result[0]}
    ${response}=  Set Variable    ${result[1]}
    Should Be Equal    ${status}    FAIL
    Should Contain    ${response}    400
    Log    Request failed with 400 as expected.

Try Getting Inmate With Invalid ID Should Return 404
    ${result}=    Run Keyword And Ignore Error    
    ...    GET On Session    jail_api    /inmates/fake123
    ${status}=    Set Variable    ${result[0]}
    ${response}=  Set Variable    ${result[1]}
    Should Be Equal    ${status}    FAIL
    Should Contain    ${response}    404
    Log    GET request failed with 404 as expected.

Try Updating Nonexistent Inmate Should Return 404
    &{update}=    Create Dictionary    crimeType=Theft
    ${result}=    Run Keyword And Ignore Error    
    ...    PUT On Session    jail_api    /inmates/fake123    json=${update}
    ${status}=    Set Variable    ${result[0]}
    ${response}=  Set Variable    ${result[1]}
    Should Be Equal    ${status}    FAIL
    Should Contain    ${response}    404
    Log    Update failed with 404 as expected.

Try Deleting Nonexistent Inmate Should Return 404
    ${result}=    Run Keyword And Ignore Error    
    ...    DELETE On Session    jail_api    /inmates/fake123
    ${status}=    Set Variable    ${result[0]}
    ${response}=  Set Variable    ${result[1]}
    Should Be Equal    ${status}    FAIL
    Should Contain    ${response}    404
    Log    Delete failed with 404 as expected.







### --- Positive Tests Keywords --- ###
Send Valid Booking Request And Verify Success
    ${response}=    POST On Session    jail_api    /inmates    json=${random_data}
    Should Be Equal As Integers    ${response.status_code}    201
    ${created}=    Convert To Dictionary    ${response.json()}
    Set Suite Variable    ${created_inmate}    ${created}
    Log Dictionary    ${created}

Store Created Inmate Data
    ${id}=    Set Variable    ${created_inmate["id"]}
    Set Suite Variable    ${created_id}    ${id}
    Log    Stored inmate ID: ${created_id}.

Get Inmate Using Stored ID
    ${response}=    GET On Session    jail_api    /inmates/${created_id}
    Should Be Equal As Integers    ${response.status_code}    200
    ${retrieved}=    Convert To Dictionary    ${response.json()}
    Set Suite Variable    ${retrieved_inmate}    ${retrieved}
    Log Dictionary    ${retrieved}

Verify Retrieved Inmate Matches Original Data
    Should Be Equal    ${retrieved_inmate["name"]}        ${random_data["name"]}
    Should Be Equal    ${retrieved_inmate["facility"]}    ${random_data["facility"]}
    Should Be Equal    ${retrieved_inmate["crimeType"]}   ${random_data["crimeType"]}
    Should Be Equal    ${retrieved_inmate["priority"]}    ${random_data["priority"]}
    Log    Inmate data successfully verified.

Prepare Valid Priority Update
    &{update_payload}=    Create Dictionary    priority=Urgent
    Set Suite Variable    ${update_payload}
    Log Dictionary    ${update_payload}

Send Update Request And Confirm Success
    ${response}=    PUT On Session    jail_api    /inmates/${created_id}    json=${update_payload}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal    ${response.json()["priority"]}    Urgent
    Log    Inmate priority updated successfully.

Delete Inmate By Stored ID
    ${response}=    DELETE On Session    jail_api    /inmates/${created_id}
    Should Be Equal As Integers    ${response.status_code}    204
    Log    Inmate deleted successfully.

Try Getting Deleted Inmate Should Return 404
    ${result}=    Run Keyword And Ignore Error    
    ...    GET On Session    jail_api    /inmates/${created_id}
    ${status}=    Set Variable    ${result[0]}
    ${response}=  Set Variable    ${result[1]}
    Should Be Equal    ${status}    FAIL
    Should Contain    ${response}    404
    Log    Inmate not found after deletion, as expected.







### --- Negative Tests Keywords --- ###
Generate Incomplete Inmate Data
    &{incomplete_data}=    Create Dictionary    name=Only Name
    Set Suite Variable    ${invalid_data}    ${incomplete_data}
    Log Dictionary    ${invalid_data}

Generate Inmate With Invalid Date Format
    Generate Random Inmate Data
    Set To Dictionary    ${random_data}    bookingDate=2024
    Set Suite Variable    ${invalid_data}    ${random_data}
    Log Dictionary    ${invalid_data}

Send Invalid Booking Request And Expect 400
    ${result}=    Run Keyword And Ignore Error    
    ...    POST On Session    jail_api    /inmates    json=${invalid_data}
    ${status}=    Set Variable    ${result[0]}
    ${response}=  Set Variable    ${result[1]}
    Should Be Equal    ${status}    FAIL
    Should Contain    ${response}    400
    Log    Booking failed with 400 as expected.

Request Inmate Using Invalid ID
    ${result}=    Run Keyword And Ignore Error    
    ...    GET On Session    jail_api    /inmates/@@@wrongID
    ${status}=    Set Variable    ${result[0]}
    ${response}=  Set Variable    ${result[1]}
    Set Suite Variable    ${invalid_response}    ${response}
    Should Be Equal    ${status}    FAIL
    Should Contain    ${response}    404
    Log    GET failed with 404 as expected.

Try Updating Inmate With Invalid ID
    &{update}=    Create Dictionary    facility=Nowhere
    ${result}=    Run Keyword And Ignore Error    
    ...    PUT On Session    jail_api    /inmates/fake999    json=${update}
    ${status}=    Set Variable    ${result[0]}
    ${response}=  Set Variable    ${result[1]}
    Set Suite Variable    ${invalid_response}    ${response}
    Should Be Equal    ${status}    FAIL
    Should Contain    ${response}    404
    Log    PUT failed with 404 as expected.

Try Deleting Inmate With Invalid ID
    ${result}=    Run Keyword And Ignore Error    
    ...    DELETE On Session    jail_api    /inmates/fake999
    ${status}=    Set Variable    ${result[0]}
    ${response}=  Set Variable    ${result[1]}
    Set Suite Variable    ${invalid_response}    ${response}
    Should Be Equal    ${status}    FAIL
    Should Contain    ${response}    404
    Log    DELETE failed with 404 as expected.

Verify Response Is 404 Not Found
    Should Contain    ${invalid_response}    404
    Log    Response contained 404 as expected.







### --- Server Tests Keywords --- ###
Simulate Server Down
    [Documentation]    Manually stop the Flask server before running this test.
    Log    Ensure the server is OFF before running this test.

Try Creating Inmate Booking
    Generate Random Inmate Data
    Send Create Request

Send Create Request
    ${result}=    Run Keyword And Ignore Error    
    ...    POST On Session    jail_api    /inmates    json=${random_data}
    ${status}=    Set Variable    ${result[0]}
    ${response}=  Set Variable    ${result[1]}
    Set Suite Variable    ${server_response}=    ${response}
    Log    POST Request Result: ${status}.

Try Getting Inmate By ID
    ${id}=    Set Variable    fake-id-123
    Send Get Request    ${id}

Send Get Request
    [Arguments]    ${id}
    ${result}=    Run Keyword And Ignore Error    
    ...    GET On Session    jail_api    /inmates/${id}
    ${status}=    Set Variable    ${result[0]}
    ${response}=  Set Variable    ${result[1]}
    Set Suite Variable    ${server_response}    ${response}
    Log    GET Request Result: ${status}.

Verify Connection Error Or Status 500
    Run Keyword If    'ConnectionError' in '''${server_response}'''    
    ...    Log    Connection failed as expected.
    ...    ELSE    Should Be Equal As Integers    ${server_response.status_code}    500
    Log    API returned: ${server_response}