
$(function () {
	window.addEventListener('message', function (event) {
		if (event.data.action == "show") {
			$('body').css('display', 'block')
		}
		else{
			$('body').css('display', 'none')
		}
		
	})
})


$(function() {
	$('#search-form').submit(function(e) {
		e.preventDefault();
	})
});

function search() {
	//Clear any previous results 
	$('#results').html('');
	$('#btn-cnt').html('');	
	
	//Get form input
	var q = $('#query').val();
	
	//Run GET Request 	on API
	$.get(
		"https://www.googleapis.com/youtube/v3/search",{
			part: 'snippet, id',
			q: q,
			type: 'video',
			key: 'AIzaSyCJEPs1xB9b9mqkLao3zoH_23HmvX8FWUI'}, 
			function(data) {
				var nextPageToken = data.nextPageToken;
				var prevPageToken = data.prevPageToken;
				var pageInfo = data.pageInfo;
				
				//Log data
				console.log(data);	
				
				$.each(data.items, function(i, item) {
						//Get output
						var output = getOutput(item);
						
						//Display results
						$('#results').append(output);	
				});
				
				var buttons = getButtons(prevPageToken,nextPageToken, pageInfo);
				
				//Display buttons
				$('#results').prepend(buttons);
				$('#btn-cnt').append(buttons);
			}
	);	
}
$('#exit').click( function() {
  alert( "Handler for .click() called." );
} )
//Build Output
function exit() {
	console.log("o")
}
function myFunction(_d) {
	console.log(".")
	fetch(`https://${GetParentResourceName()}/start`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json; charset=UTF-8',
		},
		body: JSON.stringify({
			itemId: _d
		})
	}).then(resp => resp.json()).then(resp => console.log(resp));


	console.log(_d)
}
	function getOutput(item) {
		$.post('http://prw_screen/start',"ds")
		var videoId = item.id.videoId;
		var title = item.snippet.title;
		var description = item.snippet.description;
		var thumb = item.snippet.thumbnails.high.url;
		var channelTitle = item.snippet.channelTitle;
		var videoDate = item.snippet.publishedAt;
		
		//Build Output String
		var output = '<div class="row">' + 
		'<div class="col-sm-4">' +	
			'<a data-fancybox><img class="img-fluid" src="' + thumb + '"></a>' +
		'</div>' +
		'<div class="col-sm-4">' + 
			'<h6><a style="color:blue;cursor: pointer;" onClick="myFunction(\'' + videoId + '\')" data-fancybox">' + title + '</a></h6>' +
			'<small>By <span class="cTitle">' + channelTitle + '</span> on '+ videoDate + '</small>'
		+'</div>' +
		'</div>';
		return output;
			
	}

//Build the Buttons
	function getButtons(prevPageToken,nextPageToken,pageInfo) {
		
		$('#btn-cnt').html('');	
		var btnoutput;
		var q = $('#query').val();
		if(!prevPageToken) {
			btnoutput = '<div class="button-container">' + 
			'<span class="total-results"><label>Total Results :</label>' + pageInfo.totalResults + '</span>' +
			'<button id="next-button" class="btn animated-button thar-three" data-token="' + 	nextPageToken + '" data-query="' + q +'"' +
			'onclick="nextPage();">Next Page</button><div class="clearfix"></div></div>';
			console.log(nextPageToken);
		} else {
			console.log(nextPageToken);
			btnoutput = '<div class="button-container">' +
			'<span class="total-results"><label>Total Results :</label>' + pageInfo.totalResults + '</span>' +
			'<button id="next-button" class="btn  animated-button thar-three" data-token="' + 	nextPageToken + '" data-query="' + q +'"' +
			'onclick="nextPage();">Next Page</button>' +
			'<button id="prev-button" class="btn  animated-button thar-four" data-token="' + 	prevPageToken + '" data-query="' + q +'"' +
			'onclick="prevPage();">Previous Page</button>' +
			'<div class="clearfix"></div></div>';
		}
		return btnoutput;
	}

function nextPage() {
		
		var token = $('#next-button').data('token');
		var q = $('#next-button').data('query');
		//Clear any previous results 
	$('#results').html('');
	$('#btn-cnt').html('');	
	
	//Get form input
	q = $('#query').val();
	
	//Run GET Request 	on API
	$.get(
		"https://www.googleapis.com/youtube/v3/search",{
			part: 'snippet, id',
			q: q,
			pageToken: token,
			type: 'video',
			key: 'AIzaSyCJEPs1xB9b9mqkLao3zoH_23HmvX8FWUI'}, 
			function(data) {
				var nextPageToken = data.nextPageToken;
				var prevPageToken = data.prevPageToken;
				var pageInfo = data.pageInfo;
				//Log data
				console.log(data);	
				
				$.each(data.items, function(i, item) {
						//Get output
						var output = getOutput(item);
						
						//Display results
						$('#results').append(output);	
				});
				
				var buttons = getButtons(prevPageToken,nextPageToken,pageInfo);
				
				//Display buttons
				$('#results').prepend(buttons);
				$('#btn-cnt').append(buttons);
			}
		);
			
}

function prevPage() {
		
		var token = $('#prev-button').data('token');
		var q = $('#prev-button').data('query');
		//Clear any previous results 
	$('#results').html('');
	$('#btn-cnt').html('');	
	
	//Get form input
	q = $('#query').val();
	
	//Run GET Request 	on API
	$.get(
		"https://www.googleapis.com/youtube/v3/search",{
			part: 'snippet, id',
			q: q,
			pageToken: token,
			type: 'video',
			key: 'AIzaSyCJEPs1xB9b9mqkLao3zoH_23HmvX8FWUI'}, 
			function(data) {
				var nextPageToken = data.nextPageToken;
				var prevPageToken = data.prevPageToken;
				var pageInfo = data.pageInfo;
				//Log data
				console.log(data);	
				
				$.each(data.items, function(i, item) {
						//Get output
						var output = getOutput(item);
						
						//Display results
						$('#results').append(output);	
				});
				
				var buttons = getButtons(prevPageToken,nextPageToken,pageInfo);
				
				//Display buttons
				$('#results').prepend(buttons);
				$('#btn-cnt').append(buttons);
			}
		);
			
}