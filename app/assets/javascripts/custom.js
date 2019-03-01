$( document ).on('turbolinks:load', (function () {
    $('.timepicker').datetimepicker({
        format: 'LT',
        //pickDate: false
    });
}));


$( document ).on('turbolinks:load', (function() {
   // Bootstrap DateTimePicker v4
   $('.datepicker').datetimepicker({
         format: 'DD/MM/YYYY',
         //pickTime: false
   });
}));
