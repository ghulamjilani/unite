jQuery(document).ready(function(){
    if(jQuery('body').hasClass('about-page')){
        $('.sliderAboutPage .slides').owlCarousel({
            loop:true,
            margin:10,
            nav:true,
            navText:'',
            center:true,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:3
                },
                1000:{
                    items:5
                }
            }
        })
    }
});
