require(Rfacebook)
require(XML)
require(twitteR)

whatNowFacebook <- function(token, search = "", category = "", centerLat = 55.6184978, centerLong = 12.645085) {

	categories = "\"EDUCATION\",\"FOOD_BEVERAGE\",\"HOTEL_LODGING\",\"MEDICAL_HEALTH\",\"ARTS_ENTERTAINMENT\",\"SHOPPING_RETAIL\",\"FITNESS_RECREATION\",\"TRAVEL_TRANSPORTATION\""
	
	if (nchar(category) > 0 && !grepl("all", category, ignore.case = TRUE)) {
		categories = paste0("\"",category,"\"")
	}
	
	fromFB = callAPI(paste0("https://graph.facebook.com/v2.9/search?type=place&center=", centerLat, ",", centerLong, "&limit=100&distance=1000&categories=[", categories, "]&fields=name,location,checkins,about,overall_star_rating,picture,category,talking_about_count,were_here_count"), token)

	jsonData = list()
	
	for (i in 1:length(fromFB$data)) {

		thisCategory = tolower(fromFB$data[[i]]$category)
		
		if (nchar(search) <= 1 || grepl("all", category, ignore.case = TRUE) || (nchar(thisCategory) > 0 && grepl(search, thisCategory, ignore.case = TRUE))) {
			
			metadata = list()
			metadata$name = trimws(fromFB$data[[i]]$name)
			
			if ("about" %in% names(fromFB$data[[i]])) {
				metadata$description = trimws(fromFB$data[[i]]$about)
			}
			
			metadata$rating = fromFB$data[[i]]$overall_star_rating
			metadata$distance = abs(cos(centerLat) - cos(fromFB$data[[i]]$location$latitude))*111.32
			metadata$picture = trimws(fromFB$data[[i]]$picture$data$url)
			metadata$crowdedness = fromFB$data[[i]]$checkins
			metadata$category = trimws(fromFB$data[[i]]$category)
			metadata$talks = fromFB$data[[i]]$talking_about_count
			metadata$here = fromFB$data[[i]]$were_here_count
			
			jsonData <- append(jsonData, list(metadata))
		}
	}
	
	if (length(jsonData) > 0) {
		invisible(toJSON(jsonData))
	}
}

whatNowForecast <- function(centerLat = 55.6184978, centerLong = 12.645085, datestr = "") {
	
	data <- xmlParse(paste0("http://api.met.no/weatherapi/locationforecast/1.9/?lat=", centerLat, ";", "lon=", centerLong))
	
	xml_data <- xmlToList(data)
	
	count = 0
	
	jsonData = list()
	
	for(i in 1:length(xml_data$product)) {
		
		if (!is.atomic(xml_data$product[[i]]) && !is.null(xml_data$product[[i]]$location$symbol["id"]) && !is.null(xml_data$product[[i]]$.attrs["from"]) && !is.null(xml_data$product[[i]]$.attrs["to"])) {
			
			if (nchar(datestr) > 0) {
				
				if (grepl(datestr, xml_data$product[[i]]$.attrs["from"])) {
					
					jsonData <- append(jsonData, addForecastMetaData(xml_data$product[[i]], centerLong, centerLat))
					
				}
			} else {
				
				jsonData <- append(jsonData, addForecastMetaData(xml_data$product[[i]], centerLong, centerLat))
			}
			
		}
	}
	
	if (length(jsonData) > 0) {
		
		invisible(toJSON(jsonData))
	}
}

addForecastMetaData <- function(item = list(), centerLong, centerLat) {
		
		metadata = list()
		metadata = c(metadata, long = centerLong, lat = centerLat)
		metadata = c(metadata, item$.attrs["from"])
		metadata = c(metadata, item$.attrs["to"])
		metadata = c(metadata, item$location$symbol["id"])
		
		return(list(metadata))
}

initWhatNowFacebook <- function(app) {

	if (is.null(app) || !is.list(app)) {
		
		stop("Need to setup OAuth")
		
	} else {
		
		fb_oauth <- fbOAuth(app$id, app$secret, extended_permissions = TRUE)
		
		invisible(fb_oauth)
	}
	
}

initWhatNowTwitter <- function(app) {
	
	if (is.null(app) || !is.list(app)) {
		
		stop("Need to setup OAuth")
		
	} else {
		
		setup_twitter_oauth(consumer_key = app$key, consumer_secret = app$secret, access_token = app$token, access_secret = app$token_secret)
	}
}

whatNowTweet <- function(search = "") {

	jsonData = list()

	result = searchTwitter(search)

	if (length(result) > 0) {
		
		for (i in 1:length(result)) {

			metadata = list()
		
			metadata$tweet = trimws(result[[i]]$getText())
			metadata$favorites = result[[i]]$favoriteCount
			metadata$retweets = tweets[[i]]$retweetCount
			metadata$user = trimws(tweets[[i]]$screenName)
		
			jsonData <- append(jsonData, list(metadata))
		}
	}
	
	if (length(jsonData) > 0) {
		
		invisible(toJSON(jsonData))
	}
}
