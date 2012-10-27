var game = (function () {
	
	var pub = {};
	
	var modes = {
		normal: "normal",
		hipster: "hipster",
		social: "social"
	};
	
	
	pub.start = function () {
		$.ajax({
			url: "play.json",
			type: "get",
			data: {
				mode: "normal"
			},
			success: function () {
				
			}
		});
	};
	
})();
