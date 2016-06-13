$(document).ready(function(){

//expand/collapse concert/top tracks details when
//'I'm Going' is clicked
 goingClickEvent = function(){ $('.going').click(function(){
    var specificShow = $(this).attr('id');
    var topTracks = "#tracks-for-"+$(this).attr('id');
    var active = $('.collapse-wrapper').find('.active');

    if(specificShow === $(this).attr('id')){
      $(''+topTracks+'').stop().slideDown('slow').addClass('active');
      active.stop().slideUp().removeClass('active');
    };
  })
}//end concert details expansion

goingClickEvent();
//click to play audio samples from Spotify
$('.listen').click(function(){
  //find the html id of each track
  var trackId = $(this).attr('id');
  //find the link from the 'value' attribute
  link = $(this).attr('value');
  //build new audio object with link
  var audio = new Audio(link);

  //this will always play the specific link
  //because the trackId will always be set
  //as the html id
  if((trackId === $(this).attr('id')) && (audio.classList.contains('playing'))){
        console.log(this)
        audio.pause();
        $('.listen').removeClass('playing')
      } else {
        audio.play();
        $('.listen').addClass('playing');
     }

})//end audio player function

//show submit button after at least one song is selected,
//hide if more than three are selected

var submit = $("#votes-submission").hide();
var checkedBoxes = $('input[type="checkbox"]').click(function(){
  var voteCount = $( "input:checked" ).length

  if(checkedBoxes.is(":checked")){
    submit.slideDown('slow');
  };

  if(voteCount > 3){
    submit.stop().slideUp('slow');
  };

})//end votes show/hide functionality

//Expand more concerts on click
$('.more-shows').click(function(){
     $(".concert-search div:nth-child(n+4)").slideToggle('slow');
    goingClickEvent();
  }
);//end show/hide concerts function

//Swap out View All/View Less concerts on click
$('.more-shows').on("click", function() {
  var el = $(this);
  if (el.text() == el.data("text-swap")) {
    el.text(el.data("text-original"));
  } else {
    el.data("text-original", el.text());
    el.text(el.data("text-swap"));
  }
});//end text swap


})//end wrapper function
