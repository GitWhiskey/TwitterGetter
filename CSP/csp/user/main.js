/**
 * 
 */

let dataTable = initTable();

$('#get-tweets-button').on('click', function(e) {
	let channelName = $('#channelName').val()
	let tweetNumber = $('#tweetNumber').val()
	
	$.ajax({
		url: `gettweets.csp?channelName=${channelName}&tweetNumber=${tweetNumber}`,
		method: 'GET'
	}).done(function (result) {
		let tweets = JSON.parse(result)
		let tableData = [];
		for (let tweet of tweets) {
			tableData.push([tweet.id, tweet.text, tweet.date])
		}
		dataTable.clear();
		dataTable.rows.add(tableData);
		dataTable.draw();
		
	})
});

function initTable() {
	return $('#tweets-table').DataTable();
}
