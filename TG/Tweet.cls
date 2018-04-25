/// Класс твита, который будет храниться в базе
Class TG.Tweet Extends %Persistent
{
	Property tweetText as %String;
	Property tweetDate as %String;

Storage Default
{
<Data name="TweetDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>tweetText</Value>
</Value>
<Value name="3">
<Value>tweetDate</Value>
</Value>
</Data>
<DataLocation>^TG.TweetD</DataLocation>
<DefaultData>TweetDefaultData</DefaultData>
<IdLocation>^TG.TweetD</IdLocation>
<IndexLocation>^TG.TweetI</IndexLocation>
<StreamLocation>^TG.TweetS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}