//Created by Michael Hemmelgarn
// Javascript function to do search autocomplete dropdown for users and images

document.addEventListener("turbolinks:load", function(){
    $input = $("[data-behavior='autocomplete']")

    var options = {
        getValue: "name",

        url: function(phrase) {
            return "/search.json?q=" + phrase;
        },
        categories: [
            {
                listLocation: "users",
                header: "<strong>Users</strong>",
            },
            {
                listLocation: "images",
                header: "<strong>Images</strong>",
            }
        ],
        list: {
            onChooseEvent: function() {
                var url = $input.getSelectedItemData().url
                Turbolinks.visit(url)
            }
        }

    }

    $input.easyAutocomplete(options)
});