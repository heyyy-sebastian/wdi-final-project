$(document).ready(function(){

//expand concert/top tracks details when
//'I'm Going' is clicked
  $('.going').click(function(){
    var $active = $('.going').find('.active');

    $('.top-tracks-search').stop().slideDown('slow').addClass('active');

    $active.stop().slideUp().removeClass('active');

})//end concert details expansion

//click to play audio samples from Spotify
$('.listen').click(function(){
  //find the html id of each track
  var trackId = $(this).attr('id')
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




})//end wrapper function
