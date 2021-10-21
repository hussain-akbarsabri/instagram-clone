document.addEventListener("turbolinks:load", function() {
  $input = $("[data-behaviour='auto-complete']")


  var options = {
    getValue: "username",
    url: function(phrase) {
      return "/search.json?q=" + phrase;
    },
    list: {
      onChooseEvent: function() {
        var url = $("#q").getSelectedItemData().url
        console.log(url)
        $input.val("")
        Turbolinks.visit(url)
      }
    }
  };

  $("#q").easyAutocomplete(options);
});