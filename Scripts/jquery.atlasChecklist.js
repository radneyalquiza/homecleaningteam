// ========================================================================================== //
//  Atlas Checklist (v0.5)
//  by Radney Aaron Alquiza
//  Sept 15, 2013
// ========================================================================================== //

// this checklist plugin will be applied to a element that contains
// a set of list items, regardless of which element these are

// you can also have multiple list holders in 1 container.

// it also can simulate radio buttons as long as your container has a isRadioList css class

(function ($) {

    // globally accessible variables (contain DOM)
    // only for AtlasChecklist though

    // default settings
    var settings = {
        containerWidth: '300',
    };

    // method selector
    $.fn.atlasChecklist = function (options_or_method, otherparams) {

        var domelement = null;

        // make sure the plugin has been initialized
        if (methods != null) {
            // if the parameter passed is nothing or a javascript object
            if (otherparams == null && options_or_method == null || (typeof options_or_method === 'object' && options_or_method != null)) {
                if (domelement == null) {
                    settings = $.extend(settings, options_or_method);
                    domelement = methods['initialize'](this, options_or_method);
                }
                return domelement;
            }
                // if the parameter passed is a string for a method
            else if (typeof options_or_method == "string" && otherparams == null) {
                return methods[options_or_method](this);
            }
            else if (typeof options_or_method == "string" && otherparams != null) {
                domelement = methods[options_or_method](this, otherparams);
                return domelement;
            }
        }

    };


    // =====================================================
    // INTERNAL FUNCTIONS
    // =====================================================

    // add any data to the object (preferably a list item)
    function addData(object, dataname, data) {
        if (object != null && dataname != null && data != null)
            $(object).data(dataname, data);
        return object;
    }
    /*
    function elementInViewport2(el) {
        var top = el.offsetTop;
        var left = el.offsetLeft;
        var width = el.offsetWidth;
        var height = el.offsetHeight;

        while (el.offsetParent) {
            el = el.offsetParent;
            top += el.offsetTop;
            left += el.offsetLeft;
        }

        return (
          top < (window.pageYOffset + window.innerHeight) &&
          left < (window.pageXOffset + window.innerWidth) &&
          (top + height) > window.pageYOffset &&
          (left + width) > window.pageXOffset
        );
    }
    */

    // make a list
    function makeContainer(object) {
        var holder = $(object);
        var list = new Array();
        var listData = new Array();

        if (!holder.hasClass('atlasChecklistContainer')) {
            holder.addClass("atlasChecklistContainer").css('width', settings.containerWidth + 'px');

            // if the passed element has children
            if (holder.children().length > 0) {
                holder.addClass('listholder');
                var listA = holder.children();
                $.each(listA, function () {
                    var ob = $(this);
                    // if this list item is a header
                    if ($(this).data('header') != "" && $(this).data('header') != null) {
                        var tag = $(this).prop('tagName');
                        holder.prepend("<" + tag + " class='header'>" + $(this).data('header') + "</" + tag + ">");
                        $(this).hide();
                    }
                    // if this list item has another nested list
                    if ($(this).children().length > 1) {
                        // make each child that has more childern another checklist
                        $(this).children().each(function () {
                            if (!$(this).is('span')) {
                                makeContainer($(this).addClass('sub-right'));
                            }
                        });
                        // make this item a normal list (but with hidden sub option) 
                        $(this).addClass('list');
                        $(this).addClass('listWithSub');
                        // make this item's click event a slidedown
                        $(this).click(function (e) {
                            e.stopPropagation();
                            var listitemsub = $(this);
                            if (!listitemsub.children('.sub-right').is(':visible')) {
                                var subcont = listitemsub.children('.sub-right');
                                /* spec block ---*/
                                /* this section is only applicable (for now) on the RealTimeQuote web app */
                                /* it will hide the currently selected radio button from the sublist tooltip */
                                $.each(subcont.children(), function () {
                                    $(this).removeClass('hidden-sub-list');
                                });

                                $(this).find('.checked').addClass('hidden-sub-list');
                                /* end spec block  ---*/

                                $(this).children('.sub-right').slideDown(200, function () {
                                    //$(this).parent().parent().parent().addClass('cancelhide');
                                    //$(this).parent().parent().parent().parent().addClass('cancelhide');
                                    //$(this).parent().parent().parent().parent().parent().addClass('cancelhide');
                                    //$(this).find('.checked').hide();

                                    

                                    /*
                                    var width = $(this).parent().parent().outerWidth();
                                    $(this).css('width', width - 20 + 'px');

                                    if (!$(this).visible(true)) {
                                        console.log('oops');
                                        $(this).css('margin-top', '-50px');
                                    }
                                    /*
                                    if (!$(this).is(":within-viewport-right")) {
                                        console.log(width);
                                        $(this).css('width', width - 20 + 'px');
                                    }
                                    if (!$(this).is(":within-viewport")) {
                                        $(this).css('margin-top', '-50px');
                                    }*/
                                });
                            }
                            else {
                                $(this).children('.sub-right').slideUp(100);
                                $(this).parent().parent().removeClass('cancelhide');
                                $(this).parent().parent().parent().removeClass('cancelhide');
                                $(this).parent().parent().parent().parent().removeClass('cancelhide');
                            }
                                //var width = $(this).parent().width();
                                //$(this).css('width', '90px');

                                //$(this).bind('enterviewport', handler).bind('leaveviewport', handler).bullseye();

                                //function handler(e) {
                                //    console.log(($(this).prop('tagName') + ': ' + e.type));
                                //}

                                /*if (!elementInViewport2($(this))) {
                                    console.log($(this));
                                    $(this).delay(250).css('margin-left', '-10px');
                                    $(this).delay(250).css('margin-top', '-40px');
                                    $(this).addClass('hidetail');
                                    //if (!elementInViewport2($(this))) {
                                    //   $(this).css('margin-top', '-50px !important');
                                    //}
                                }*/


                            
                            $(this).toggleClass('showSubs');
                        });
                        // for closing the slid down container when clicked outside
                        $(document).click(function (e) {
                            if (e.target != ob) {
                                ob.children('.sub-right').slideUp(200);
                                ob.removeClass('showSubs');
                                ob.parent().parent().removeClass('cancelhide');
                                ob.parent().parent().parent().removeClass('cancelhide');
                                ob.parent().parent().parent().parent().removeClass('cancelhide');

                            }
                        });
                        list.push($(this));

                    }
                    else {  // if there is no nested list
                        $(this).addClass('list');

                        var parent = $(this).parent().parent();
                        parent.data('listWithSubOrigText', parent.children('span').text());

                        $(this).click(function (e) {
                            //e.stopPropagation();
                            if ($(this).parent().hasClass('isRadioList'))
                                $(this).parent().find('.list').removeClass('checked');
                            $(this).toggleClass('checked');
                            $(this).parent().removeClass('showSubs');

                            // if this list item is a child of a list item (nested)
                            if (parent.hasClass('listWithSub')) {

                                if ($(this).hasClass('checked'))
                                    parent.addClass('checkedWithSub');
                                else
                                    parent.removeClass('checkedWithSub');

                                // if this is a default, no-value list item
                                if ($.isEmptyObject($(this).data()) || $(this).data() == null) {
                                    parent.removeClass('checkedWithSub');
                                    parent.children('span').text(parent.data('listWithSubOrigText') + " - " + $(this).find('span').text());
                                    $(this).removeClass('checked');
                                }
                                else
                                    parent.children('span').text($(this).find('span').text());

                                var texts = parent.children('span');
                                $.each(texts, function () {
                                    if ($(this).text().length > 40)
                                        $(this).css('font-size', '12.5px');
                                    else
                                        $(this).css('font-size', '14px');
                                });
                            }
                        });
                        list.push($(this)); // add this item to the list of items in the checklist
                    }
                });
            }
        }
        return holder;
    }

    var methods = {
        // =============================================================================
        // INITIALIZE - attach the plugin, attach events, attach css
        // =============================================================================
        initialize: function (object, options) {

            return object.each(function () {
                var count = 0; // counter for list items

                // this is the element itself
                var container = $(this);
                //container.addClass("atlasChecklistContainer");

                container = makeContainer(container);

                // bind the jquery reference to the element (the div or any container)
                $(this).data('data', container);
            });
        },

        // =============================================================================
        // DESTROY - remove the plugin from the container
        // Parameters: object - the DOM element
        // Returns   : object - the DOM element
        // =============================================================================
        destroy: function (object) {
            //if (initAlready == true) {
            object.data('data').removeClass('atlasChecklistContainer');
            object.data('data').removeClass('listholder');
            object.data('data').find('*').removeClass('listholder');
            object.data('data').find('*').removeClass('atlasChecklistContainer');
            object.data('data').find('*').removeClass('list');
            object.data('data').find('*').removeClass('sub-right');
            object.data('data').find('*').removeClass('listholder');
            object.data('data').find('*').removeClass('listWithSub');
            object.data('data').find('*').removeClass('checked');
            object.data('data').find('*').unbind('click');
            object.data('data').find('*:hidden').show();
            object.data('data').find('.header').remove();
            object = null;
            return object;
            //}
            // else
            //  return null;
        },

        // ================================================================================
        // SETDATANAME - set the data identifier for all list items to be able to get data
        // Parameters: object - the DOM element
        //             dataname - the data identifier
        // Returns   : none
        // ================================================================================
        setDataName: function (object, dataobject) {
            $(object).data(dataobject['dataName'], dataobject['dataIdentifier']);
        },

        // ================================================================================
        // SETDEFAULTDATANAME - set the data identifier for all list items to be able to get data
        // Parameters: object - the DOM element
        //             dataname - the data identifier
        // Returns   : none
        // ================================================================================
        setDefaultDataName: function (object, dataname) {
            $(object).data('defaultDataName', dataname);
        },

        // ================================================================================
        // GETCHECKEDDATA - get data of all checked (uses defaultDataName)
        // Parameters: object - the DOM element
        // Returns   : JS array of data values
        // ================================================================================
        getCheckedData: function (object) {
            var checked = object.find('.checked');
            var checkedwithsubs = object.find('.sub-right');
            var checkedval = new Array();
            $.each(checked, function () {
                checkedval.push($(this).data('defaultDataName'));
            });
            /*$.each(checkedwithsubs, function () {
                var checkedradio = $(this).find('.checked');
                checkedval.push(checkedradio.data('defaultDataName'));
                
            });*/
            return checkedval;
        },
        // same as above but returns the list item itself, not just value
        getCheckedItems: function (object) {
            var checked = object.find('.checked');
            var checkedwithsubs = object.find('.sub-right');
            var checkedval = new Array();
            $.each(checked, function () {
                checkedval.push($(this));
            });
            /*$.each(checkedwithsubs, function () {
                var checkedradio = $(this).find('.checked');
                checkedval.push(checkedradio.data('defaultDataName'));
                
            });*/
            return checkedval;
        },


        // ================================================================================
        // GETCHECKEDDATABYNAME - get data of all checked (uses passed dataname)
        // Parameters: object - the DOM element
        //             dataname - the .data() identifier
        // Returns   : JS array of data values
        // ================================================================================
        getCheckedDataByName: function (object, dataname) {
            var checked = object.find('.checked');
            var checkedwithsubs = object.find('.sub-right');

            var checkedval = new Array();
            $.each(checked, function () {
                checkedval.push($(this).data(dataname));
            });
            /*$.each(checkedwithsubs, function () {
                console.log($(this));
                var checkedradio = $(this).find('.checked');
                console.log(checkedradio);
                checkedval.push(checkedradio.data(dataname));
            });*/
            return checkedval;
        },

        // ================================================================================
        // GETCHECKEDTEXT - get text of all checked
        // Parameters: object - the DOM element
        // Returns   : JS array
        // ================================================================================
        getCheckedText: function (object) {
            var checked = object.find('.checked');
            var checkedtxt = new Array();

            $.each(checked, function () {
                checkedtxt.push($(this).children('span').text());
            });
            return checkedtxt;
        },

        // ================================================================================
        // ADDDATAVALUE - add a data value to the list element
        // ================================================================================
        addDataValue: function (object) {
            return addData(object['object'], object['dataname'], object['data']);
        },

        // ================================================================================
        // CHECKALL - check all in the list
        // ================================================================================
        checkAll: function () {
            $.each(list, function () {
                if (!$(this).hasClass('header')) {
                    if (!$(this).hasClass('checked'))
                        $(this).addClass('checked');
                }
            });
        },

        // ================================================================================
        // UNCHECKALL - uncheck all in the list
        // ================================================================================
        uncheckAll: function () {
            $.each(list, function () {
                if (!$(this).hasClass('header')) {
                    if ($(this).hasClass('checked'))
                        $(this).removeClass('checked');
                }
            });
        },

        // ================================================================================
        // TOGGLEITEM - check/uncheck a specific item (receive data and dataname)
        // ================================================================================
        toggleItem: function (object) {
            $.each(list, function () {
                if ($(this).data(object['dataname']) == object['data']) {
                    $(this).toggleClass('checked');
                }
            });
        },

        // ================================================================================
        // CHECKBYCLASS - check/uncheck a specific item (receive a class name)
        // ================================================================================
        checkbyClass: function (object, classname) {
            var classitems = $(object).find("." + classname);
            $.each(classitems, function () {
                //if (!$(this).parent().hasClass('isRadioList')) {
                //    console.log($(this).parent().children('.checked'));
                //    $(this).parent().children().removeClass('checked');
                //}
                $(this).click();
            });
        },


       /* colorCode: function (object) {
            console.log(object);
            console.log($(object).find('.routine'));
            $(object).find('.routine').css('background-color', '#CCCCCC');
        },*/

    }

}(jQuery));