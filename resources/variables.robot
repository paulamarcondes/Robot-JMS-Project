*** Settings ***
Documentation    This file contains the variables for the present mini-project.

Resource         keywords.robot



*** Variables ***
${BASE_URL}       http://localhost:5000
@{FACILITIES}     Crestview Labs    Oakwood Depot    Riverbend Hub    Summit Center    Valley Annex
@{CRIME_TYPES}    Misdemeanor    Felony    Assault    Theft    Murder    Vandalism
@{PRIORITY}       Low    Medium    High    Urgent    Routine

