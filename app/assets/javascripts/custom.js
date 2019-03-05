

$( document ).on('turbolinks:load', (function () {
    // moment.tz("Asia/Karachi");
    // vaa = moment.tz(new Date(), "Asia/Karachi" );
    $('.timepicker').datetimepicker({
        // useCurrent: false,
        // language: 'en',
        format: 'LT'
        // defaultDate: vaa,
        // sideBySide: true,
        // inline: true
      //  //pickDate: false
    });
}));


$( document ).on('turbolinks:load', (function() {
   // Bootstrap DateTimePicker v4
   $('.datepicker').datetimepicker({
         format: 'DD/MM/YYYY',
         //pickTime: false
   });
}));
