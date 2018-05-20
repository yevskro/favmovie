
document.addEventListener("turbolinks:load", function(){ 
    menu.initialize()
    $("#HamburgerIcon").on("click", function(){
        if(menu.position() === "-282px")
            menu.animate(true)
        else
            menu.animate(false)
    })
})

const menu = {
    $menu: undefined,
    animating: false,
    position: function(){
        if(arguments.length != 0)
            return this.$menu.css("left", arguments[0]) 
        return this.$menu.css("left")
    },
    initialize: function(){
        return this.$menu = $("#menu")
    },
    animate: function(show){
        let breakpoint = show ? 0 : -282
        let shift = show ? 94 : -141
        let left = show ? -282 : 0
        let id = undefined
    
        if(this.animating)
            return 

        if(show)
            $("#HamburgerIcon").attr("src", "/assets/icons/hamburger_hover.fw.png")
        
        function animateShift(){    
            if(left === breakpoint){
                clearInterval(id)
                this.animating = false
                if(!show)
                    $("#HamburgerIcon").attr("src", "/assets/icons/hamburger.fw.png")
            }
            else {
                left += shift
                this.$menu.css("left",`${left}px`)
            }
        }
    
        this.animating = true
        id = setInterval(animateShift.bind(this), 50)
    },

    handleHiddingOfMenu: function(event){
        if(this.$menu.css("left") !== "-282px"){
            if(event.clientX > 282){
                this.animate(false)
                return
            }
            
            if(this.$menu.hasClass("admin")){
                if(event.clientY > 495)// admin menu height: 420px; + plus navbar height 70px
                    this.animate(false)
            }
            else if(this.$menu.hasClass("access")){
                if(event.clientY > 245)// login sign up menu height: 170px;
                    this.animate(false)
            }
            else if(event.clientY > 413)
                this.animate(false)//282x (338 + 75) -> ending position 0, 75 -> starting position of menu, regular menu
        }    
    }
}

$(document).on("mousemove", (event) => menu.handleHiddingOfMenu(event))