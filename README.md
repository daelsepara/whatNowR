# whatNowR
R scripts used during the Open Tourism Days DK hackathon challenge

## whatNowFacebook(token, search, category, centerLat, centerLong)

search for places near **centerLat**, **centerLong**

### Other Parameters
- **token**: access token created from **initWhatNowFacebook** function
- **search**: pattern to search for in the results' category field
- **category**: must be one of the following: *EDUCATION, FOOD_BEVERAGE, HOTEL_LODGING, MEDICAL_HEALTH, ARTS_ENTERTAINMENT, SHOPPING_RETAIL, FITNESS_RECREATION, TRAVEL_TRANSPORTATION,* or *all*

### Returns

returns JSON string

## whatNowForecast(centerLat, centerLong, datestr)

returns weather forecast on an area centered at **centerLat**, **centerLong**

### Other Parameters
- **datestr**: return forecast on a specific date

