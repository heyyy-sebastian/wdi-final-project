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
var checkedBoxes = $('input[name="song_vote"]').click(function() {
  var voteCount = $( "input:checked" ).length

  if(checkedBoxes.is(":checked")){
    submit.slideDown('slow');
    }

  if(voteCount > 3){
    submit.slideUp('slow');
  };
})//end votes show/hide functionality

//Add Row 1 & 2 classes to tracks
//when laoded for styling

//if this attr id is >=3, add class row-one,
//else, add class row-two

// $('.single-track').load(function(){
//     $(this).hasClass('.listen')
//   if ($(this).attr('id') === 'track-0'){
//     $(this).addClass("row-one");
//   }else{
//     $('.single-track').addClass("row-two");
//   }

// })


})//end wrapper function
