$(document).ready(function(){

  $('.going').click(function(){
    var $active = $('.going').find('.active');

    $('.top-tracks-search').stop().slideDown('slow').addClass('active');

    $active.stop().slideUp().removeClass('active');

})


})//end wrapper function
