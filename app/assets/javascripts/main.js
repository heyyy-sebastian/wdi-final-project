$(document).ready(function(){

//expand/collapse concert/top tracks details when
//'I'm Going' is clicked
  $('.going').click(function(){
    var specificShow = $(this).attr('id');
    var topTracks = "#tracks-for-"+$(this).attr('id');
    var active = $('.collapse-wrapper').find('.active');

    if(specificShow === $(this).attr('id')){
      $(''+topTracks+'').stop().slideDown('slow').addClass('active');
      active.stop().slideUp().removeClass('active');
    };


})//end concert details expansion

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
  if(trackId === $(this).attr('id')){
    audio.play();
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

})//end wrapper function
