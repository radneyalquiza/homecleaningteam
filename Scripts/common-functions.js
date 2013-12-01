// ====================================================
// FUNCTIONS THAT ARE REUSABLE ACROSS ANY APPLICATION
// ====================================================

// FINDMAXHEIGHT()
// get the tallest element from an array of elements
function findMaxHeight(elements) {
    var max = 0;
    $.each($(elements), function () {
        if ($(this).outerHeight() > max)
            max = $(this).outerHeight();
    });
    return max;
}

// GETTOTALWIDTH()
// get the total dimensions of all matched elements
function getTotalWidth(elements) {
    var total = 0;
    $.each($(elements), function () {
        //console.log($(this).outerWidth());
        total += $(this).outerWidth();
    });
    return total;
}

// EQUALIZECHILDREN(CONTAINER)
// equalize the width of all children relative to their parent
function equalizeChildren(object) {
    var list = $(object).children();
    var parentwt = $(object).width();
    $.each(list, function () {
        $(this).css('width', ((parentwt / list.length) - 5) + 'px');
    });
}

function addRadioEvents(object) {
    $(object).children().each(function () {
        $(this).click(function () {
            $(this).parent().children().each(function () { deselectRadio($(this)); });
            selectRadio($(this));
        });
    });
}

function deselectRadio(object) {
    $(object).removeClass('radioselected');
}

// SET THE SELECTED OBJECT
function selectRadio(object) {
    $(object).addClass('radioselected');
    var list = $(object).parent();
    if (list.attr('id') == "bathnumslist") {
        if (!isNaN($(object).text()))
            bathcount = parseInt($(object).text());
        else bathcount = 0;
    }
    if (list.attr('id') == "bednumslist") {
        if (!isNaN($(object).text()))
            bedcount = parseInt($(object).text());
        else bedcount = 0;
    }
}




Array.prototype.contains = function (v) {
    for (var i = 0; i < this.length; i++) {
        if (this[i] === v) return true;
    }
    return false;
};

Array.prototype.unique = function () {
    var arr = [];
    for (var i = 0; i < this.length; i++) {
        if (!arr.contains(this[i])) {
            arr.push(this[i]);
        }
    }
    return arr;
}