var game = (function () {
	
	var pub = {};
	
	var settings = {
		optionsTemplate: "#optionsTemplate",
		optionsContainer: "#options",
		options: ".optionContainer",
		photoContainer: "#mainPhoto",
		questionContainer: "#questionContainer",
		questionStatTemplate: "#questionStatTemplate",
		gameSidebar: "#gameSidebar",
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
		var q = this;
		// template buttons
		var html = Mustache.to_html($(settings.optionsTemplate).html(), this);
		$(settings.optionsContainer).html(html).fadeIn(settings.questionFadeTime);
		// photo?
		var $img = $("<img>").attr("src", this.image);
		$(settings.photoContainer).html("").append($img);
		// question text
		$(settings.questionContainer).html($("<h2>").append(this.text));
		// add question to game stats
		var index = $(settings.gameSidebar).children("ul").find("li").length + 1;
		var questionStatHtml = Mustache.to_html($(settings.questionStatTemplate).html(), {
			index: index,
			questionText: q.text
		});
		var $questionStat = $("<li>").append(questionStatHtml);
		$(settings.gameSidebar).children("ul").append($questionStat);
	};
	
	Question.prototype.setEvents = function () {
		console.log("setting events");
		var q = this;
		$(settings.options).click(function () {
			var answer = parseInt($(this).attr("id"), 10);
			selectAnswer(q, answer);
		})
		.mouseover(function () {
			$(this).removeClass("standardOption").addClass("hoveredOption");
		})
		.mouseout(function () {
			$(this).removeClass("hoveredOption").addClass("standardOption");
		});
	};
	
	var selectAnswer = function (question, answer) {
		alert(answer === question.answer);
	};
	
	// display first question and have events to show win/lose/next question/play music/timing etc.
	var loadQuestions = function (questions) {
		var question = questions.shift();
		question.display();
		// TODO: all events relating to the question/html thus generated
		question.setEvents();
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
