
/* this is a drop down code that i did first but like it better when it comes from the side
$("#HamburgerIcon").on("click", function(){
    var menu_element = $("#menu")
    if(menu_element.hasClass("hidden")){
        $("#HamburgerIcon").attr("src", "/assets/icons/hamburger_hover.fw.png")
        var id = setInterval(animateMenu, 40)
        var height = 0
        var visibleLists = 0
        function animateMenu(){
            const MENU_ADMIN_LISTS = 5
            const MENU_ACCESS_LISTS = 2
            const MENU_NORMAL_LISTS = 4
            const HEIGHT_OF_LIST = 40 + 43;
            var element = $("#menu")
            if(element.hasClass("access")){
                if(visibleLists === MENU_ACCESS_LISTS){
                    clearInterval(id)
                    visibleLists = 0
                    height = 0
                }
                else{
                    height += HEIGHT_OF_LIST;
                    visibleLists++
                    element.css("height",`${height}px`)
                }
            }
            else if(element.hasClass("admin")){
                if(visibleLists === MENU_ADMIN_LISTS){
                    clearInterval(id)
                    visibleLists = 0
                    height = 0
                }
                else {
                    height += HEIGHT_OF_LIST;
                    visibleLists++
                    element.css("height",`${height}px`)
                }
            }
            else {
                if(visibleLists === MENU_NORMAL_LISTS){
                    clearInterval(id)
                    visibleLists = 0
                    height = 0
                }
                else {
                    height += HEIGHT_OF_LIST;
                    visibleLists++
                    element.css("height",`${height}px`)
                }
            }
        }
    }
    else{
        $("#HamburgerIcon").attr("src", "/assets/icons/hamburger.fw.png")
        menu_element.css("height", "0px")
    }
    menu_element.toggleClass("hidden")
})
}*/