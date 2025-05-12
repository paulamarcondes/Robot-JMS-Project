*** Settings ***
Documentation    This file contains all the custom keywords for the present mini-project.
Library          RequestsLibrary
Library          Collections
Library          FakerLibrary
Library          String

Resource         variables.robot



*** Keywords ***
Create Session On Mock Server
    Create Session    jail_mock_api    http://localhost:5000
    Log    Session Created Successfully On Mock Server.



### --- Positive Tests Keywords --- ###
Generate Random Booking Data
    ${random_name}=        Name
    ${random_date}=        Date    pattern='%Y-%m-%d'
    ${random_facility}=    Random Element    ${FACILITIES}
    ${random_crime}=       Random Element    ${CRIME_TYPES}
    ${random_priority}=    Random Element    ${PRIORITY}
    
    &{random_booking}=    Create Dictionary
    ...    name=${random_name}
    ...    bookingDate=${random_date}
    ...    facility=${random_facility}
    ...    crimeType=${random_crime}
    ...    priority=${random_priority}
    
    Log Dictionary    ${random_booking}
    Set Suite Variable    ${random_booking}

Send Valid Booking Request
    ${booking}=    POST On Session    jail_mock_api    /inmates    json=${random_booking}    
    Log    Status Code: ${booking.status_code}
    Log    Response Body: ${booking.json()}
    ${booking_body}=    Set Variable    ${booking.json()}
    Set Suite Variable    ${booking}
    Set Suite Variable    ${booking_body}

Validade POST Successful Response
    Should Be Equal As Integers    ${booking.status_code}    201
    Should Contain    ${booking.json()}    id
    Log    Validation Completed.

List All Inmate Bookings
    ${response}=    GET On Session    jail_mock_api    /inmates
    ${body}=    Convert To String    ${response.json()}
    Log    All Inmate Booking As String: ${body}
    Set Test Variable    ${body}

Choose Random Inmate Booking
    ${bookings}=    Evaluate    [booking["id"] for booking in ${body}]
    Log    Available Booking IDs: ${bookings}
    ${chosen_booking}=    Random Element    ${bookings}
    Log    Chosen Inmate Booking ID: ${chosen_booking}
    Set Test Variable    ${chosen_booking}

Validate Return Of Correct Data
    ${response}=    GET On Session    jail_mock_api    /inmates/${chosen_booking}
    Should Contain    ${response.json()}    name
    Should Contain    ${response.json()}    facility
    Log    Inmate Information: ${response.json()}

Retreive Booking ID From Request
    ${booking_id}=    Get From Dictionary    ${booking_body}    id
    Log    Booking Record ID: ${booking_id}
    Set Test Variable    ${booking_id}

Compare Booking Record With RMS
    ${response}=    GET On Session    jail_mock_api    /inmates/${booking_id}
    Log    Booking Data: ${response.json()}
    Should Contain    ${response.text}    ${booking_id}
    Log    Booking ID ${booking_id} found in response: ${response.json()}





### --- Negative Tests Keywords --- ###
Book Request Without Required Details
    Remove From Dictionary    ${random_booking}    name
    Log    ${random_booking}
    ${response}=    Run Keyword And Expect Error    HTTPError: 400 Client Error: BAD REQUEST*
    ...    POST On Session    jail_mock_api    /inmates    json=${random_booking}
    Set Suite Variable    ${response}

Verify 400 Error Response
    Should Contain    ${response}    400
    Should Contain    ${response}    BAD REQUEST
    Log    Error Response Verification Completed.

Choose Random Inmate Name
    ${inmates}=    Evaluate    [booking["name"] for booking in ${body}]
    Log    Available Inmate Names: ${inmates}
    ${chosen_name}=    Random Element    ${inmates}
    Log    Chosen Inmate Name: ${chosen_name}
    Set Test Variable    ${chosen_name}

Try New Booking With Same Name
    &{duplicate_inmate}=    Create Dictionary    
    ...    name=${chosen_name}    
    ...    bookingDate=2024-04-05    
    ...    facility= County Jail A    
    ...    crimeType= Misdemeanor    
    ...    priority=Medium
    Log    Booking with Duplicate Name: ${duplicate_inmate}

    ${response}=    POST On Session    jail_mock_api    /inmates    json=${duplicate_inmate}
    Log    Attempt Booking With Same Name Response: ${response.status_code}
    Log    Attempt Booking With Same Name Response: ${response.reason}





### --- Server Tests Keywords --- ###
Send Booking Request And Verify Error
    ${response}=    Run Keyword And Continue On Failure
    ...    POST On Session    jail_mock_api    /inmates    json=${random_booking}
    
    Run Keyword If    '${response}' != 'None'    
    ...    Log    Server responded to booking attempt: ${response.text}
    ...    ELSE
    ...    Log    Server unreachable during booking attempt

Confirm If Booking Was Saved Or Log Server Down
    ${response}=    Run Keyword And Continue On Failure
    ...    GET On Session    jail_mock_api    /inmates
    
    Run Keyword If    '${response}' != 'None'
    ...    Validate Booking Saved    ${response}
    ...    ELSE
    ...    Log    Server still unreachable. Cannot confirm if booking was saved.

Validate Booking Saved
    [Arguments]    ${response}
    ${bookings}=    Evaluate    ${response.json()}    json
    Should Contain    ${bookings}    ${random_booking}