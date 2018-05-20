const responsive = function(){
    let iconVisible = false;
    let favMDisplay = false;
    let favMovieDisplay = false;
    let resizedAdminTable = false;

    function removeFavMDisplay(){
        if(favMDisplay){
            $(".favmovies-title").removeClass("favm-next-to-hamburger")
            favMDisplay = false
            return true
        }
        return false
    };

    function removeFavMovieDisplay(){
        if(favMovieDisplay){
            $(".favmovies-title").removeClass("centered").removeClass('favmovie-next-to-hamburger')
            favMovieDisplay = false
            return true
        }
        return false
    };

    function handleResponsiveIcon(window_width){
        if(window_width <= 1054 && !iconVisible){
            $("#HamburgerIcon").css("display","inline")
            iconVisible = true;
            return true
        }
        else if(window_width > 1054){
            if(iconVisible){
                $("#HamburgerIcon").css("display", "none")
                menu.position("-282px")
                iconVisible = false;
            }
            if(!removeFavMDisplay())
                removeFavMovieDisplay()
            $(".favmovies-title").text("FavMovie").addClass("centered")
            return true
        }
        return false
    }

    function handleResponsiveNav(window_width){
        if(window_width <= 360 && window_width >= 299 && !favMovieDisplay){
            $(".favmovies-title").text("FavMovie").addClass("favmovie-next-to-hamburger").removeClass("centered")
            removeFavMDisplay()
            favMovieDisplay = true
            return true
        }
        else if(window_width < 299 && !favMDisplay){
            $(".favmovies-title").text("FavM").addClass("favm-next-to-hamburger").removeClass("centered")
            removeFavMovieDisplay()
            favMDisplay = true
            return true
        }
        else if(window_width < 1054 && window_width > 360){
            if(!removeFavMDisplay())
                removeFavMovieDisplay()
            $(".favmovies-title").addClass("centered").text("FavMovie")
            return true
        }
        return false
    }
    function handleResponsiveAdminTable(window_width){
        if(window_width < 622 && $("#admin-user-options").html()){
            let $th_elements = $("th")
            $th_elements[2].innerText = "act"
            $th_elements[3].innerText = "op"

            let $td_elements = $("td")
            for(let i = 0; i < $td_elements.length / 4; i++){
                let offset = i * 4
                $td_elements[offset + 2].children[0].value = "CR"
                $td_elements[offset + 3].innerText = ":d"
            }
            resizedAdminTable = true
            return true
        }

        if(window_width >= 622 && resizedAdminTable){
            let $th_elements = $("th")
            $th_elements[2].innerText = "action"
            $th_elements[3].innerText = "option"

            let $td_elements = $("td")
            for(let i = 0; i < $td_elements.length / 4; i++){
                let offset = i * 4
                $td_elements[offset + 2].children[0].value = "Change Role"
                $td_elements[offset + 3].innerText = ":delete"
            }
            resizedAdminTable = false  
            return true          
        }
        return false
    }
    return function(){
        let window_width = window.innerWidth

        let hRISuccess = handleResponsiveIcon(window_width) 
        let hRNSuccess = handleResponsiveNav(window_width)
        let hRATSuccess = handleResponsiveAdminTable(window_width)
        if (hRISuccess || hRNSuccess || hRATSuccess)
            return true
        return false
    }
}


document.addEventListener("turbolinks:load", function(){ 
    let response = responsive()
    response()
    $(window).resize( () => response() )
})