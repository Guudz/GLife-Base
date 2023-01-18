
$(function () {
	window.addEventListener('message', function (event) {
		switch (event.data.action) {
			case 'showCards':
				this.console.log()
				$('body').css('opacity', '1.0')
				if (event.data.data.data.identity.first_name != undefined) {
					event.data.data.data.identity = event.data.data.data.identity.first_name + " " + event.data.data.data.identity.last_name
				}
				$(".name").last().html( event.data.data.data.identity);
				$(".model").last().html( event.data.data.data.model);
				$(".plate").last().html( event.data.data.data.plate);
				$('.im'). attr("src", "https://media.discordapp.net/attachments/755128414452580414/792762768302407690/carte_grise.png");
				break
			case 'hide':
				$('body').css('opacity', '0.0')
		}
	})
})

