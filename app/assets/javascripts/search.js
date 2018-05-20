const sortMovieObjects = function( objects ){
    return objects.sort(function(a,b){
        return a["name"] > b["name"]
    })
}


const search = function( event ) {
   $.get("http://localhost:3000/movies/search", {"title" : $("#Search-Bar").val()}, function(data, status){
        if(status === "success"){
           let searchTemplate = $("#search-template").html()
           let sorted_objects = sortMovieObjects(data)
           let templateFn = _.template(searchTemplate)
           let templateHTML = templateFn({movies: sorted_objects})
           $(".centering.text-center").html(templateHTML)
        }
    })
}

const attachListeners = function(){
    $("#Search").click( () => search() )
    $("#SearchIcon").click( () => search() )
    $("#Search-Bar").keypress( event => (event.KeyCode == 13 || event.which == 13) ? search() : undefined )
}

document.addEventListener("turbolinks:load", function(){ 
    attachListeners()
})
