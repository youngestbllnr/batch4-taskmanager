//NOTICE FLOAT
function checkNotices() {	
	for (i = 0; i < document.getElementsByClassName('notice-float').length; i++) {
		if (document.getElementsByClassName('notice-float')[i].style.display != 'none') {
			hideNotice(i);
		}
	}
}

function hideNotice(i) {
	setTimeout(function() {
		document.getElementsByClassName('notice-float')[i].style.display = 'none';
	}, 2400);
}

checkNotices();
setInterval(function() {
	checkNotices();
}, 2400);