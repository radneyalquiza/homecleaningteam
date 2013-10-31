//////////////////////////////////////////////////////////////////
// 
// Plugin Name: Content Transition
// Version:     0.4
// Author:      Radney Aaron Alquiza
// Rev.:        1
//  
//////////////////////////////////////////////////////////////////

/*************************************/
/* - using Transit.JS for animations
/*************************************/

/***********************************************************************************************/
/* - This little plugin will enable transitions between
/*   multiple content, be it list items, divs, etc.
/* - My main purpose in creating this plugin is to be able
/*   to navigate through my website pages through divs with
/*   transitions
/*
/**********************************************************************************************/

/**********************************************************************************************/
/* FEATURES (v0.4):
/*    - Transition between content will enable you to create
/*      simple sliders or even full page transitions
/*    - Multiple options to customize your content's transition
/*    - If there's only 1 page, the controls won't show
/**********************************************************************************************/

/**********************************************************************************************/
/* OPTIONS (v0.4):
/*      duration                    - speed of the animations (slideout, scaleup)
/*      currentPage                 - starting page
/*      addControls                 - add the left and right control buttons
/*      addPaging                   - add the pager list at the bottom of the page
/*      backgroundColorItems        - background color of the pages
/*      backgroundColorContainer    - background color of the holder
/*
/**********************************************************************************************/

/**********************************************************************************************/
/* NOTE TO PLUGIN USERS:
/*  There are quite a few elements and events added to the container
/*  when this plugin is initialized. To destroy this plugin, we must
/*  first be aware of what are being added and how they are controlling
/*  the plugin.
/*
/*  1. controlLeft (div) button
/*  2. controlRight (div) button
/*  3. pagerList (unordered list) at the bottom of the page
/*
/**********************************************************************************************/


(function ( $ ) {

    $.fn.atlasPageTrans = function (options) {


        var pagecount;                  // number of pages to cycle through
        var $children;                  // all the immediate children of this container
        var $parent;                    // this container
        var currentPage;                // current page
        var nextPage;                   // next page
        var previousPage;               // previous page
        var nextBtn;                    // button to activate nextpage()
        var prevBtn;                    // button to active previouspage()
        var $pager;                      // the page list at the bottom of the page
        var $pageitems;                  // each page list item
        var isAnimating = false;        // to prevent spam interaction

        var settings = $.extend({
            // These are the defaults.
            duration: 500,             // speed of the animations
            currentPage: 0,             // set which page to show first (0 = first page, 1 = second page, etc)
            addControls: true,          // add prev/next controls
            addPaging: true,            // add paging information at the bottom of the page
            pagerControl: "ul.pagelist",
            pagerControlItems: "li",
            backgroundColor: "#77c0d8",
            containerBackgroundColor: "#B0B0B0",
            navigationButtons : "single",
            nextPageFxn: function () { },  // member function for going forward
            prevPageFxn: function () { }   // member function for going back
        }, options);


        // NOTE: this is used to point at the container element
        //       if you're outside a member function of the plugin.

        // NOTE: $(this) is used to point at the container (or the current) element
        //       if you're inside a member function of the plugin.

        return this.each(function () {

            // initialize
            currentPage = settings.currentPage;
            $parent = $(this);
            $children = $parent.children();
            pagecount = $children.length;

            $children.eq(currentPage).addClass("current").css("opacity", 1); // this will make sure the first page is visible at page load


            // if active, add controls to the page
            if (settings.addControls == true) {
                // if less than 2 pages, don't need the controls
                if (pagecount > 1) {

                    // add controls for the page
                    if (settings.navigationButtons == "double") {
                        $(this).append("<div class='controlLeft'><div class='alignDiv'><<div class='DivHelper'></div></div></div>");
                        $(this).append("<div class='controlRight'><div class='alignDiv'>><div class='DivHelper'></div></div></div>");
                    }
                    else
                        $(this).append("<div class='controlCenter'><div class='alignDiv'>Next Page<div class='DivHelper'></div></div></div>");


                    // I can now attach events to these controls
                    $(this).find('div.controlLeft').click(function () {
                        nextBtn = $(this).find('div.controlLeft');
                        if (isAnimating) return false;
                        else
                            prevPageFxn();
                    });

                    $(this).find('div.controlRight').click(function () {
                        prevBtn = $(this).find('div.controlRight');
                        if (isAnimating) return false;
                        else
                            nextPageFxn();
                    });

                    $(this).find('div.controlCenter').click(function () {
                        prevBtn = $(this).find('div.controlCenter');
                        if (isAnimating) return false;
                        else
                            nextPageFxn();
                    });
                }
            }
            
            // this will add paging depending on the number of pages
            if (settings.addPaging == true) {
                // add a nice little pagination at the bottom of the page
                var pagerlist = "<ul class='pagelist'>";

                var listwidth =  Math.floor(100 / pagecount) - 1;

                for (var i = 0; i < pagecount; i++)
                    pagerlist += "<li id='pageitem" + i + "' style='width:" + listwidth + "%' ><div class='alignDiv'>" + (i+1) + "</div><div class='DivHelper'></div></li>";
                pagerlist += "</ul>";

                // this will automatically create DOM elements on initialize..
                $(this).append(pagerlist);

                // ..so now I can get the items to enable events!
                pager = $(this).find("ul.pagelist");
                pageitems = $(pager).children();
            }

            $children.each(function () {
                $(this).addClass("pageTransItem").css("background-color", settings.backgroundColor);
            });

            $pager = $parent.find(settings.pagerControl);
            $pageitems = $pager.children(settings.pagerControlItems);
            $pageitems.eq(currentPage).addClass("active");

        });

        // make plugin destroyable
        $.fn.atlasPageTrans.destroy = function () {

            //$(this).find(.remove();
           // that.unbind('mousemove');

        }

        function nextPageFxn() {
            
            // POTENTIAL PLUGIN FEATURE UPDATE - CYCLING THROUGH PAGES INSTEAD OF LINEAR NAVIGATION

            if (currentPage < pagecount - 1) {

                isAnimating = true;

                nextPage = currentPage + 1;

                $children.eq(currentPage).css({ transformOrigin: '0px' });

                $children.eq(currentPage).transition({
                    //perspective: '600px',
                    //rotateY: '180deg',
                    x: -2500,
                    //opacity: 0,
                    duration: settings.duration,
                    complete: function () {
                        $children.eq(currentPage - 1).removeClass("current");
                        $children.eq(currentPage - 1).removeAttr('style');
                        $children.eq(currentPage - 1).css("background-color", settings.backgroundColor);
                        
                        // for some reason, currentPage here now IS the next page
                        // so I needed to reduce it by 1 to point to the real current
                        // page being shown
                    }
                });
                
                $pageitems.eq(currentPage).removeClass("active");
                $pageitems.eq(nextPage).addClass("active");
                // $children.eq(nextPage).css("opacity", 1);
                $children.eq(nextPage).transition({
                    y: -2000,
                    x: 0,
                    opacity:0,
                     duration: 1,
                     complete: function () {
                         $children.eq(nextPage).addClass("current");
                         $children.eq(nextPage).transition({
                             y:0,
                             opacity: 1,
                             delay: 300,
                             duration: settings.duration,
                             complete: function () {
                                 isAnimating = false;
                             }
                         });
                     }
                });
                
                currentPage++;
            }
        }

        function prevPageFxn() {
            
            if (currentPage > 0) {

                isAnimating = true;

                previousPage = currentPage - 1;

                $children.eq(currentPage).css({ transformOrigin: "0px" });

                $children.eq(currentPage).transition({
                    //perspective: '600px',
                    //rotateY: '0deg',
                    x: 2500,
                    duration: settings.duration,
                    complete: function () {
                        $children.eq(currentPage + 1).removeClass("current");
                        $children.eq(currentPage + 1).removeAttr('style');
                        $children.eq(currentPage + 1).css("background-color", settings.backgroundColor);

                        // for some reason, currentPage here now IS the next page
                        // so I needed to reduce it by 1 to point to the real current
                        // page being shown
                    }
                });

                $pageitems.eq(currentPage).removeClass("active");
                $pageitems.eq(previousPage).addClass("active");
                //$children.eq(previousPage).css("opacity", 1);
                $children.eq(previousPage).transition({
                    y: -2000,
                    x: 0,
                    opacity: 0,
                    duration: 1,
                    comeplete: function () {
                        $children.eq(previousPage).addClass("current");
                        $children.eq(previousPage).transition({
                            y: 0,
                            opacity: 1,
                            delay: 300,
                            duration: settings.duration,
                            complete: function () {
                                isAnimating = false;
                            }
                        });
                    }
                });

                currentPage--;
            }
        }

    };

}(jQuery));