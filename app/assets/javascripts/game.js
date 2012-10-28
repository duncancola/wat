var game = (function () {
	
	var pub = {};
	
	var settings = {
		optionsTemplate: "#optionsTemplate",
		optionsContainer: "#options",
		photoContainer: "#mainPhoto"
	};
	
	var Question = function (jsonObj) {
		this.songUrl = jsonObj.song_url;
		this.type = jsonObj.type || "text";
		this.options = jsonObj.options;
		this.id = jsonObj.id;
		this.text = jsonObj.text;
		this.image = jsonObj.image;
		this.answer = jsonObj.answer;
	};
	
	Question.prototype.addOptionsToHtml = function () {
		var html = Mustache.to_html($(settings.optionsTemplate).html(), this.options);
		$(settings.optionsContainer).html(html);
	};
	
	var startGame = function (questions) {
		
	};
	
	var load = function (modeName) {
		$.ajax({
			url: "play.json",
			type: "get",
			data: {
				mode: modeName
			},
			success: function (questionsJson) {
				var questions = _.map(questionsJson, function (q) {
					return (new Question(q));
				});
				startGame(questions);
			}
		});
	};
		
	pub.start = function (modeName, options) {
		if (_.isObject(options)) {
			$.extend(settings, options);
		}
		load(modeName);
	};
	
	return pub;
	
})();
