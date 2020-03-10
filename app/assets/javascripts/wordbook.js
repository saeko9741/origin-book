$(function() {
  $(document).on('click', '.sign_button', function() {
    $('.sign_modal_wrapper').show();
    $('.sign_modal').show();
    if ($(this).hasClass('sign_up_button')) {
      $('.sign_up_modal').show();
    } else {
      $('.sign_in_modal').show();
    }
  });
});
$(document).on('click', '.sign_modal_wrapper, .wrapper', function() {
    $('.sign_modal_wrapper').hide();
    $('.sign_modal').hide();
    $('.sign_modal_content').hide();
})