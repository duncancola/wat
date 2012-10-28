var game = (function () {
	
	var pub = {};
	
	var settings = {
		optionsTemplate: "#optionsTemplate",
		optionsTemplateImage: "#optionsTemplateImage",
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
		this.id = _.uniqueId();
		this.text = jsonObj.text;
		this.image = jsonObj.image;
		this.answer = jsonObj.answer;
		this.gameStatId = _.uniqueId("game_stat");
		this.audioId = _.uniqueId("audio_");
	};
	
	Question.prototype.display = function () {
		var q = this;
		
		// play audio
		document.getElementById(this.audioId).play();
		
		// template buttons
		var html = "";
		if (q.type === "text") {
			html = Mustache.to_html($(settings.optionsTemplate).html(), this);
		} else {
			html = Mustache.to_html($(settings.optionsTemplateImage).html(), this);
		}
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
			questionText: q.text,
			gameStatId: q.gameStatId
		});
		var $questionStat = $("<li>").append(questionStatHtml);
		$(settings.gameSidebar).children("ul").append($questionStat);
	};
	
	Question.prototype.setEvents = function (remainingQuestions) {
		var q = this;
		$(settings.options).click(function () {
			var answer = parseInt($(this).attr("id"), 10);
			selectAnswer(q, answer, remainingQuestions);
		})
		.mouseover(function () {
			$(this).removeClass("standardOption").addClass("hoveredOption");
		})
		.mouseout(function () {
			$(this).removeClass("hoveredOption").addClass("standardOption");
		});
	};
	
	Question.prototype.killEvents = function () {
		$(settings.options).unbind("click mouseover mouseout");
	};
	
	Question.prototype.chosenAnswer = function (correct) {
		var $gameStat = $(document.getElementById(this.gameStatId));
		var $icon = $("<span>").addClass("padQuestion").append("<i>");
		if (correct) {
			$gameStat.parent().addClass("correct");
			$icon.find("i").addClass("icon-ok");
		} else {
			$gameStat.parent().addClass("incorrect");
			$icon.find("i").addClass("icon-remove");
			var soundId = "sound_wat1";
			document.getElementById(soundId).play();
		}
		$gameStat.find(".questionIcon").html($icon);
	};
	
	
	
	var selectAnswer = function (question, answer, remainingQuestions) {
		
		question.killEvents();
		
		// stop audio
		document.getElementById(question.audioId).pause();
		
		// set stat to correct or incorrect answer
		question.chosenAnswer(answer === question.answer);
		
		if (remainingQuestions.length === 0) {
			// end game
			alert("END GAME");
		} else {
			// load next question
			loadQuestions(remainingQuestions);
		}
	};
	
	// display first question and have events to show win/lose/next question/play music/timing etc.
	var loadQuestions = function (questions) {
		var question = questions.shift();
		question.display();
		// TODO: all events relating to the question/html thus generated
		question.setEvents(questions);
	};
	
	var preloadQuestionAudio = function (questions) {
		_.each(questions, function (question) {
			/* var $audioElem = $("<audio>").attr("id", question.audioId)
				.attr("preload", "auto autobuffer")
				.append("<source>").attr("src", question.songUrl);*/
			var $audioElem = $("<audio>").attr("id", question.audioId)
				.attr("src", question.songUrl)
				.attr("preload", "auto");
			$("body").append($audioElem);
		});
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
				preloadQuestionAudio(questions);
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
