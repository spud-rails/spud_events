//= require colorpicker/colorpicker
//= require_self

var Spud = Spud || {};
Spud.Admin = Spud.Admin || {};

Spud.Admin.Events = new function(){
  var self = this;
  
  self.init = function(){
    // Wd.Admin.tinyMce();
    self.configureColorPicker();
    self.attachCalendarDeleteFX();
  };
  
  self.configureColorPicker = function(){
    var $colorPickers = $('.spud_events_admin_color_picker'),
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
  
  self.attachCalendarDeleteFX = function() {
    $('.js-spud-calendar-delete-action').live('ajax:success', function() {
      $(this).closest('.spud_events_admin_calendar_legend_item').fadeOut(500, function(){ $(this).remove() });
    });
  }
};

$(function() {
  Spud.Admin.Events.init();
});

