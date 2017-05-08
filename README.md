# whatNowR
R scripts used during the Open Tourism Days DK hackathon challenge

## whatNowFacebook(token, search, category, centerLat, centerLong)

search for places near *centerLat*, *centerLong*

### Other Parameters
- _token_: access token created from _initWhatNowFacebook_ function
- _search_: pattern to search for in the results' category field
- _category_: must be one of the following: EDUCATION,FOOD_BEVERAGE,HOTEL_LODGING,MEDICAL_HEALTH,ARTS_ENTERTAINMENT,SHOPPING_RETAIL,FITNESS_RECREATION,TRAVEL_TRANSPORTATION, or _all_
