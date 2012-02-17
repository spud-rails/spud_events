//= require colorpicker/colorpicker
//= require_self

var Spud = Spud || {};
Spud.Admin = Spud.Admin || {};

Spud.Admin.Events = new function(){
  var self = this;
  
  self.init = function(){
    // Wd.Admin.tinyMce();
    self.configureColorPicker();
  };
  
  self.configureColorPicker = function(){
    var $colorPickers = $('.wd_admin_color_picker'),
        $calendarColor = $('#spud_calendar_color');

    if($colorPickers.size() > 0) {
      $colorPickers.css('backgroundColor', '#' + $calendarColor.val());
      $colorPickers.ColorPicker({
        color:  $calendarColor.val(),
        onShow: function (colpkr) {
          console.log("show")
  		    $(colpkr).fadeIn(500);
  		    return false;
        },
        onHide: function (colpkr) {
          console.log("hide")
          $(colpkr).fadeOut(500);
  		    return false;
        },
        onChange: function (hsb, hex, rgb) { 
          console.log("change")
          
          $colorPickers.css('backgroundColor', '#' + hex);
          $calendarColor.attr('value', hex);
        }
      });
    }
  };
};

$(function() {
  Spud.Admin.Events.init();
});

