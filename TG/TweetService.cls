Class TG.TweetService
{
	Parameter AUTHHEADER = "Bearer AAAAAAAAAAAAAAAAAAAAACch5wAAAAAAaJU98hZbDw%2Bb2ez4b%2B5XqPfaulY%3D9TKb70rX1sqAiJX6mHjJJzCZqg2BacqcXRt2xbXWYBJJMXkikn";

	ClassMethod GetTweets(name as %String) {
		write "I'm gonna get some tweets from user ", name
		Set httpRequest = ##class(%Net.HttpRequest).%New()
		Set httpRequest.Server="api.twitter.com"
		Set httpRequest.Https=1
		Set httpRequest.SSLConfiguration="TwitterSSL"
		Do httpRequest.SetHeader("Authorization", ..#AUTHHEADER)
		Do httpRequest.Get("/1.1/statuses/user_timeline.json?screen_name=twitterapi&count=2")
		Set response = httpRequest.HttpResponse.Data
		
		write response
	}
}