/* FOR RTQ WEB APPLICATION */

var bathoptions;
var bedoptions;
var kitchenoptions;
var diningoptions;
var livingoptions;
var officeoptions;

var cleaning;
var cleaningtypetext = "";
var editing = false;
var showtoolsflag = false;

var bathcount = 0;
var bedcount = 0;

var showing = 1;
var pages = 1;

// this will contain whatever is in the quote and whatever is
// selected by the user
var mainData;
var allroomdata;

var numbath = 0;   // global value for number of bathrooms
var numbed = 0;    // global value for number of bedrooms
var $container;    // container for masonry flavoured pages

// 2d arrays
var bathroomservice;
var bedroomservice;

var kitchenservice;
var diningroomservice;
var livingroomservice;
var officeservice;

// 1d radio arrays
var bathroomradios;
var bedroomradios;

// 2d radio arrays
var kitchenradios;
var diningroomradios;
var livingroomradios;
var officeradios;

var nextclonecheckboxes;

// for pre-defined number selections
var numofitems = 25;
// the user selection for number of items
// (to begin with, we can 
var selectednumofitems;

var noteenabled = false;    // if laundry items is selected

// total rtq service time
var totalTime = 0;

// name of the property
var propertyName = "Default Property";

var roomActive = false;

// price (time in hours multiplied by 25 and by other factors)
var totalPrice = 0;

// i can initialize these 2 arrays because they are
// always only 1 dimensional. just a list of all duplicate-able options/sub options
var whichChecksToApply = new Array();
var whichRadiosToApply = new Array();

// invoice file path
var invoice = "";

// quote type that was selected
var quotetype = "";

var currentRoom = 0;

var quotepath = "";

// ====================================================
// SIMPLE ANIMATION FOR THE TOPBAR
// ====================================================
function slideTopBar() {
    $('.topBar').addClass('topBar-pullup');
    $('.pad').css('padding-top', '40px');
    $('.topBar h1').hide();//.html('RTQ&#0153;');
    $('.topBar h4').hide();
    $('.topBar .topBarDiv').addClass('topBarDiv-pullup').append('<p>Real-Time Quote System <span>by The Home Cleaning Team</span></p>');
    $('.topBar .topBarDiv').append('<input type="button" id="reset" class="resetBtn" value="Reset RTQ" />');

    $("#reset").click(function () { location.reload(); });
    $(".propertyquestionsclass").css('margin-top', '50px');
}

// ===================================================================================================
// callRooms(cleaningtype) - FUNCTION FOR GETTING ALL ROOM DATA
// param: cleaningtype, string
// return: long string
// ===================================================================================================
function callRooms(cleaningtype) {
    $("#loadercontainer").show();
    setTimeout(function () {
        $.ajax({
            type: 'POST',
            url: 'qQuote.aspx/callAllRooms',
            data: '{ "cleaningtype" : "' + cleaningtype + '"}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            async: true,
            success: function (data) {
                var roomData;   // this is an array of roomdatadto (there is usually a pair; one default)
                var catflag = false;
                if (data.hasOwnProperty('d'))
                    roomData = JSON.parse(data.d);
                else
                    roomData = JSON.parse(data);
                allroomdata = roomData;

                var finaldata = "<div class='roomgroupdiv'>";
                if (roomData.length > 0) {
                    // get the first room (kitchen) and get its apps for the categories
                    finaldata += formatCategories(roomData[0][0]);
                    // loop through all rooms
                    finaldata += "<div class='roomgrouplistcontainer'><div class='preview-cover'></div>";
                    finaldata += "<ul class='page1'>";
                    for (var i = 0; i < roomData.length; i++) {

                        var filtered = roomData[i][0];
                        var def = roomData[i][1];
                        //console.log(filtered);
                        var rcount = 1;
                        // if the room is bath or bed, check if the count is greater than 1
                        if (def.RoomName == "Bathroom" || def.RoomName == "Bedroom") {
                            if (bedcount > 0 || bathcount > 0) {
                                if (def.RoomName == "Bathroom")
                                    rcount = bathcount;
                                if (def.RoomName == "Bedroom")
                                    rcount = bedcount;
                            }
                            else rcount = 0;
                        }
                        // loop through the number of rooms ( 1 =< baths, and 1 for the rest)
                        for (var j = 0; j < rcount; j++) {
                            finaldata += "<li class='listroom' data-roomname='" + filtered.RoomName.replace(' ', "").toLowerCase() + "'>";
                            if (filtered.RoomName == "Bathroom" || filtered.RoomName == "Bedroom") {
                                finaldata += formatFiltered(filtered, j + 1, cleaningtype);
                                finaldata += formatExtra(def, j + 1, cleaningtype);
                            }
                            else {
                                finaldata += formatFiltered(filtered, "", cleaningtype);
                                finaldata += formatExtra(def, "", cleaningtype);
                            }
                            finaldata += "</li>";
                        }
                    }
                    finaldata += "</ul>";
                    finaldata += "<ul class='page2'></ul>";   // extra container
                    finaldata += "<ul class='page3'></ul>";   // extra container
                    finaldata += "</div>";  // closing for roomgrouplistcontainer
                }
                finaldata += "</div>"; // closing for roomgroupdiv

                // call needed functions
                $("#quoteSample #rooms").html(finaldata);
                attachOptionEvents($(".roomgrouplistcontainer .app .option"));
                attachSubOptionEvents($(".roomgrouplistcontainer .app .option .subs li"));
                distributeRooms($('.roomgroupdiv .roomgrouplistcontainer ul li.listroom'));
                $("#loadercontainer").hide();
                slideMenu($("#serv"), null);
            },
            error: function (data) {
                alert("Something's wrong with our server. Please try again later.");
            }
        });
    }, 700);
}

// ===================================================================================================
// formatFiltered(data) - FUNCTION FOR FORMATTING ALL FILTERED DATA
// param: data, (JSON) string
// return: long string
// ===================================================================================================
function formatFiltered(data, num, cleaningtype) {
    var html = "";
    var apps = data.Apps;
    var room = data.RoomName + " " + num;
    
    html += "<div class='room-wrap'><div class='room main' data-roomname='" + room + "'><span class='roomname'>" + room + "</span>";
    html += "<div class='cover-click'></div>";      // event trigger for editing the room
    for (var i = 0; i < apps.length; i++) {
        html += "<div class='mn app' data-appname='" + apps[i].AppName + "'>";    // wrap all options inside a app container
        html += "<span class='mn catname' data-appname='" + apps[i].AppName + "'><span>" + apps[i].AppName + "</span></span>";
        for (var j = 0; j < apps[i].Options.length; j++) {
            var option = apps[i].Options[j];
            if (option.TimeUnit != null)
                html += "<div class='option'><span class='optionname'>" + option.OptionName + "</span></div>";
            else {
                html += "<div class='option hasSub'>";
                if (option.CType == "N/A") {
                    html += "<span class='optionname'>" + option.OptionName + "</span>";
                    html += "  <div class='subs'><ul>";
                    for (var k = 0; k < option.Subs.length; k++) {
                        html += "  <li><span class='optionname'>" + option.Subs[k].OptionName + "</span></li>";
                    }
                    html += "    </ul></div>";  // closing for subs div and subs list
                }
                else {
                    for (var k = 0; k < option.Subs.length; k++) {
                        if (option.Subs[k].CType.indexOf(cleaningtype) > -1) {
                            html += "<span class='optionname'>" + option.Subs[k].OptionName + "</span>";
                            break;
                        }
                    }
                    html += "  <div class='subs'><ul>";
                    for (var k = 0; k < option.Subs.length; k++) {
                        if (option.Subs[k].CType.indexOf(cleaningtype) < 0)
                            html += "  <li><span class='optionname'>" + option.Subs[k].OptionName + "</span></li>";
                        else
                            html += "  <li class='hidden'><span class='optionname'>" + option.Subs[k].OptionName + "</span></li>";
                    }
                    html += "    </ul></div>";  // closing for subs div and subs list
                }

                html += "</div>";       // closing for option div
            }
        }
        html += "</div>";   // closing for app
    }
    html += "</div>";   // closing for room
    return html;
}

// ===================================================================================================
// formatExtra(data) - FUNCTION FOR FORMATTING ALL EXTRA DATA
// param: data, (JSON) string
// return: long string
// ===================================================================================================
function formatExtra(data, num) {
    var html = "";
    var apps = data.Apps;
    var room = data.RoomName + " " + num;
    
    html += "<div class='room extra' data-roomname='" + room + "'><span>Extra " + $.trim(room) + " Cleaning Options</span>";
    for (var i = 0; i < apps.length; i++) {
        html += "<div class='xtra app' data-appname='" + apps[i].AppName + "'>";    // wrap all options inside a app container
        for (var j = 0; j < apps[i].Options.length; j++) {
            var option = apps[i].Options[j];
            if (option.TimeUnit != null)
                html += "<div class='option'><span class='optionname'>" + option.OptionName + "</span></div>";
            else {
                var foundname = false;
                html += "<div class='option hasSub'>";
                html += "<span class='optionname'>" + option.OptionName + "</span>";
                html += "  <div class='subs'><ul>";
                for (var k = 0; k < option.Subs.length; k++) {
                        html += "  <li><span class='optionname'>" + option.Subs[k].OptionName + "</span></li>";
                }
                html += "    </ul></div>";  // closing for subs div and subs list
                html += "</div>";       // closing for option div
            }
        }
        html += "</div>";   // closing for app
    }
    html += "</div></div>";   // closing for room & closing for room-wrap which is from the main
    return html;
}

// ===================================================================================================
// formatCategories(data) - FUNCTION FOR FORMATTING ALL CATEGORY/APP DATA
// param: data, (JSON) string
// return: long string
// ===================================================================================================
function formatCategories(data) {
    var html = "";
    var apps = data.Apps;

    html += '<div class="categoriesdiv"><div class="title">Categories</div>';
    html += '  <ul class="categorieslist">';
    for (var i = 0; i < apps.length; i++) {
        html += '  <li><span>' + apps[i].AppName + '</span></li>';
    }
    html += '  </ul>';
    html += '</div>';
    return html;
}

// ===================================================================================================
// attachOptionEvents(optionlist) - events for the options themselves
// param: optionlist - all options
// return: 
// ===================================================================================================
function attachOptionEvents(optionlist) {
    $(optionlist).each(function () {
        var option = $(this);
        option.append('<span class="remove"></span>');

        // FOR CLICKS ON OPTIONS
        if (option.hasClass('hasSub')) {
            option.on('click', function (e) {
                e.stopPropagation();
                $(this).find('.subs').show(100);
            });
        }

        // FOR HOVER OVER OPTIONS
        option.hover(function (e) {
            e.stopPropagation();
            $(this).find('.remove').toggle(); // ALL options have remove buttons
            $(this).find('.optionname').toggleClass('green');
        });

        option.find('.remove').on('click', function (e) {
            e.stopPropagation();
            var origoptionheight = $(this).parent().outerHeight();
            $(this).parent().slideUp(100, function () {
                var appname = $(this).parent().data('appname');
                var cont;   // destination of the clicked option
                var origcont; // the origin of the clicked option
                var curtain = $(this).parents('.room.main').find('.curtain');
                var cat = $(this).parents('.room.main').find('.mn.catname').filter(function() {
                    return $(this).data('appname') === appname;
                });

                if ($(this).parents('.app').hasClass('mn')) {
                    cont = $(this).parents('.room.main').find('.xtra.app').filter(function () {
                        return $(this).data('appname') === appname;
                    });
                    origcont = $(this).parents('.room.main').find('.mn.app').filter(function () {
                        return $(this).data('appname') === appname;
                    });
                }
                else {
                    cont = $(this).parents('.room.main').find('.mn.app').filter(function () {
                        return $(this).data('appname') === appname;
                    });
                    origcont = $(this).parents('.room.main').find('.xtra.app').filter(function () {
                        return $(this).data('appname') === appname;
                    });
                    
                }
                var appheight = cont.outerHeight();
                var options = cont.find('.option');
                var optionsheight = 0;
                options.each(function () { optionsheight += $(this).outerHeight(); });
                //console.log(appheight + " vs " + (optionsheight + origoptionheight));
                if (appheight < (optionsheight + origoptionheight)) {
                    if (optionsheight + origoptionheight < 1)
                        cont.outerHeight(23);
                    else
                        cont.outerHeight(optionsheight + origoptionheight);
                    origcont.outerHeight(optionsheight + origoptionheight);
                    curtain.outerHeight(curtain.outerHeight() + origoptionheight);
                }
                origcont.outerHeight(cont.outerHeight());
                cat.outerHeight(cont.outerHeight());
                
                //cont.data('currentHeight', cont.outerHeight());
                //recalcRoomHeightByExtras($(this).parents('.room.main'));
                
                $(this).appendTo(cont).slideDown(100, function () {
                    //if(origcont.hasClass('xtra'))
                        addEmptyMessage(origcont);

                    //if(cont.hasClass('xtra'))
                        addEmptyMessage(cont);
                });
            });
        });
    });
}

// ===================================================================================================
// distributeRooms(rooms) - will divide the rooms into sections
// params: room - a list of rooms
// return:
// ===================================================================================================
function distributeRooms(rooms) {
    console.log('dist');
    var rms = $('.roomgrouplistcontainer ul li.listroom');
    
    // case 1
    if (bathcount == 1 && bedcount == 1) {
        var pg1 = rms.filter(function () {
            if ($(this).data('roomname') == 'kitchen' ||
                $(this).data('roomname') == 'bedroom' ||
                $(this).data('roomname') == 'bathroom')
                return $(this);
        });
        var pg2 = rms.filter(function () {
            if ($(this).data('roomname') == 'diningroom' ||
                $(this).data('roomname') == 'livingroom' ||
                $(this).data('roomname') == 'office')
                return $(this);
        });
        pages = 2;
        pg1.each(function () { if($(this).parents('ul.page1').length < 1) $(this).appendTo('ul.page1'); });
        pg2.each(function () { if($(this).parents('ul.page2').length < 1) $(this).appendTo('ul.page2'); });
    }
    // case 2
    if (bathcount == 1 && bedcount == 2 || bathcount == 2 && bedcount == 1) {

        if (bedcount == 2) {
            var pg1 = rms.filter(function () {
                if ($(this).data('roomname') == 'kitchen' ||
                    $(this).data('roomname') == 'bathroom' ||
                    $(this).data('roomname').indexOf('bedroom') > -1)
                    return $(this);
            });
        }
        if (bathcount == 2) {
            var pg1 = rms.filter(function () {
                if ($(this).data('roomname') == 'kitchen' ||
                    $(this).data('roomname') == 'bedroom' ||
                    $(this).data('roomname').indexOf('bathroom') > -1)
                    return $(this);
            });
        }
        var pg2 = rms.filter(function () {
            if ($(this).data('roomname') == 'diningroom' ||
                $(this).data('roomname') == 'livingroom' ||
                $(this).data('roomname') == 'office')
                return $(this);
        });
        pages = 2;
        pg1.each(function () { if ($(this).parents('ul.page1').length < 1) $(this).appendTo('ul.page1'); });
        pg2.each(function () { if ($(this).parents('ul.page2').length < 1) $(this).appendTo('ul.page2'); });

        // pg1 kitchen,bed1,bed2,bath1
        // or
        // pg1 kitchen,bath1,bath2,bed1
        // pg2 dining,living,office
    }
    // case 3
    if (bathcount == 2 && bedcount == 2) {
        var pg1 = rms.filter(function () {
            if ($(this).data('roomname') == 'kitchen' ||
                $(this).data('roomname') == 'diningroom' ||
                $(this).data('roomname') == 'livingroom' ||
                $(this).data('roomname') == 'office')
                return $(this);
        });
        var pg2 = rms.filter(function () {
            if ($(this).data('roomname').indexOf('bathroom') > -1 ||
                $(this).data('roomname').indexOf('bedroom') > -1)
                return $(this);
        });
        pages = 2;
        pg1.each(function () { if ($(this).parents('ul.page1').length < 1) $(this).appendTo('ul.page1'); });
        pg2.each(function () { if ($(this).parents('ul.page2').length < 1) $(this).appendTo('ul.page2'); });

        // pg1 kitchen, diningroom, livingroom, office
        // pg2 bath1,bath2,bed1,bed2
    }
    // case 4
    if (bathcount == 3 && bedcount == 0) {
        var pg1 = rms.filter(function () {
            if ($(this).data('roomname') == 'kitchen' ||
                $(this).data('roomname').indexOf('bathroom') > -1)
                return $(this);
        });
        var pg2 = rms.filter(function () {
            if ($(this).data('roomname') == 'diningroom' ||
                $(this).data('roomname') == 'livingroom' ||
                $(this).data('roomname') == 'office')
                return $(this);
        });
        pages = 2;
        pg1.each(function () { if ($(this).parents('ul.page1').length < 1) $(this).appendTo('ul.page1'); });
        pg2.each(function () { if ($(this).parents('ul.page2').length < 1) $(this).appendTo('ul.page2'); });

        // pg1 kitchen, bath1, bath2, bath3
        // pg2 dinig, living, office
    }
    // case 5
    if (bedcount == 3 && bathcount == 0) {
        var pg1 = rms.filter(function () {
            if ($(this).data('roomname') == 'kitchen' ||
                $(this).data('roomname').indexOf('bedroom') > -1)
                return $(this);
        });
        var pg2 = rms.filter(function () {
            if ($(this).data('roomname') == 'diningroom' ||
                $(this).data('roomname') == 'livingroom' ||
                $(this).data('roomname') == 'office')
                return $(this);
        });
        pages = 2;
        pg1.each(function () { if ($(this).parents('ul.page1').length < 1) $(this).appendTo('ul.page1'); });
        pg2.each(function () { if ($(this).parents('ul.page2').length < 1) $(this).appendTo('ul.page2'); });

        // pg1 kitchen, bed1, bed2, bed3
        // pg2 dining, living, office
    }
    if (bathcount == 3 && bedcount == 3) {
        var pg1 = rms.filter(function () {
            if ($(this).data('roomname') == 'kitchen' ||
                $(this).data('roomname').indexOf('bathroom') > -1)
                return $(this);
        });
        var pg2 = rms.filter(function () {
            if ($(this).data('roomname').indexOf('bedroom') > -1)
                return $(this);
        });
        var pg3 = rms.filter(function () {
            if ($(this).data('roomname') == 'diningroom' ||
                $(this).data('roomname') == 'livingroom' ||
                $(this).data('roomname') == 'office')
                return $(this);
        });
        pages = 3;
        pg1.each(function () { if ($(this).parents('ul.page1').length < 1) $(this).appendTo('ul.page1'); });
        pg2.each(function () { if ($(this).parents('ul.page2').length < 1) $(this).appendTo('ul.page2'); });
        pg3.each(function () { if ($(this).parents('ul.page3').length < 1) $(this).appendTo('ul.page3'); });

        // pg1 kitchen, bath1, bath2, bath3
        // pg2 bed1, bed2, bed3
        // pg3 dining, living, office
    }
    if (bathcount == 4 && bedcount == 4) {
        var pg1 = rms.filter(function () {
            if ($(this).data('roomname').indexOf('bathroom') > -1)
                return $(this);
        });
        var pg2 = rms.filter(function () {
            if ($(this).data('roomname').indexOf('bedroom') > -1)
                return $(this);
        });
        var pg3 = rms.filter(function () {
            if ($(this).data('roomname') == 'kitchen' ||
                $(this).data('roomname') == 'diningroom' ||
                $(this).data('roomname') == 'livingroom' ||
                $(this).data('roomname') == 'office')
                return $(this);
        });
        pages = 3;
        pg1.each(function () { if ($(this).parents('ul.page1').length < 1) $(this).appendTo('ul.page1'); });
        pg2.each(function () { if ($(this).parents('ul.page2').length < 1) $(this).appendTo('ul.page2'); });
        pg3.each(function () { if ($(this).parents('ul.page3').length < 1) $(this).appendTo('ul.page3'); });

        // pg1 bath1, bath2, bath3, bath4
        // pg2 bed1, bed2, bed3, bed4
        // pg3 kitchen, dining, living, office
    }
    if (bathcount == 4 && bedcount == 0) {
        var pg1 = rms.filter(function () {
            if ($(this).data('roomname').indexOf('bathroom') > -1)
                return $(this);
        });
        var pg2 = rms.filter(function () {
            if ($(this).data('roomname') == 'kitchen' ||
                $(this).data('roomname') == 'diningroom' ||
                $(this).data('roomname') == 'livingroom' ||
                $(this).data('roomname') == 'office')
                return $(this);
        });
        pages = 2;
        pg1.each(function () { if ($(this).parents('ul.page1').length < 1) $(this).appendTo('ul.page1'); });
        pg2.each(function () { if ($(this).parents('ul.page2').length < 1) $(this).appendTo('ul.page2'); });

        // pg1 bath1, bath2, bath3, bath4
        // pg2 kitchen, dining, living, office
    }
    if (bedcount == 4 && bathcount == 0) {
        var pg1 = rms.filter(function () {
            if ($(this).data('roomname').indexOf('bedroom') > -1)
                return $(this);
        });
        var pg2 = rms.filter(function () {
            if ($(this).data('roomname') == 'kitchen' ||
                $(this).data('roomname') == 'diningroom' ||
                $(this).data('roomname') == 'livingroom' ||
                $(this).data('roomname') == 'office')
                return $(this);
        });
        pages = 2;
        pg1.each(function () { if ($(this).parents('ul.page1').length < 1) $(this).appendTo('ul.page1'); });
        pg2.each(function () { if ($(this).parents('ul.page2').length < 1) $(this).appendTo('ul.page2'); });

        // pg1 bed1, bed2, bed3, bed4
        // pg2 kitchen, dining, living, office
    }
    if (bathcount > 2 && bedcount < 3) {
        var pg1 = rms.filter(function () {
            if ($(this).data('roomname').indexOf('bathroom') > -1)
                return $(this);
        });
        var pg2 = rms.filter(function () {
            if ($(this).data('roomname') == 'kitchen' ||
                $(this).data('roomname').indexOf('bedroom') > -1)
                return $(this);
        });
        var pg3 = rms.filter(function () {
            if ($(this).data('roomname') == 'diningroom' ||
                $(this).data('roomname') == 'livingroom' ||
                $(this).data('roomname') == 'office')
                return $(this);
        });
        pages = 3;
        pg1.each(function () { if ($(this).parents('ul.page1').length < 1) $(this).appendTo('ul.page1'); });
        pg2.each(function () { if ($(this).parents('ul.page2').length < 1) $(this).appendTo('ul.page2'); });
        pg3.each(function () { if ($(this).parents('ul.page3').length < 1) $(this).appendTo('ul.page3'); });

        // pg1 bath1, bathN
        // pg2 kitchen, bed1, bed2
        // OR pg2 kitchen, bed, dining, living, office
        // OR pg3 dining, living, office
    }

    if (bedcount > 2 && bathcount < 3) {
        var pg1 = rms.filter(function () {
            if ($(this).data('roomname').indexOf('bedroom') > -1)
                return $(this);
        });
        var pg2 = rms.filter(function () {
            if ($(this).data('roomname') == 'kitchen' ||
                $(this).data('roomname').indexOf('bathroom') > -1)
                return $(this);
        });
        var pg3 = rms.filter(function () {
            if ($(this).data('roomname') == 'diningroom' ||
                $(this).data('roomname') == 'livingroom' ||
                $(this).data('roomname') == 'office')
                return $(this);
        });
        pages = 3;
        pg1.each(function () { if ($(this).parents('ul.page1').length < 1) $(this).appendTo('ul.page1'); });
        pg2.each(function () { if ($(this).parents('ul.page2').length < 1) $(this).appendTo('ul.page2'); });
        pg3.each(function () { if ($(this).parents('ul.page3').length < 1) $(this).appendTo('ul.page3'); });

        // pg1 bed1, bedN
        // pg2 kitchen, bath1, bath2
        // OR pg2 kitchen, bed, dining, living, office
        // OR pg3 dining, living, office
    }

    // attach the events for paging IF there are a lot of rooms
    $('.nextGroup').on('click', function (e) { e.stopPropagation(); nextGroup(); });
    $('.prevGroup').on('click', function (e) { e.stopPropagation(); prevGroup(); });
    //console.log('pages ' + pages);
    setupDisplay();
    $('.page2').hide();
    $('.page3').hide();
}

function nextGroup() {
    // at the beginning of the app, showing is 1
    //console.log(showing + " " + pages);
    if (showing < pages && showing > 0) {
        var current = $('.page' + showing);
        var next = $('.page' + (showing + 1));
        if (next.length > 0 || next != null) {
            current.hide(100, function () { next.show(200); });
            recalcRoomsHeight($(".roomgrouplistcontainer>ul.page" + showing + ">li.listroom"));
            showing++;
        }
    }
}
function prevGroup() {
    // at the beginning of the app, showing is 1
    //console.log(showing + " " + pages);
    if (showing <= pages && showing > 1) {
        var current = $('.page' + showing);
        var prev = $('.page' + (showing - 1));
        if (prev.length > 0 || prev != null) {
            current.hide(100, function () { prev.show(200); });
            recalcRoomsHeight($(".roomgrouplistcontainer>ul.page" + showing + ">li.listroom"));
            showing--;
        }
    }
}

// ===================================================================================================
// attachSubOptionEvents(suboptionlist) - events for the options themselves
// param: suboptionlist - all suboptions
// return: 
// ===================================================================================================
function attachSubOptionEvents(suboptionlist) {
    $(suboptionlist).each(function () {
        var option = $(this);
        option.on('click', function (e) {
            e.stopPropagation();
            // show all selected options (hidden)
            $(this).parents('.subs').find('li.hidden').removeClass('hidden');
            // hide this clicked option
            $(this).addClass('hidden');
            $(this).parents('.subs').fadeOut(100);
            $(this).parents('.option').children('.optionname').text($(this).find('.optionname').text());
        });
    });
}

// ===================================================================================================
// attachExtraOptionEvents(extraoptionlist) - events for the options transfer
// param: extraoptionlist - all extra options
// return: 
// ===================================================================================================
function attachExtraOptionEvents(extraoptionlist) {

}

// ===================================================================================================
// setupDisplay() - hide whatever is needed to be hidden, reformat stuff
// param: 
// return: 
// ===================================================================================================
function setupDisplay() {
    $('.extra').hide(); // hide all extra options for all rooms
    $('.remove').hide(); // hide all x buttons inside the options
    $("#quoteSample").fadeIn(300);

    $(".roomgroupdiv").addClass('part');
   // console.log('pages ' + pages);
    if (pages > 1) {
        $('.nextGroup').show(100);
        $('.prevGroup').show(100);
    }
    var pagesr = $(".roomgrouplistcontainer>ul");
    var cont = $('.roomgrouplistcontainer');
    //console.log('setup');
    $.each(pagesr, function () {
        var listrooms = $(this).find('li.listroom');
        //console.log(listrooms);
        if(listrooms.length > 0)
            resizeHandler(listrooms);    // relayout the rooms for initial display or on window resize
    });

    setPreviewCoverAndSubs(cont);
}

function setPreviewCoverAndSubs(cont) {
    var ht = cont.outerHeight();
    var wt = cont.outerWidth();
    $('.preview-cover').css({
        'height': ht,
        'width': wt
    }).show();

    // before hiding the subs, set their positions relative to the options
    $('.subs').each(function () {
        $(this).css('margin-top', (($(this).height() / 2) * -1) + 'px');
        $(this).hide();
    });
}

// ===================================================================================================
// recalcRoomsHeight() - recalculate the heights of containers that changed
// param: list - list of room divs
// return: 
// ===================================================================================================
function recalcRoomsHeight(list) {
    var apps = new Array();
    $.each(list, function () {
        var room = $(this);
        var appsinroom = room.find('.main .mn.app');
        $.each(appsinroom, function () {
            if (!apps.contains($(this).data('appname')))
                apps.push($(this).data('appname'));
        });
    });
    // once we get all the unique apps
    for (var i = 0; i < apps.length; i++) {
        var appswithname = $(".main .mn.app").filter(function () {
            return $(this).data('appname') === apps[i];
        });
        //console.log(appswithname);
        var max = findMaxHeight(appswithname);
        for (var j = 0; j < appswithname.length; j++) {
            var category = $('.categoriesdiv ul li span').filter(function () {
                return $(this).text() === apps[i];
            });
            //console.log(category);
            $(appswithname[j]).outerHeight(max);
            $(category).parents('li').outerHeight(max);
            $(category).parents('li').find('span').each(function() {
                $(this).css('margin-top', ($(this).outerHeight()/2)*-1);
            });
        }
    }
    $.each(list, function () {
        resizeCover($(this));
    });
}

// ===================================================================================================
// setRoomCover() - cover the rooms to propagate event
// param: 
// return: 
// ===================================================================================================
function setRoomCover(roomlist) {
    //console.log('covers:');
    //console.log(roomlist);
    if (roomlist.length > 0) {
        //console.log(roomlist);
        $.each(roomlist, function () {
            var ht = $(this).outerHeight();
            var wt = $(this).outerWidth();
            var pos = $(this).offset();
            var cover = $(this).find('.cover-click');
            $(cover).css('height', ht + 1);
            $(cover).css('width', wt);

            // set the event here too
            if (!$(cover).hasClass('hasEvent')) {
                console.log('no event for cover yet, add');
                $(cover).click(function (e) {
                    //console.log('open');
                    e.stopPropagation();
                    $(this).parents('.roomgrouplistcontainer ul').find('.cover-click').show();
                    $(this).fadeOut(500);
                    // call the curtain
                    showExtras($(this).parents('.room.main'));

                    /*$('body').click(function (e) {
                        // if somewhere else is clicked and we're not editing, cover the rooms up
                        if (e.target != $('.cover-click') || e.target != $('.roomgrouplistcontainer ul') && editing == false)
                            $('.cover-click').show();
                    });*/
                });
                $(cover).addClass('hasEvent');
            }

        });
    }
}

// ===================================================================================================
// setSideMenuEvents(menu) - interaction events for the side menu for rtq
// slideMenu(menu) - the event that will be attached to the side button to show or hide the menu
// param: menu container
// return: 
// ===================================================================================================

function setSideMenuEvents(menu) {
    var button = menu.find('.sidebutton');
    button.on('click', function () { $(this).toggleClass('close'); slideMenu($(menu), "hide"); });
}

function slideMenu(menu, state) {
    var wt = $(menu).outerWidth();
    var pos = $(menu).position();
        
    // if the state is "hide", hide the sidemenu
    if (state == "hide") {
        if (pos.left < 0) {
            $(menu).css({ 'left': pos.left + wt });
            $(".roomgroupdiv").addClass('part');
            // get all pages
            var conta = $(".roomgrouplistcontainer");
            //setPreviewCoverAndSubs(conta);
            var pagesr = $(".roomgrouplistcontainer>ul");
            console.log('hey ' + pagesr.length);
            $.each(pagesr, function () {
                resizeHandler($(this).find('li.listroom'), "");
            });
        }
        else {
            $(menu).css({ 'left': pos.left - wt });
            $(".roomgroupdiv").removeClass('part');
            // get all pages
            var conta = $(".roomgrouplistcontainer");
            //setPreviewCoverAndSubs(conta);
            var pagesr = $(".roomgrouplistcontainer>ul");
            $.each(pagesr, function () {
                resizeHandler($(this).find('li.listroom'), "");
            });
        }
    }
    $(menu).find('.sidebutton').fadeIn(500).addClass('close');
}

// ===================================================================================================
// resizeHandler(list) - adapts the list of rooms whenever the window size is changed
// param: list of elements to resize amongst each other
// return: 
// ===================================================================================================
function resizeHandler(list, state) {
    var count = list.length;
    if (count > 4) {
        console.log('morethan4');
        $(list[0]).parents('.roomgroupdiv').removeClass('small').addClass('full');
    }
    else {
        console.log('lessthan4');
        $(list[0]).parents('.roomgroupdiv').removeClass('full').addClass('small');
    }
    $.each(list, function () {
        if (count > 4)
            $(this).css('width', (100 / count) + '%');
        else {
            $(this).css('margin-left', '0.3%');
            $(this).css('width', ((100 - (count / 3)) / count) + '%');
        }

        //$(this).css('height', $(this).parent().parent().parent().height() + 'px');
    });
    if (typeof state != "string")
        recalcRoomsHeight($(".roomgrouplistcontainer>ul>li.listroom"));
    setRoomCover(list);
}


// ===================================================================================================
// showExtras(roomname) - will display a curtain of extra options for the selected room (edit mode)
// param: roomname - name of the current rooms being edited
// return: 
// ===================================================================================================
function showExtras(room) {

    // close all curtains first
    $('.curtain .close').each(function () {
        closeCurtain($(this));
    });

    if(room.find('.curtain').length < 1)
        room.append("<div class='curtain'><span class='close'></span><div class='cont'></div></div>");
    var curt = room.find('.curtain');
    var pos = room.offset();

    room.parent().find('.extra').appendTo(curt.find('.cont')).show();

    curt.css('height', room.outerHeight(true) + 55);
    curt.css('width', room.outerWidth());
    curt.css('top', (room.outerHeight() + 50) * -1);
    if ((curt.outerWidth() + pos.left + room.outerWidth()) < $(window).outerWidth())
        curt.css('left', '102%');
    else
        curt.css('left', '-102%');

    recalcRoomHeightByExtras(room);
    curt.css('height', room.outerHeight(true) + 202);
    curt.css('top', room.outerHeight() * -1);

    curt.addClass('show');
    curt.animate({ top: -100 }, 300);
    curt.animate({ top: -198 }, 50);

    room.parent().find('.extra').css('top', (curt.height() - room.parent().find('.extra').height()));

    setExtraOptionsEvents(room.parent().find('.extra'));

    //console.log('lol');

    $('.wrap').fadeOut(300);

    setCurtainEvents(curt);
}

// ===================================================================================================
// setExtrasEvents() - attach events to the curtain itself
// param:
// return: 
// ===================================================================================================
function setCurtainEvents(curtain) {
    var close = curtain.find('.close');
    close.on('click', function () {
        closeCurtain($(this));
        $('.wrap').fadeIn(300);
    });
}

function closeCurtain(closebtn) {
    //console.log('close');
    var curtain = closebtn.parents('.curtain');
    if (curtain.hasClass('show')) {
        curtain.animate({ top: (curtain.outerHeight() * -1) - 150 }, 300);
        //$(closebtn).parents('.room.main').find('.mn.app').removeAttr('style');
        $(closebtn).parents('.room.main').find('.cover-click').fadeIn(200, function () {
            curtain.removeClass('show');
            var apps = $(closebtn).parents('.room.main').find('.mn.app');
            apps.find('.mn.catname').hide();
            var ct = apps.length;
            $.each(apps, function () {
                //console.log($(this).data('appname') + " " + $(this).data('currentHeight'));
                //$(this).outerHeight($(this).data('currentHeight'));
                taperApp($(this));
                if (!--ct) { recalcRoomsHeight($(".roomgrouplistcontainer>ul.page" + showing + ">li")); }
            });
        });
    }
}

// used to remove the extra height of the option container
function taperApp(app) {
    //$.each(apps, function () {
        var ht = $(app).outerHeight();
        var options = $(app).find('.option');
        //console.log(options);
        var optionsheight = 0;
        options.each(function () { optionsheight += $(this).outerHeight(true); });
        
        if (optionsheight < 1)
            optionsheight = 23;
        //console.log(optionsheight);
        $(app).height(optionsheight);
    //});
}

// if the room height changed, resize the cover
function resizeCover(room) {
    var ht = room.outerHeight();
    var cov = room.find('.cover-click');
    cov.outerHeight(ht);
}

// ===================================================================================================
// recalcRoomHeightsByExtras(room) - resize the curtain extras and the main room's heights to align them
// param:
// return: 
// ===================================================================================================
function recalcRoomHeightByExtras(room) {
    var extras = room.parent().find('.extra');
    var apps = extras.find('.app');
    $.each(room.find('.mn.app'), function () {
        var app = $(this);
        var roomappname = $(this).data('appname');
        var counterapp = apps.filter(function () { return $(this).data('appname') === roomappname; });

        app.data('currentHeight', $(this).outerHeight());
        //console.log($(this).data('appname') + " " + $(this).data('currentHeight'));
        if ($(this).find('.option').length < counterapp.find('.option').length)
            $(this).outerHeight($(counterapp).outerHeight(true));
        else
            $(counterapp).outerHeight($(this).outerHeight(true));
    });
    showProxyCats(room);
}
// ===================================================================================================
// showProxyCats(room) - show and resize the proxy floating categories beside a room
// param: room - the room where the proxy shows up
// return: 
// ===================================================================================================
function showProxyCats(room) {
    var cats = room.find('.mn.catname').fadeIn(400);
    
    $.each(room.find('.mn.app'), function () {
        var th = $(this).data('appname');
        var cat = $(this).find('.mn.catname');
        cat.outerHeight($(this).outerHeight());
        cat.find('span').css('margin-top', (cat.find('span').height() / 2) * -1);
    });
}

// ===================================================================================================
// recalcRoomHeightsByExtras(extra) - attach events to the curtain itself
// param: extra - the extra options container for each room
// return: 
// ===================================================================================================
function setExtraOptionsEvents(extra) {
    var apps = $(extra).find('.app');

    $.each(apps, function () {
        addEmptyMessage($(this));
    });
}

function addEmptyMessage(app) {
    if ($(app).find('.option').length < 1) {
        if ($(app).find('.empty').length < 1) {
            if($(app).hasClass('xtra'))
                $(app).append('<div class="empty">This category has been upgraded enough.</div>');
            else
                $(app).append('<div class="empty">No options selected.</div>');
            var empt = $(app).find('.empty');
            empt.css({
                'margin-left': (empt.width() / 2) * -1,
                'margin-top': (empt.height() / 2) * -1,
                'top': '50%',
                'left': '50%'
            });
        }
    }
    else {
        if ($(app).find('.empty').length > 0) { $(app).find('.empty').remove(); }
    }
}


// ===================================================================================================
// recalcRoomHeightsByExtras(extra) - attach events to the curtain itself
// param: extra - the extra options container for each room
// return: 
// ===================================================================================================
function setPageEvents() {
    var edit = $('.wrap .edit');
    var finish = $('.wrap .finish');

    edit.on('click', editPreview);
    finish.on('click', finishQuote);
}

function editPreview() {
    if ($('.preview-cover').is(':visible')) {
        $('.preview-cover').hide();
        $(this).text('Done editing');
    }
    else {
        $('.preview-cover').show();
        $(this).text('I need to make changes.');
    }
}
function finishQuote() {
}

// ==============================================================================================
// MAIN SEQUENCE
// ==============================================================================================
$(function ($) {

    $(window).resize(resizeHandler);

    $("#cleaningtype").change(function () {
        //console.log('change');
        $('.sidebutton').removeClass('close');
        //console.log($(this).val());
        callRooms($(this).val());
        slideMenu($("#serv"));
    });



    $('.garbage .tile').hide();

    //$("#cleaningtype").parent().atlasTooltip({ pos: 'bottom', contents: 'Please select an option from the selector to continue.' });

    $("#quoteSample").hide();
    $("#nextroom").hide();
    $("#finish").hide();
    setQuoteSampleEvents();
    //reposLoader();

    var space = false;
    $(document).keyup(function (evt) {
        if (evt.keyCode == 32) {
            $('input:visible:not(".ok2"):not("#end")').click();
        }
    }).keydown(function (evt) {
        if (evt.keyCode == 32) {
            //$('input:visible').click();
        }
    });


    $("#loadercontainer").hide();

    // create jquery plugin for this container
    $("#outer").atlasPageTrans({ navigationButtons: "double", backgroundColor: "#cccccc" });

    // hide all containers for the rooms (they're empty on load)
    $("#BathroomContainer").hide().addClass("pad");
    $("#BedroomContainer").hide().addClass("pad");
    $("#KitchenContainer").hide().addClass("pad");
    $("#DiningRoomContainer").hide().addClass("pad");
    $("#LivingRoomContainer").hide().addClass("pad");
    $("#OfficeContainer").hide().addClass("pad");

    // disable buttons
    $("#closeBath").attr('disabled', 'disabled').css("opacity", 0.5);
    $("#closeBed").attr('disabled', 'disabled').css("opacity", 0.5);

    // hide the main container
    $("#outer").hide();

    // when BEGIN QUOTE is clicked
    $("#startQuote").click(function () {
        $("#end").hide();
        $("#intro").fadeOut(function () {
            //$("#outer").fadeIn(200);
            //showPopup("numBathrooms");
            $("div#propertyquestions").fadeIn(200);

            // show the property questions first
            $(".propertyquestionpart").fadeIn(300, function () {
                equalizeChildren($('#bathnumslist'));
                addRadioEvents($('#bathnumslist'));
                equalizeChildren($('#bednumslist'));
                addRadioEvents($('#bednumslist'));
            });

        });
    });

    $("#gotoservicequestions").click(function () {
        $(".propertyquestionpart").fadeOut(500, function () {
            $("#end").fadeIn(200);
            $(".servicequestionpart").fadeIn(500);
            $(".servicequestionpart #serv").appendTo('body');
            /*$(".servicequestionpart .propertydesc").css({
                'position': 'fixed',
                'left': '10px',
                'top': '100px',
                'z-index': 100
            });*/
            $('#quoteSample').find('.ctypetitle').html('This is how Routine Cleaning looks like');
            slideTopBar();
            $('.prop').css('margin-top', 6);
            setPageEvents();
            setTimeout(function () { setSideMenuEvents($("#serv")); }, 50);
            setTimeout(function () { callRooms("routine-std"); }, 1000);
            //setTimeout(function () { slideMenu($("#serv"), null); }, 1300);
            $("#cleaningtype").val('routine-std');
        });
    });

    // when the preliminary ends (next button is clicked)
    $("#end").click(function () {
        $("#propertyquestions").fadeOut(400, function () {
            // populate the sidebar
            $('.sidebar').addClass("slideIn");
            appendToSidebar("Property Name", $("#name").val());
            appendToSidebar("Property Type", $("#housetype option:selected").text());
            $(".tips p .propertytypespan").text($("#housetype option:selected").text());
            appendToSidebar("Square footage", $("#area option:selected").text());
            appendToSidebar("Type of Cleaning", $("#cleaningtype option:selected").text());
            $(".tips p .cleaningtypespan").text($("#cleaningtype option:selected").text());
            appendToSidebar("Pets", $("#pets option:selected").text());

            //$('.quotetype').fadeIn();

            if ($("#cleaningtype option:selected").text() == 'Routine Cleaning')
                quotetype = 'routine';
            else
                quotetype = 'deep';
            //console.log($("#cleaningtype option:selected").text());

            $(".tips#disclaimer").show(1, function () {
                $(".tips#disclaimer").find('p:first-child').show(1, function () {
                    $(this).addClass("slideUp");
                });
            });
            // appendToSidebar("Quote Type", "Quick Quote");


            //showPopup("numBathrooms");
            //$("#outer").show();   // this is the tutorial
        });
    });


});























    // ajax for creating rooms
    function callCreateRoom(room, roomname) {
        $("#loadercontainer").show();
        $.ajax({
            type: 'POST',
            url: 'qQuote.aspx/callRoom',
            data: '{ "roomname" : "' + roomname + '"}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            async: false,
            crossDomain: true,
            success: function (msg1) {
                var roomData;   // this is an array of roomdatadto (there is usually a pair; one default)
                if (msg1.hasOwnProperty('d'))
                    roomData = JSON.parse(msg1.d);
                else
                    roomData = JSON.parse(msg1);

                $("#nextroom").fadeIn(200);

                var roomFilter = roomData[0];
                var roomDefaults = roomData[1];
                allroomdata = roomData;

                // build main room options container
                var datain = "<div class='rtqroom'>";
                datain += "<div class='roomname'>Your options for " + roomFilter.RoomName + "</div>";
                for (var i = 0; i < roomFilter.Apps.length; i++) {
                    datain += "<div class='appcontainer'>";
                    datain += "<div class='app'>"; // start of app title
                    datain += "<span class='appname'>" + roomFilter.Apps[i].AppName + "</span>";
                    // datain += "<span class='edit-options'>Edit</span>";
                    //datain += "<span class='lock-options'>Lock</span>
                    datain += "</div>"; // end of app title
                    datain += "<div class='optionscontainer' data-appname='" + roomFilter.Apps[i].AppName + "'>"; // starting for options container
                    //datain += "<div class='disableoptions'></div>"; // just a cover
                    for (var x = 0; x < roomFilter.Apps[i].Options.length; x++) {
                        var option = roomFilter.Apps[i].Options[x];
                        if (option.TimeUnit != null) {
                            datain += "<div class='option " + option.CType + "'>";
                            datain += "<span class='optionname'>" + option.OptionName + "</span>";
                            datain += "<span class='remove-option'></span>";
                            datain += "</div>";
                        }
                        else {
                            datain += "<div class='option'>";
                            datain += "<span class='optionname'>" + option.OptionName + "</span>";
                            datain += "<span class='remove-option remove-option-secondary'></span>";
                            datain += "<span class='show-extra'></span>";
                            datain += "<div class='suboptions'>";
                            datain += "<span class='suboptionsname'>Sub-options for " + option.OptionName + "</span>";
                            datain += "<span class='subclose'></span>";
                            // we will need to introduce the sub options
                            for (var y = 0; y < option.Subs.length; y++) {
                                datain += "<div class='sub'>" + option.Subs[y].OptionName + "</div>";
                            }
                            datain += "</div>"; // ending for suboptions
                            datain += "</div>"; // ending for the option
                        }
                    }
                    datain += "</div>"; // ending for options container
                    datain += "<br style='clear:both'/>";
                    datain += "</div>"; // ending for app container
                }
                datain += "</div>"; // ending for rtqroom


                // build main room options container
                var datain2 = "<div class='extra-options'>";
                datain2 += "<div class='roomname'>Extra Options available for " + roomDefaults.RoomName + "s</div>";
                datain2 += "<div id='extra'>";
                for (var i = 0; i < roomDefaults.Apps.length; i++) {
                    datain2 += "<div class='appcontainer'>";
                    datain2 += "<div class='app'>"; // start of app title
                    datain2 += "<span class='appname'>" + roomDefaults.Apps[i].AppName + "</span>";
                    //datain2 += "<span class='edit-options'>Edit</span>";
                    // datain2 += "<span class='lock-options'>Lock</span>
                    datain2 += "</div>"; // end of app title
                    datain2 += "<div class='optionscontainer' data-appname='" + roomDefaults.Apps[i].AppName + "'>"; // starting for options container
                    //datain2 += "<div class='disableoptions'></div>"; // just a cover
                    for (var x = 0; x < roomDefaults.Apps[i].Options.length; x++) {
                        var option = roomDefaults.Apps[i].Options[x];
                        if (option.TimeUnit != null) {
                            datain2 += "<div class='option " + option.CType + "'>";
                            datain2 += "<span class='optionname'>" + option.OptionName + "</span>";
                            datain2 += "<span class='remove-option'></span>";
                            datain2 += "</div>";
                        }
                        else {
                            datain2 += "<div class='option'>";
                            datain2 += "<span class='optionname'>" + option.OptionName + "</span>";
                            datain2 += "<span class='remove-option'></span>";
                            datain2 += "<span class='show-extra'></span>";
                            datain2 += "<div class='suboptions'>";
                            datain2 += "<span class='suboptionsname'>Sub-options for " + option.OptionName + "</span>";
                            datain2 += "<span class='subclose'></span>";
                            // we will need to introduce the sub options
                            for (var y = 0; y < option.Subs.length; y++) {
                                datain2 += "<div class='sub'>" + option.Subs[y].OptionName + "</div>";
                            }
                            datain2 += "</div>"; // ending for suboptions
                            datain2 += "</div>"; // ending for the option
                        }
                    }
                    datain2 += "</div>"; // ending for options container
                    datain2 += "</div>"; // ending for app container
                }
                datain2 += "</div>";
                datain2 += "</div>"; // ending for extra-options

                $("#loadercontainer").hide();
                //console.log(datain);
                $("#" + roomname + "Container").append(datain);
                $("#" + roomname + "Container").append(datain2);
                //console.log('add');
                setRTQRoomEvents(roomname);
                $("#loadercontainer").show();
            },
            error: function (error) {
                alert("Error: Retrieving data failed.");
                $("#loadercontainer").show();
            }
        });
    }

    function setRTQRoomEvents(roomname) {
        console.log('set rtq room events');
        // change the positioning of default side buttons
        $('.show-extra,.edit-options,.remove-option,.lock-options,.remove-option').each(function () {
            $(this).css('margin-top', (($(this).height() / 2) * -1) + 'px');
        });

        $('.optionscontainer').each(function () {
            if ($(this).find('.option').length < 1)
                if($(this).find('.empty').length < 1)
                    $(this).append('<div class="empty">All options are selected already.</div>');
        });

        // remove the option
        $('.remove-option').on('click', setRemoveEvent);

        // setup tooltips for showing sub options
        $('.rtqroom .option').each(function () {
            if ($(this).parents('.rtqroom').length > 0)
                $(this).stop().show();
            else
                $(this).stop().hide();

            // $(this).atlasTooltip({
            //     contents: 'Click to show more options for ' + $(this).parent().find('.optionname').text() + '.',
            //     pos: 'right'
            // });
            $(this).on('click', showextra);
            console.log('added click on option');
        });

        // hover events on side buttons
        $('.show-extra, .remove-option').on('mouseenter', showextraevents);
        $('.show-extra, .remove-option').on('mouseleave', showextraevents);
        console.log('attach hover');

        // apply hover classes on options
        //$('.rtqroom .option, .extra-options .option').on('mouseenter', removeoptionevents);
        //$('.rtqroom .option, .extra-options .option').on('mouseleave', removeoptionevents);


        //$("#" + roomname + "Container").fadeIn(300);
        //$('#disclaimer').hide();
        //if (currentRoom > 1)
        //    $(document).find('.gifarrow').remove();

        /* $('.disableoptions').each(function () {
             $(this).css({
                 'height': $(this).parent().height(),
                 'width': $(this).parent().width()
             });
             $(this).parent().find('.show-extra').hide();
         });*/

        $('.subclose').each(function () {
            $(this).click(function (e) {
                e.stopPropagation();
                $(this).parent().hide();
            });
        });

        // position sub option containers
        $('.rtqroom .suboptions, .extra-options .suboptions').each(function () {
            $(this).css('margin-top', (($(this).height() / 2) * -1) + 'px');
            $(this).hide();
        });
        //$('.app').css('height', '100px');
        //$('#extra').masonry();
        //$('#extra').masonry();
        //setMultiRoom(room, roomname);

        // this will handle all data return when returning to the main preview page
        $("#quote-edit .close-edit").click(function (e) {
            var btn = $(this);
            var prt = $(btn).parent().parent();
            e.stopPropagation();
            $(prt).fadeOut(1, function () {
                var quoteedit = $(this);
                var thisroom = $('.rtqroom');

                if (thisroom.length > 0) {
                    $('body .cover').hide();

                    $("#quote-edit .remove-option").hide();

                    // remove all events attached on edit mode
                    $('.show-extra').off('mouseenter', showextraevents);
                    $('.remove-option').off('mouseenter', showextraevents);
                    $('.show-extra').off('mouseleave', showextraevents);
                    $('.remove-option').off('mouseleave', showextraevents);
                    $('.remove-option').off('mouseenter', showextraevents);
                    $('.remove-option').off('click', setRemoveEvent);
                    //$('.rtqroom .option, .extra-options .option').off('mouseenter', removeoptionevents);
                    //$('.rtqroom .option, .extra-options .option').off('mouseleave', removeoptionevents);
                    $('.rtqroom .option').off('click', showextra);

                    $(quoteedit).find('.optionscontainer').removeAttr('style');
                    $(quoteedit).find('.appcontainer').removeAttr('style');

                    var emptyspot = $("#quoteSample .roomlist .room-preview").filter(function () {
                        return $(this).data('roomname').replace(' ', "").replace('#', "").replace(/\d/g, "").toLowerCase() === $(thisroom).data('roomname').replace(' ', "").replace('#', "").replace(/\d/g, "").replace(' ', "").toLowerCase();
                    });

                    $(quoteedit).find('.editmode').remove();
                    $(quoteedit).find('.rtqroom').addClass('room-preview-cont').removeClass('rtqroom');
                    $(quoteedit).find('.room-preview-cont-cover').show();
                    //console.log($(quoteedit).find('.room-preview-cont-cover'));
                    //$(quoteedit).find('.room-preview-cont-cover').on('click', roomPrevHandler);
                    $(quoteedit).find('.room-preview-cont').appendTo($(emptyspot));
                    $(quoteedit).find('.extra-options').hide();
                    $(quoteedit).find('.extra-options').appendTo($(emptyspot));
                    resizeApps(allroomdata);

                    // re-hide and re-show all of the rooms
                    $('#quoteSample .room-preview').each(function () {
                        var self = $(this);
                        var conts = $(self).find('.room-preview-cont');
                        if (conts.length > 1) {
                            $.each(conts, function () {
                                $(this).fadeOut(100);
                            });
                            $(conts[0]).fadeIn(100);
                        }
                    });

                    console.log('set edit false');
                    editing = false;
                }
            });
        });

        /**** EXPERIMENTAL ****
        $("#quote-edit").on('mouseleave', function (e) {
            e.stopPropagation();
            console.log('test1');
            $(this).addClass('transparent');
        });
        $("#quote-edit").on('mouseenter', function (e) {
            e.stopPropagation();
            console.log('test2');
            $(this).removeClass('transparent');
        });
        */
        // whenever a sub option is clicked, it will have 
        $('.sub').click(function (e) {
            console.log('subclick');
            e.stopPropagation();
            selectSuboption(e);
        });

        /* because chrome tends to activate the hover events even just on setup,
        we must manually hide all remove-option buttons */
        //$('.rtqroom .remove-option:visible').hide();
        //$('.extra-options .remove-option:visible').hide();
        console.log('end set rtq room events');
    }

    // for showing the buttons on the options
    function showbuttons(e) {
        $(this).find('.prev-remove').toggle();
    }

    // for clicking the option and showing the subs
    function showextra(e) { console.log('hey!'); $(this).find('.suboptions').stop().fadeToggle(100); }

    // for the show extra drop downs
    function showextraevents(event) { event.stopPropagation(); $(this).stop().toggleClass('hover'); }

    // for the x button upon hovering on the options
    function removeoptionevents(event) {
        event.stopPropagation();
        console.log('show x');
        $(this).find('.remove-option').stop().fadeToggle(3);
    }

    // for the actual removal of an option
    function setRemoveEvent(e) {
        e.stopPropagation();
        var self = $(this);
        var appcontname = self.parent().parent().data('appname');
        var loader;
        if (self.parents('.rtqroom').length > 0)
            loader = $(this).parents('#quote-edit').find('.load-right').show();
        else
            loader = $(this).parents('#quote-edit').find('.load-left').show();
        console.log(loader);

        $(this).parent().delay(200).slideUp(300, function () {
            var optcont = $(this).parent();  //optioncontainer
            var opt = $(this);
            console.log(optcont);
            if (self.parents('.rtqroom').length > 0) {
                if ($(this).find('.show-extra').length > 0) {
                    $(this).find('.show-extra').hide();
                    //$(this).find('.remove-option').removeClass('remove-option-secondary');
                }

                $(this).off('click', showextra);
                //$(this).off('mouseenter', removeoptionevents);
                //$(this).off('mouseleave', removeoptionevents);

                //$(this).find('.remove-option').hide();

                $(this).appendTo(optcont.parents('#quote-edit').find('.extra-options').find('div[data-appname="' + appcontname + '"]'));

                // remove any existing "Empty" divs
                optcont.parents('#quote-edit')
                    .find('.extra-options')
                    .find('div[data-appname="' + appcontname + '"]')
                    .find('.empty').remove();

                // if the optioncontainer becomes empty
                if (optcont.find('.option').length < 1) {
                    if (optcont.find('.empty').length < 1)
                        optcont.append('<div class="empty">No options selected.</div>');
                }
            }
            else {
                if ($(this).find('.show-extra').length > 0) {
                    $(this).find('.show-extra').show();
                    $(this).find('.remove-option').addClass('remove-option-secondary');
                }

                $(this).on('click', showextra);
                //$(this).off('mouseenter', removeoptionevents);
                //$(this).off('mouseleave', removeoptionevents);
                //$(this).find('.remove-option').hide();

                $(this).appendTo(optcont.parents('#quote-edit').find('.rtqroom').find('div[data-appname="' + appcontname + '"]'));

                // remove any existing "Empty" divs
                optcont.parents('#quote-edit')
                    .find('.rtqroom')
                    .find('div[data-appname="' + appcontname + '"]')
                    .find('.empty').remove();

                // if the optioncontainer becomes empty
                if (optcont.find('.option').length < 1) {
                    if (optcont.find('.empty').length < 1)
                        optcont.append('<div class="empty">All options are selected already.</div>');
                }
            }

            $(this).slideDown(100, function () { $(loader).hide(); });

        });
    }


    // for sub option selection
    function selectSuboption(event) {
        var sub = event.target;
        var option = $(sub).parent().parent();
        option.find('.optionname').text($(sub).text());
        $(sub).parent().find('.sub').each(function () {
            $(this).removeClass('selected');
        });
        $(sub).addClass('selected');
        $(sub).parent().fadeOut(100);
    }
    
    // set the events at the beginning
    function setQuoteSampleEvents() {
        //$("#serv").hover(function () { $(this).toggleClass('show') });
        $('#quoteSample .edit').click(function () {
            console.log($(this));
            if ($(this).parent().parent().find('.cover').is(":visible")) {
                $(this).parent().parent().find('.cover').hide();
                $(this).text('Done editing!');
            }
            else {
                $(this).parent().parent().find('.cover').show();
                $(this).text('I need to make changes.');
            }
        });
        $('#quoteSample .edit').atlasTooltip({ pos: 'bottom', contents: 'To enable/disable editing of options, click here.', sticky: true });
        $('#quoteSample .edit').atlasTooltip('hide');
        $('.garbage').atlasTooltip({ pos: 'right', contents: 'NOTE: Any of the rooms you remove will show up here<br/>so you can bring them back to the RTQ later.', sticky: true });
        $('.garbage').atlasTooltip('hide');
        //$('.cleaningtype.o1').atlasTooltip({ pos: 'bottom', contents: 'To change the type of cleaning,<br/>click on any of the above buttons.', sticky: true });
        //$('.cleaningtype.o1').atlasTooltip('hide');
    }

    function resizeApps(data) {
        // data[0] is always the first room. this will usually have the most apps
        var filter = data[0][0];
        var def = data[0][0];
        // both collections will have the same number of appliances
        var apps = filter.Apps;
        var roomamt = 0;
        var appcont = $('.appcontainer');
        //console.log(appcont.length);

        $('.room-preview-categories').parent().remove();

        var datain = "<li><div class='room-preview-categories'><div class='room-preview-cont'>";
        datain += "<div class='prev-title'>Category</div>";

        for (var x = 0; x < apps.length; x++) {
            var appname = apps[x].AppName;
            var maxheight = 0;
            datain += "<div class='appnamecont' style='transition:height 0.2s ease-in-out; height:";
            // get the biggest height for this category
            $.each(appcont, function () {
                //console.log(appname + ' = ' + $(this).data('app'));
                if (appname == $(this).data('app')) {
                    if ($(this).outerHeight() > maxheight)
                        maxheight = $(this).outerHeight();
                }
            });
            // set the heights now
            $.each(appcont, function () {
                if (appname == $(this).data('app')) {
                    $(this).outerHeight(maxheight);
                    $(this).find('.optionscontainer').outerHeight(maxheight);
                }
            });
            datain += maxheight + "px'>";
            datain += "<span class='appnamespan'>" + appname + "</span>";
            datain += "</div>";
        }
        datain += "</div></div></li>";

        $("#quoteSample").find('.roomlist').prepend(datain);
        $('#quoteSample .appnamecont .appnamespan').each(function() {
            var self = $(this);
            console.log(self.width());
            self.css({
                'margin-top': ((self.height() / 2) * -1) + 'px'
            });
        });


        $("#quoteSample .room-preview-cont-cover").each(function() { setCover($(this)); });

        //$("#quoteSample .room-preview-cont-cover").show();
        //$('#reset').atlasTooltip({ pos: 'bottom', contents: 'NOTE: Any of the rooms you remove will show up here<br/>so you can bring them back to the RTQ.', sticky: true });

        if (showtoolsflag == false) {
            setTimeout(function () {
                $('.garbage').atlasTooltip('show');
                //$('.cleaningtype.o1').atlasTooltip('show');
                $('#quoteSample .edit').atlasTooltip('show');
            },1000);
            showtoolsflag = true;
        }

        //var pos = $("#quoteSample").find('.listcontainer').position();
        //$('.room-preview-categories').css('top', pos.top + 'px');
    }

    function setRTQPreviewEvents() {

        // im thinking of detaching the container and temporarily storing them
        // into a "garbage section" on the page
        $('.prev-remove').click(function (e) {
            e.stopPropagation();
            $(this).parent().parent().slideUp(50, function () {
                var room = $(this).data('roomname');
                var totile = $('.garbage .tile.' + room.replace(' ', "").replace('#',"").replace(/\d/g,"").toLowerCase());
                $(this).appendTo($(totile));
                $(totile).fadeIn();
            });
        });
        $('.tile').click(function () {
            var room = $(this).find('.room-preview-cont');
            console.log($(room).data('roomname').replace(' ', "").replace('#', "").replace(/\d/g, "").toLowerCase());
            //var roomprev = $('#quoteSample .room-preview[data-room="' + room + '"]');
            var roomprev = $('#quoteSample .room-preview').filter(function () {
                //console.log('match? ' + $(this).data('roomname').replace(' ', "").replace('#', "").replace(/\d/g, "").toLowerCase());
                //console.log('match2? ' + $(room).data('roomname').replace(' ', "").replace('#', "").replace(/\d/g, "").toLowerCase());
                return $(this).data('roomname').replace(' ', "").replace('#', "").replace(/\d/g, "").toLowerCase() === $(room).data('roomname').replace(' ', "").replace('#', "").replace(' ', "").replace(/\d/g, "").toLowerCase();
            });
            console.log('roomprev is');
            console.log(roomprev);
            $(room).css('z-index', 0);
            $(roomprev).css('z-index', 0);
            $(roomprev).prepend($(room));
            $(room).slideDown(100);
            $(this).hide();
        });

        // this will attach the current room into an editable form
        $('.room-preview-cont-cover').on('click', roomPrevHandler);
    }

    function setCover(element) {
        /*var par = $(element).parent();
        var pos = par.position();
        var ht = par.outerHeight();
        var wt = par.outerWidth();
        $(element).css('height', ht + 'px');
        $(element).css('width', wt + 'px');
        $(element).css('top', pos.top + 'px');
        $(element).css('left', pos.left + 'px');
        $(element).show();*/
    }


    // click handler for all room-previews
    function roomPrevHandler(event) {
        console.log('ev!');
        event.stopPropagation();
        var self = $(this).parent();
        var cov = $(this);

        var ext = self.parent().find('.extra-options').filter(function () {
            return $(this).data('roomname') === self.data('roomname');
        });
        //$(cov).off('click', roomPrevHandler);

        //$(this).find('.appcontainer').removeAttr('style');
        $(self).fadeOut(200, function () {
            self.parent().parent().css('z-index', 0);
            console.log('fadeout cont');
            $(self).removeClass('room-preview-cont');
            $(self).addClass('rtqroom');
            console.log('added!');
            $('#quote-edit .cont').prepend($(ext));
            $('#quote-edit .cont').prepend($(self));
            $(ext).show();
            $(self).show();
            var qe = $("#quote-edit");
            // after attaching the room, set the modal editable section
            $("#quote-edit").css('margin-top', (($(qe).outerHeight() / 2) * -1) + 'px').fadeIn(200);
            $("body .cover").show();

            // show all remove-option buttons
            $("#quote-edit .remove-option").show();

            // reset the size and positioning of the appliance names
            $.each($("#quote-edit .appcontainer"), function () {
                var ot = $(this);
                $(ot).find('.optionscontainer').removeAttr('style');
                $(ot).removeAttr('style');
                //$(ot).css("min-height", $(ot).find('.optionscontainer').outerHeight() + 'px');
                //$(ot).find('.app').css('height', '100%');
            });
            if ($("#quote-edit .editmode").length < 1)
                $("#quote-edit .cont").append("<span class='clearfix editmode'></span>");
            setRTQRoomEvents(null);
            $("#quote-edit .room-preview-cont-cover").hide();
            editing = true;
        });
    }



    // CALL ALL ROOMS

    function callCreateAllRooms2(cleaningtype) {
        console.log('in');
        $("#quoteSample .edit").text('I need to make changes.');
        $("#quoteSample .cover").show();
        $("#loadercontainer").show();
        $.ajax({
            type: 'POST',
            url: 'qQuote.aspx/callAllRooms',
            data: '{ "cleaningtype" : "' + cleaningtype + '"}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            async: false,
            crossDomain: true,
            success: function (msg1) {
                console.log('in');
                var roomData;   // this is an array of roomdatadto (there is usually a pair; one default)
                if (msg1.hasOwnProperty('d'))
                    roomData = JSON.parse(msg1.d);
                else
                    roomData = JSON.parse(msg1);
                //$("#nextroom").fadeIn(200);

                allroomdata = roomData;
                
                var finaldatain = "";
                for (var i = 0; i < roomData.length; i++)
                {
                    // there will be 2 collections in each element in the array
                    var filter = roomData[i][0];
                    var def = roomData[i][1];
                    // both collections will have the same number of appliances
                    var apps = filter.Apps;
                    var apps2 = def.Apps;
                    //console.log(apps);
                    //console.log(apps2);
                    var roomamt = 0;
                    var datain = "<li class='";
                    
                    if (filter.RoomName == "Bathroom")
                        roomamt = bathcount;
                    else if (filter.RoomName == "Bedroom")
                        roomamt = bedcount;
                    else
                        roomamt = 1;

                    if ((filter.RoomName == "Bathroom" || filter.RoomName == "Bedroom") && roomamt < 1)
                        datain += 'emptyroom';

                    datain += "'><div class='room-preview' data-roomname='" + filter.RoomName + "'>";

                    var strlen = 99;
                    for (var u = 0; u < roomamt; u++) {
                        var u1 = "";
                        if (roomamt > 1) u1 = " # " + (u + 1);

                        datain += "<div class='room-preview-cont' data-roomname='" + filter.RoomName + u1 + "'>";
                        //datain += "<div class='room-preview-cont-cover' data-roomname='" + filter.RoomName + u1 + "'></div>";
                        console.log(filter.RoomName + u1);
                        datain += "<div class='prev-title'>" + filter.RoomName;
                        datain += u1;

                        // add the remove icon here
                        datain += "<span class='prev-remove'></span>";
                        datain += "</div>";

                        // distribute the information now
                        for (var j = 0; j < apps.length; j++) {
                            datain += "<div class='appcontainer' data-app='" + apps[j].AppName + "'>";
                            datain += "<div class='app'>"; // start of app title
                            datain += "<span class='appname'>" + apps[j].AppName + "</span>";
                            datain += "</div>"; // end of app title
                            datain += "<div class='optionscontainer' data-appname='" + apps[j].AppName + "'>"; // starting for options container
                            for (var k = 0; k < apps[j].Options.length; k++) {
                                var option = apps[j].Options[k];
                                if (option.TimeUnit != null) {
                                    var name = option.OptionName.substring(0, strlen);
                                    datain += "<div class='option " + option.CType + "'>";
                                    datain += "<span class='optionname'>" + name + "</span>";
                                    datain += "<span class='prev-remove'></span>";
                                    datain += "</div>";
                                }
                                else {
                                    var flag = true;
                                    datain += "<div class='option hassub' data-defaultname='" + option.OptionName + "'>";
                                    for (var y = 0; y < option.Subs.length; y++) {
                                        if (option.Subs[y].CType.indexOf(cleaningtype) > -1 && flag == true) {
                                            //datain += "<span class='optionname'>" + option.OptionName + "</span>";
                                            var name = option.Subs[y].OptionName.substring(0, strlen);
                                            datain += "<span class='optionname'>" + name + "</span>";
                                            flag = false;
                                        }
                                    }
                                    datain += "<span class='prev-remove'></span>";
                                    //datain += "<span class='show-extra'></span>";
                                    datain += "<div class='suboptions'>";
                                    datain += "<span class='suboptionsname'>Sub-options for " + option.OptionName + "</span>";
                                    datain += "<span class='subclose'></span>";
                                    // we will need to introduce the sub options
                                    for (var y = 0; y < option.Subs.length; y++) {
                                        var name = option.Subs[y].OptionName.substring(0, strlen);
                                        datain += "<div class='sub' data-ctype='" + option.Subs[y].CType + "'>" + name + "</div>";
                                    }
                                    datain += "</div>"; // ending for suboptions
                                    datain += "</div>"; // ending for the option
                                        
                                }
                            }
                            datain += "</div>"; // ending for options container
                            datain += "<span class='clearfix'></span>";
                            datain += "</div>"; // ending for app container
                        }
                        datain += "</div>"; // ending for room-preview-container



                        // add the extra options here
                        datain += "<div class='extra-options' data-roomname='" + def.RoomName + u1 + "'>";
                        datain += "<div class='roomname'>Extra Options available for " + def.RoomName + "s</div>";
                        //datain += "<div id='extra'>";
                        for (var j = 0; j < apps2.length; j++) {
                            datain += "<div class='appcontainer' data-app='" + apps2[j].AppName + "'>";
                            datain += "<div class='app'>"; // start of app title
                            datain += "<span class='appname'>" + apps2[j].AppName + "</span>";
                            datain += "</div>"; // end of app title
                            datain += "<div class='optionscontainer' data-appname='" + apps2[j].AppName + "'>"; // starting for options container
                            for (var k = 0; k < apps2[j].Options.length; k++) {
                                var option = apps2[j].Options[k];
                                if (option.TimeUnit != null) {
                                    //if (option.hasOwnProperty('CType') && option.CType != null) {
                                    //if (option.CType.indexOf(cleaningtype) > -1) {
                                    datain += "<div class='option " + option.CType + "'>";
                                    datain += "<span class='optionname'>" + option.OptionName + "</span>";
                                    datain += "<span class='prev-remove'></span>";
                                    datain += "</div>";
                                    //}
                                    //}
                                }
                                else {
                                    //if (option.hasOwnProperty('CType') && option.CType != null) {
                                    //if (option.CType.indexOf(cleaningtype) > -1) {
                                    datain += "<div class='option hassub' data-defaultname='" + option.OptionName + "'>";
                                    //for (var y = 0; y < option.Subs.length; y++) {
                                    //if(option.Subs[y].CType.indexOf(cleaningtype) > -1)
                                    //datain += "<span class='optionname'>" + option.OptionName + "</span>";
                                    datain += "<span class='optionname'>" + option.OptionName + "</span>";
                                    //}
                                    datain += "<span class='prev-remove'></span>";
                                    //datain += "<span class='show-extra'></span>";
                                    datain += "<div class='suboptions'>";
                                    datain += "<span class='suboptionsname'>Sub-options for " + option.OptionName + "</span>";
                                    datain += "<span class='subclose'></span>";
                                    // we will need to introduce the sub options
                                    for (var y = 0; y < option.Subs.length; y++) {
                                        datain += "<div class='sub' data-ctype='" + option.Subs[y].CType + "'>" + option.Subs[y].OptionName + "</div>";
                                    }
                                    datain += "</div>"; // ending for suboptions
                                    datain += "</div>"; // ending for the option
                                    // }
                                    //}
                                }
                            }
                            datain += "</div>"; // ending for options container
                            datain += "<span class='clearfix'></span>";
                            datain += "</div>"; // ending for app container
                        }
                        //datain += "</div>"; // ending for extra
                        datain += "</div>"; // ending extraoptions container
                        //datain += "<span class='clearfix'></span>"; // clearfix both the rtqroom & extra-options
                    }
                    datain += "</div>"; // ending for room preview
                    datain += "</li>";
                    finaldatain += datain;
                }


                //$(".servicequestionpart .cleaningtypediv").fadeOut(1, function () {
                $(".servicequestionpart .propertydesc").fadeIn(1, function () {
                    $("#loadercontainer").hide();
                    $(".servicequestionpart").find('.prop').slideUp(200);
                    slideTopBar();
                    $('#propertyquestions').css({
                        'margin-top':'0px',
                        'width':'98%'    
                    });
                    /* $('.ulserviceinfo .propertydiv').css({
                        'padding': '3px',
                        'min-height': '45px',
                        'width': '280px',
                        'margin':'auto'
                    });
                    $('.servicequestionpart .propertydesc').animate({ left: -290 }, 500, function () {
                        $('.servicequestionpart .propertydesc').append('<div class="sidebutton">Edit</div>');
                        $('.sidebutton').fadeIn(300);
                    });*/
                    
                    $('#quoteSample').removeAttr('style');
                    $(".roomlist").html(finaldatain);
                    $('.option .prev-remove').hide();
                    $("#quoteSample li").hide();

                    var d = 0;
                    var l = 155;
                    var totalwidth = 0;
                    var count = $('#quoteSample li').length;
                    //console.log("count " + count);
                    $('#quoteSample li').each(function () {
                        var self = $(this);
                        $(self).find('.sub').each(function () {
                            if($(this).data('ctype').indexOf(cleaningtype) > -1)
                                selectSuboption($(this));
                        });
                        $(self).delay(d).fadeIn(200, function () {
                            $(this).find('.room-preview').on("mouseenter", function () {
                                var conts = $(this).find('.room-preview-cont');
                                var cova = $(this).find('.room-preview-cont-cover');
                                //console.log(conts);
                                if (conts.length > 1) {
                                    var pos = $(this).parent().position();
                                    $(this).parent().css({
                                        "position": "absolute"
                                    });
                                    //$(this).css("background-color",'#CCC');
                                    var del = 0;
                                    $.each(conts, function () {
                                        var cov = $(this).find('.room-preview-cont-cover');
                                        var self = $(this);
                                        self.delay(del).fadeIn(200, function () {
                                            setCover(cov);
                                        });
                                        del += 100;
                                    });
                                    $(conts[0]).fadeIn(1);
                                }
                                setCover(cova);
                                $(this).parent().css({"z-index": '50'});
                            });
                            $(this).find('.room-preview').on("mouseleave", function () {
                                var conts = $(this).find('.room-preview-cont');
                                $(conts).stop();
                                if (conts.length > 1) {
                                    $(this).parent().css('background', 'none');
                                    $(this).parent().css('box-shadow', 'none');
                                    //$(this).removeAttr('style');
                                    $.each(conts, function () {
                                        $(this).hide();
                                    });
                                    $(conts[0]).show();
                                }
                                $(this).parent().css({ "z-index": '0' });
                            });
                            if (!--count) {
                                resizeApps(roomData);
                                repos();
                                resetLayout();
                            }
                            totalwidth += $(this).outerWidth();
                            //console.log(totalwidth);
                            
                        });
                        var conts = $(self).find('.room-preview-cont');
                        if (conts.length > 1) {
                            $.each(conts, function () {
                                $(this).fadeOut(100);
                            });
                            $(conts[0]).fadeIn(100);
                        }

                        if($(self).find('.room-preview').find('.room-preview-cont').length > 0)
                            d += 100;
                        
                    });
                    //console.log('total width ' + totalwidth);

                    var rps = $('#quoteSample li');
                    $('#quoteSample li').each(function () {
                        //console.log($(this).width());
                        if (!$(this).find('.room-preview').is(":empty")) {
                            $(this).css({
                                'left': l + 'px'
                            });
                            l += 204;
                        }
                    });

                    function repos() {
                        var parwt = $("#quoteSample").find('.listcontainer').outerWidth();
                        var ulwt = getTotalWidth($('#quoteSample li .room-preview:not(.emptyroom), li .room-preview-categories'));
                        var ct = $('#quoteSample li .room-preview-cont .room-preview:not(:empty)').length;
                        $('#quoteSample .roomlist').css('width', (ulwt+(40)) + 'px');
                        var diff = parwt - ulwt;
                        $('#quoteSample li').each(function () {
                            
                        });
                    }
                    $(".suboptions").hide();
                    $('.extra-options').hide();
                    /*$('.room-preview .extra-options .option').each(function () {
                        var self = $(this);
                        var optionname = self.find('.optionname').text(); // the name of the option
                        var countrprt = self.parents('.room-preview').find('.room-preview-cont .option').filter(function () {
                            return $(this).find('.optionname').text() === optionname;
                        });
                        console.log(countrprt);
                        if (countrprt.length > 0 || countrprt != null)
                            self.remove();
                    });*/
                    $('.garbage').show(1, function () {
                        setRTQPreviewEvents();
                        reposLoader();
                    });

                });
                
            },
            error: function (error) {
                alert("Error: Retrieving data failed.");
            }
        });
    }

    function resetLayout() {
        var max = findMaxHeight($("#quoteSample .roomlist li"));
        $("#quoteSample .roomlist").css('height', (max + 10) + 'px');

        $("#quoteSample").animate({ 'margin-left': 0 }, 230, function () {
            var ht = $('.roomlist').outerHeight();
            var wt = $('.roomlist').outerWidth();
            var pos = $('.roomlist').position();
            $("#quoteSample").fadeIn(500, function () {
                $("#quoteSample .cover").show().css('width', ($(this).width()) + 'px');
                $("#quoteSample .cover").css({
                    'height': ht + 5,
                    'width': wt,
                    'top': pos.top + 'px',
                    'left': pos.left + 'px'
                });
            });
        });
        //$("#serv").animate({ 'margin-left': -300, 'margin-top': -110 }, 300, function () { $(this).find('.sidebutton').show(); });

        $(".option").on('mouseenter', showbuttons);
        $(".option").on('mouseleave', showbuttons);

        $("#serv .sidebutton").click(function () {
            $(this).parents('#serv').animate({ 'margin-left': 0, 'margin-top': 0 }, 100);
            $(this).hide();
        });
    }

    function reposLoader() {
        var ht = 64;
        var wt = 64;
        $("#loadercontainer").css({
            'margin-top': ((ht / 2) * -1) + 'px',
            'margin-left': ((wt / 2) * -1) + 'px',
            'top': '50%',
            'left': '50%'
        });
    }

