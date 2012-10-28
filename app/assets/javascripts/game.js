var game = (function () {
	
	var pub = {};
	
	var settings = {
		optionsTemplate: "#optionsTemplate",
		optionsContainer: "#options",
		options: ".optionsContainer",
		photoContainer: "#mainPhoto",
		questionContainer: "#questionContainer",
		questionFadeTime: 200
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
	
	Question.prototype.display = function () {
		// template buttons
		var html = Mustache.to_html($(settings.optionsTemplate).html(), this);
		$(settings.optionsContainer).html(html).fadeIn(settings.questionFadeTime);
		// photo?
		var $img = $("<img>").attr("src", this.image);
		$(settings.photoContainer).html("").append($img);
		// question text
		$(settings.questionContainer).html($("<h2>").append(this.text));
	};
	
	Question.prototype.setEvents = function () {
		var q = this;
		$(settings.options).click(function () {
			alert($(this).attr("id") === q.answer);
		})
		.mouseover(function () {
			$(this).removeClass("standardOption").addClass("hoveredOption");
		})
		.mouseout(function () {
			$(this).removeClass("hoveredOption").addClass("standardOption");
		});
	};
	
	// display first question and have events to show win/lose/next question/play music/timing etc.
	var loadQuestions = function (questions) {
		var question = questions.shift();
		question.display();
		// TODO: all events relating to the question/html thus generated
		
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
				loadQuestions(questions);
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
