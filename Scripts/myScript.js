///////////////////////////////////////////////////////////////////////////
// CUSTOM REUSABLE JQUERY SNIPPETS
// by Radney Aaron Alquiza
///////////////////////////////////////////////////////////////////////////

// these functions can be used wherever in the application


/* ========================================================================================================== */
// UTILITY FUNCTIONS
/* ========================================================================================================== */

// show a notification then refresh page
function notify(message, stat) {


    if (stat == "success") {
        var n = noty({
            text: message,
            type: 'information',
            dismissQueue: true,
            layout: 'topRight',
            theme: 'defaultTheme',
            timeout: 2500,
            animation: {
                open: { height: 'toggle' },
                close: { height: 'toggle' },
                speed: 350 // opening & closing animation speed
            },
            callback: {
                afterClose: function () { window.location.reload(true); }
            },
            /*
            buttons: [
              {
                  addClass: 'btn btn-primary', text: 'Ok', onClick: function ($noty) {
                      $noty.close();
                      noty({ dismissQueue: true, force: true, layout: layout, theme: 'defaultTheme', text: 'You clicked "Ok" button', type: 'success' });
                  }
              },
              {
                  addClass: 'btn btn-danger', text: 'Cancel', onClick: function ($noty) {
                      $noty.close();
                      noty({ dismissQueue: true, force: true, layout: layout, theme: 'defaultTheme', text: 'You clicked "Cancel" button', type: 'error' });
                  }
              }
            ]*/
        });
    }
    else {
        var n = noty({
            text: message,
            type: 'error',
            dismissQueue: true,
            layout: 'topRight',
            theme: 'defaultTheme',
            timeout: 2500,
            animation: {
                open: { height: 'toggle' },
                close: { height: 'toggle' },
                speed: 350 // opening & closing animation speed
            },
        });
    }
}


// close any Add form (a slideIn popup for adding any object to db)
function bClose(page) {
    page.bPopup().close();
}

// create an interactive table of data of whatever db table you want
function makeTable(data) {
    $("#tableData").append(data);
}

function makeRooms(data) {
    $('#showRooms').append(data);
}

// display an Add form of any object
function showAdd(e) {
    e.preventDefault();

    // Triggering bPopup when click event is fired
    $('#addPage').bPopup({
        closeClass: 'closeAdd',
        modalClose: false,
        opacity: 0.6,
        positionStyle: 'fixed', //'fixed' or 'absolute'
        modalColor: '#337abe',
        transition: 'slideIn',
        appendTo: 'form'
    });
}

// display an Add form of any object
function showPop(popid) {
    //e.preventDefault();

    // Triggering bPopup when click event is fired
    $(popid).bPopup({
        closeClass: 'closeAdd',
        modalClose: false,
        opacity: 0.6,
        positionStyle: 'fixed', //'fixed' or 'absolute'
        modalColor: '#337abe',
        transition: 'slideIn',
        appendTo: 'form'
    });
}
function bClosePop(popId) {
    parent.$(popId).bPopup().close();
}

// display a popup
function showAdd(e) {
    e.preventDefault();

    // Triggering bPopup when click event is fired
    $('#addPage').bPopup({
        closeClass: 'closeAdd',
        modalClose: false,
        opacity: 0.6,
        positionStyle: 'fixed', //'fixed' or 'absolute'
        modalColor: '#337abe',
        transition: 'slideIn',
        appendTo: 'form'
    });
}


function makeDDSlick(sel, jsondata, seltext) {

    sel.ddslick({
        data: jsondata,
        width: 400,
        height: 200,
        selectText: seltext
    });


}



/* ========================================================================================================== */
// SHORTCUTS
/* ========================================================================================================== */

// SHOW ADD FORM
var down = [];
$(document).keydown(function (e) {
    down[e.keyCode] = true;
}).keyup(function (e) {
    if (down[192] && down[65]) {
        showAdd(e);

    }
    down[e.keyCode] = false;
});



/* ========================================================================================================== */
// TABLE FUNCTIONS - this is a portable set of methods for managing data inside a table
/* ========================================================================================================== */

//---------------------------------------------------
// DELETE
//---------------------------------------------------
function deleteItem(item, methodName, methodUrl) {

    // get the row
    var thisId = item.attr('id');
    thisId = thisId.replace(/\D/g, '');

    // get the column
    var thisClass = item.attr('class');
    thisClass = thisClass.replace(/\D/g, '');

    var dataToSend =
        {
            ID: thisId,
            MethodName: methodName,
        }
    
    $.ajax({
        url: methodUrl,
        data: dataToSend,
        dataType: "text",
        type: "POST",
        crossDomain: true,
        success: function (msg1, textStatus) { notify(msg1, textStatus); },
        error: function (msg2, textStatus, errorThrown) { notify(errorThrown, textStatus); }
    });
}



//---------------------------------------------------
// CANCEL EDIT
//---------------------------------------------------
function cancelEdit(item) {

    // get the row
    var thisId = item.attr('id');
    thisId = thisId.replace(/\D/g, '');

    // get the column
    var thisClass = item.attr('class');
    thisClass = thisClass.replace(/\D/g, '');

    // animate the cell (close)
    $(".containerOrig" + thisClass + "#data" + thisId).slideToggle({ duration: 150 });
    $(".containerEdit" + thisClass + "#edit" + thisId).slideToggle({ duration: 150 });

}




//---------------------------------------------------
// ANIMATE THE TEXTBOX
//---------------------------------------------------
function beginEdit(item) {

    // get the clicked cell's ID (row)
    var thisId = item.attr('id');
    // get the clicked cell's CLASS (column)
    var thisClass = item.attr('class');


    // make sure that you truncate all letters,
    // because the remaining digits contain the ID
    thisId = thisId.replace(/\D/g, '');
    thisClass = thisClass.replace(/\D/g, '');

    // at this point, thisId is a number, which is the row number

    // get data from the current text
    var org = item.text();

    // get the textbox from this column from this row
    $(".textbox" + thisClass + "#box" + thisId).val(org);

    // animate the cell by showing the edit textbox and hiding the original container
    $(".containerOrig" + thisClass + "#data" + thisId).slideToggle({ duration: 150 });
    $(".containerEdit" + thisClass + "#edit" + thisId).slideToggle({ duration: 150 });
}



//---------------------------------------------------
// UPDATE
//---------------------------------------------------
function updateItem(item, methodName, methodUrl) {

    // count the number of columns,
    // which is the number of parameters to be passed
    var colCount = $(".displayGrid").find('tr')[0].cells.length;

    // get the headers of the columns
    // at this point, the cols will have
    // Control, ID, etc, etc
    var cols = new Array(colCount);

    var colsVal = new Array(colCount);

    for (var gg = 0; gg < colCount; gg++)
        cols[gg] = $("tr:first").children("td:eq('" + gg + "')").text();


    // get the row
    var thisId = item.attr('id');
    thisId = thisId.replace(/\D/g, '');

    // get the column
    var thisClass = item.attr('class');
    thisClass = thisClass.replace(/\D/g, '');

    // get the value from the textbox
    var finalval = $(".textbox" + thisClass + "#box" + thisId).val();

    // set the value of the original text
    $(".replaceable" + thisClass + "#label" + thisId).text(finalval);

    // animate
    $(".containerOrig" + thisClass + "#data" + thisId).slideToggle({ duration: 150 });
    $(".containerEdit" + thisClass + "#edit" + thisId).slideToggle({ duration: 150 });


    // this will now decide the parameters you will pass onto the ajax call
    // METHODNAME will call the appropriate C# method
    // in this case, Update

    // fill in the parameter of the new property value

    dataToSend += cols[thisClass] + "=" + finalval;

    // save all the values in an array (RIGHT ORDER)
    // so you can just loop through them when setting params
    var dataArr = new Array(colCount - 1);
    dataArr[0] = thisId;

    for (var gg = 0; gg < colCount; gg++) {
        colsVal[gg] = $("span.replaceable" + gg + "#label" + thisId).html();
    }

    for (var o = 0; o < colCount; o++) {
        dataArr[o] = colsVal[o];
    }
    
    var dataToSend = "MethodName=" + methodName + "&ID=" + thisId + "&";

    // fill in the parameter of the new property value

    for (var f = 1; f < colCount; f++) {
        // the cols start from 1 because 0 is the column with the delete button
        dataToSend += cols[f] + "=" + dataArr[f] + "&";
    }

    // remove the last &
    dataToSend = dataToSend.replace(/(\s+)?.$/, '');
    
    // JSON
    // i need the actual value entered, then the id
    // to identify in the database which item needs this new
    // value to be saved in it's property

    // to get the property name that is changed, i took all
    // the headers

    // call the code behind C# method
    $.ajax({
        url: methodUrl,
        data: dataToSend,
        dataType: 'text',
        type: 'POST',
        // success will always happen, although validation happens in server
        success: function (msg, textStatus) { notify(msg, textStatus); },
        error: function (xhr, textStatus, errorThrown) { notify(xhr.responseText, errorThrown); }
    });

}

//-----------------------------------------------------------------
// ADD - receives array of columns, array of the data
//       in the columns, method name (ADDA), and method in the CS
//-----------------------------------------------------------------

function addItem(cols, dataArr, methodName, methodUrl) {

    var dataToSend = "MethodName=" + methodName + "&";

    // fill in the parameter of the new property value
    for (var f = 0; f < cols.length-1; f++) {
        // the cols start from 1 because 0 is the column with the delete button
        dataToSend += cols[f + 1] + "=" + dataArr[f] + "&";
    }
    
    // remove the last &
    dataToSend = dataToSend.replace(/(\s+)?.$/, '');


    $.ajax({
        url: methodUrl,
        data: dataToSend,
        dataType: "text",
        type: "POST",
        crossDomain: true,
        success: function (msg1, textStatus) { notify(msg1, textStatus); bClose(); },
        // you need this to stop the popup from sliding out
        error: function (xhr, textStatus, errorThrown) { notify(xhr.responseText, errorThrown); }
    });
}




/* ========================================================================================================== */
// RTQ FUNCTIONS
/* ========================================================================================================== */

// this function will remove the current room and display the next room
/*function nextRoom(current, next) {
    $(current).fadeOut("fast", function () {
        // once the fadeout completes, show the next room
        $(next).fadeIn();
    });
}*/

// resize
/* $(window).ready(function () {
     var wi = $(window).width();
     $(window).resize(function () {
         var wi = $(window).width();

         if (wi < 780) {
             $(".pt-perspective2").css("height", "40%");
             $(".pt-page2").css("height", "100%");
             $(".pt-triggers2").css("top", "90%");
          //   $('.page').width($(window).width());
         }
         else {
             $(".pt-perspective2").css("height", "250px");
             $(".pt-page2").css("height", "100%");
             $(".pt-triggers2").css("top", "65%");
             //$('.page').width($(window).width() - 150).css("margin", "auto");
         }
     });
 });*/