$(document).ready(function(){
  
  $("#card_new").radioControlsVisibilityOfElement('#card_form');

  $('input[name="payment[payment_method_id]"]').change(function() {
    console.log('im changed!');
    var form = $(this).parents('form');
    form.children('label').css('display','block');
    form.children('fieldset').hide();
    $(this).parent('label').next('fieldset').show();
  }).filter(':checked').trigger('change');
  
  $('select.jump_menu').change(function(){
    window.location = this.options[this.selectedIndex].value;
  });

});
