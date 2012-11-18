var game = (function () {
	
	var pub = {};
	
	var settings = {
		optionsTemplate: "#optionsTemplate",
		optionsTemplateImage: "#optionsTemplateImage",
		optionsContainer: "#options",
		options: ".optionContainer",
		infoContainer: "#infoContainer",
		questionContainer: "#questionContainer",
		questionStatTemplate: "#questionStatTemplate",
		previousAnswerTemplate: "#previousAnswerTemplate",
		infoContainerTemplate: "#infoContainerTemplate",
		allPreviousArtists: "#allPreviousArtists",
		lastPreviousArtist: "#lastPreviousArtist",
		gameSidebar: "#gameSidebar",
		questionFadeTime: 200,
		modal: "#winnerModal"
	};
	
	var correctAnswers = 0;
	
	var questions = [];
	
	var currentQuestionIndex = 0;
	
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
		this.correct = false;
	};
	
	Question.prototype.display = function () {
		var q = this;
		
		// play audio
		document.getElementById(this.audioId).play();
		
		var previousQuestion = questions[currentQuestionIndex-1];
		
		console.log("PreviousQuestionImage", (previousQuestion) ? previousQuestion.image : "");
		
		// template buttons
		var html = "";
		if (q.type === "text") {
			html = Mustache.to_html($(settings.optionsTemplate).html(), this);
		} else {
			html = Mustache.to_html($(settings.optionsTemplateImage).html(), this);
		}
		$(settings.optionsContainer).html(html).fadeIn(settings.questionFadeTime);
		// display info on the previous question
		if (previousQuestion) {
			var previousAnswerHtml = Mustache.render($(settings.previousAnswerTemplate).html(), {
				image: previousQuestion.image,
				correct: (previousQuestion.correct) ? "Correct" : "Incorrect",
				artistInfo: previousQuestion.text + " " + previousQuestion.answer
			});
			var $img = $("<img>").attr("src", previousQuestion.image);
			$(settings.lastPreviousArtist).html(previousAnswerHtml);
			$(settings.allPreviousArtists).append($img);
		}
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
	
	Question.prototype.setEvents = function () {
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
	
	Question.prototype.killEvents = function () {
		$(settings.options).unbind("click mouseover mouseout");
	};
	
	Question.prototype.chosenAnswer = function () {
		var $gameStat = $(document.getElementById(this.gameStatId));
		var $icon = $("<span>").addClass("padQuestion").append("<i>");
		if (this.correct) {
			$gameStat.parent().addClass("correct");
			$icon.find("i").addClass("icon-ok");
			correctAnswers++;
		} else {
			$gameStat.parent().addClass("incorrect");
			$icon.find("i").addClass("icon-remove");
			var soundId = "sound_wat1";
			document.getElementById(soundId).play();
		}
		$gameStat.find(".questionIcon").html($icon);
	};
	
	var selectAnswer = function (question, answer) {
		
		// increase index of question, ready to display next question
		currentQuestionIndex++;
		
		question.killEvents();
		
		// stop audio
		document.getElementById(question.audioId).pause();
		
		// set stat to correct or incorrect answer
		question.correct = (answer === question.answer);
		question.chosenAnswer();
		
		if (currentQuestionIndex >= questions.length) {
			// end game
			var totalQuestions = $(settings.gameSidebar).find("li").length;
			var $endMessage = $("<p>").append(correctAnswers + " answers correct out of " + totalQuestions);
			$(settings.modal).find(".modal-body").html($endMessage);
			$(settings.modal).modal();
		} else {
			// load next question
			loadQuestions(currentQuestionIndex);
		}
	};
	
	// display first question and have events to show win/lose/next question/play music/timing etc.
	var loadQuestions = function () {
		var question = questions[currentQuestionIndex];
		question.display();
		// TODO: all events relating to the question/html thus generated
		question.setEvents();
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
	
	var load = function (modeName, genre) {
		$.ajax({
			url: "play.json",
			type: "get",
			data: {
				mode: modeName,
				genre: genre
			},
			success: function (questionsJson) {
				$(settings.infoContainer).html($(settings.infoContainerTemplate).html());
				questions = _.map(questionsJson, function (q) {
					return (new Question(q));
				});
				currentQuestionIndex = 0;
				correctAnswers = 0;
				preloadQuestionAudio(questions);
				loadQuestions();
			}
		});
	};
		
	pub.start = function (modeName, genre, options) {
		if (_.isObject(options)) {
			$.extend(settings, options);
		}
		load(modeName, genre);
	};
	
	return pub;
	
})();
