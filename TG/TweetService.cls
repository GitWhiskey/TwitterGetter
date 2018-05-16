Class TG.TweetService
{
	Parameter AUTHHEADER = "Bearer AAAAAAAAAAAAAAAAAAAAACch5wAAAAAAaJU98hZbDw%2Bb2ez4b%2B5XqPfaulY%3D9TKb70rX1sqAiJX6mHjJJzCZqg2BacqcXRt2xbXWYBJJMXkikn";

	ClassMethod GetTweets(channel as %String, tweetNumber as %String) {
		Set httpRequest = ##class(%Net.HttpRequest).%New()
		Set httpRequest.Server="api.twitter.com"
		Set httpRequest.Https=1
		Set httpRequest.SSLConfiguration="TwitterSSL"
		Do httpRequest.SetHeader("Authorization", ..#AUTHHEADER)
		Do httpRequest.Get("/1.1/statuses/user_timeline.json?screen_name="_channel_"&count="_tweetNumber)

		Set responseData = httpRequest.HttpResponse.Data
		Do responseData.Rewind()
	
		Set len = responseData.Size
		Set tweetsString = responseData.Read(.len)
		
		set json = {}.%FromJSON(tweetsString)
		set iter = json.%GetIterator()
 		while iter.%GetNext(.key, .value) { 
 			Set tweet = ##class(TG.Tweet).%New()
 			Set tweet.tweetText = value.%Get("text")_" "
 			Set tweet.tweetDate = value.%Get("created_at")_" "
 			Do tweet.%Save()
 		}
		&sql(DECLARE C1 CURSOR FOR
		    SELECT ID, tweetText, tweetDate
		    INTO :id, :text, :date
		    FROM TG.Tweet
		 )
		 
		&sql(OPEN C1)
	 	&sql(FETCH C1)
	 	
	 	Set tweetsFromDb = []
	 	Set i = 0
	 	While (SQLCODE = 0) {
	 		set item = {}.%Set("id", id).%Set("text", text).%Set("date", date)
	 		Do tweetsFromDb.%Push(item)      
 			&sql(FETCH C1)
		}
	 	
		write tweetsFromDb.%ToJSON()
		&sql(CLOSE C1)
	}
}