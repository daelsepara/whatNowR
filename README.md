# whatNowR
R scripts used during the Open Tourism Days DK hackathon challenge

## whatNowFacebook(token, search, category, centerLat, centerLong)

search for places near **centerLat**, **centerLong**

### Other Parameters
- **token**: access token created from **initWhatNowFacebook** function
- **search**: pattern to search for in the results' category field
- **category**: must be one of the following: *EDUCATION, FOOD_BEVERAGE, HOTEL_LODGING, MEDICAL_HEALTH, ARTS_ENTERTAINMENT, SHOPPING_RETAIL, FITNESS_RECREATION, TRAVEL_TRANSPORTATION,* or *all*

### Returns

JSON array of places

## whatNowForecast(centerLat, centerLong, datestr)

returns weather forecast on an area centered at **centerLat**, **centerLong**

### Other Parameters
- **datestr**: return forecast on a specific date

### Returns

JSON array of weather forecasts

## whatNowTweet(search)

search for tweets containing patterns specified by **search**. Twitter OAuth access tokens must be set up using the **initWhatNowTwitter** function

### Returns

JSON array of tweets

## initWhatNowFacebook(app)

create Facebook app access token using parameters defined in **app** list

### app list members
- **id**: Facebook App ID
- **secret**: Facebook App secret key

### Returns

Facebook access token for use in **whatNowFacebook**

## initWhatNowTwitter(app)

Setup whatNowTweet Twitter OAuth access using parameters defined in **app** list

### app list members
- **key**: Twitter App consumer key
- **secret**: Twitter App consumer secret
- **token**: Twitter App access token
- **token_secret**: Twitter App access token secret keyy

### Returns

None

