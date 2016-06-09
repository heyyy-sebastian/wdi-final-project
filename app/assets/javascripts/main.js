$(document).ready(function(){

  $('.going').click(function(){
    var $active = $('.going').find('.active');

    $('.top-tracks-search').stop().slideDown('slow').addClass('active');

    $active.stop().slideUp().removeClass('active');

})//end concert details expansion

$('.listen').click(function(){

var ugh = $('.listen').attr('id')
//link_id = $('.listen').attr('id')
if(ugh == 'track-4'){
  link_test = ugh.attr('value')
  var audio = new Audio(link_test);
  audio.play();
}
//link = $('#track-'+'5'||'4'||'3'||'2'||'1'||'0').attr('value')
// var audio = new Audio(link);

// audio.play();
})//ugh

// $('.listen').click(function(e) {
//     var target = e.target;
//     if (target !== null) {
//         if (target.classList.contains(playingCssClass)) {
//             audioObject.pause();
//         } else {
//             if (audioObject) {
//                 audioObject.pause();
//             }

//             fetchTracks(target, function (data) {
//                 link = $('.listen').val();
//                 audioObject = new Audio(link);

//                 audioObject.play();
//                 target.classList.add(playingCssClass);

//                 audioObject.addEventListener('ended', function() {
//                     target.classList.remove(playingCssClass);
//                 });

//                 audioObject.addEventListener('pause', function() {
//                     target.classList.remove(playingCssClass);
//                 });
//             });
//         }
//     }
// });//end audioplayer attempt



})//end wrapper function
