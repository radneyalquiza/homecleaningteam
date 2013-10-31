<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="quickQuote.aspx.cs" Inherits="admin_quickQuote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <!-- IMPORT SCRIPT -->
    <script src="<%= ResolveUrl("~/Scripts/jquery-1.9.1.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/jquery-1.9.1.min.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/jquery.bpopup.min.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/jquery.tipTip.js") %>" type="text/javascript">
    </script>
    
    <script src="<%= ResolveUrl("~/Scripts/myScript.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/jquery.noty.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/layouts/topRight.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/layouts/topLeft.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/layouts/bottomLeft.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/themes/default.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/jquery.ddslick.min.js") %>" type="text/javascript">
    </script>


    <!-- STYLE -->
    <link href="~/Styles/admin.css" rel="stylesheet" type="text/css" />
    <link href="../../../Styles/jquery.jgrowl.css" rel="stylesheet" />
    <link href="../../../Styles/tipTip.css" rel="stylesheet" />
    <link href="../Styles/rtq.css" rel="stylesheet" />

    <!-- FONTS -->
    <link href='http://fonts.googleapis.com/css?family=Acme' rel='stylesheet' type='text/css' />
    <link href='http://fonts.googleapis.com/css?family=Ubuntu' rel='stylesheet' type='text/css'/>


    <script>
        var noty1;
        $(function ($) {
            var roomcounter = 1;
            
            // keep other buttons disabled for now

            $("#urgency").addClass("disabledDiv");
            $("#urgency :input").attr("disabled", true);

            $("#housetype").addClass("disabledDiv");
            $("#housetype :input").attr("disabled", true);

            $("#cleaningtype").addClass("disabledDiv");
            $("#cleaningtype :input").attr("disabled", true);

            $("#area").addClass("disabledDiv");
            $("#area :input").attr("disabled", true);


            $("#begin").click(function (e) {
                 noty1 = noty({
                    text: 'Click here to restart the Quote',
                    type: 'warning',
                    dismissQueue: true,
                    layout: 'topLeft',
                    theme: 'defaultTheme',
                    sticky:true,
                    animation: {
                        open: { height: 'toggle' },
                        close: { height: 'toggle' },
                        speed: 170 // opening & closing animation speed
                    },
                    callback: {
                        afterClose: function () { window.location.reload(true); }
                    },
                });

                 $("#nameAHouse").fadeIn('fast');
                 $("#urgency").fadeIn('fast');
                 $("#area").fadeIn('fast');
                 $("#cleaningtype").fadeIn('fast');
                 $("#housetype").fadeIn('fast');

                $(this).hide();
                $("#intro").fadeOut();
            });


            
            //Dropdown plugin data
            var ddData = [
                {
                    text: "Next couple of days",
                    value: 1,
                    selected: false,
                    description: "The most urgent service"
                    //imageSrc: "http://dl.dropbox.com/u/40036711/Images/facebook-icon-32.png"
                },
                {
                    text: "Within a week",
                    value: 2,
                    selected: false,
                    description: "If your home can wait a week for the service",
                },
                {
                    text: "Within 2 weeks",
                    value: 3,
                    selected: true,
                    description: "If your home can wait 2 weeks for the service",
                },
                {
                    text: "Within a month",
                    value: 4,
                    selected: false,
                    description: "If you're not in a rush, and you just want to plan ahead"
                },
                {
                    text: "Within 2 months",
                    value: 5,
                    selected: false,
                    description: "Just a routine cleaning"
                },
                {
                    text: "Just checking around",
                    value: 6,
                    selected: false,
                    description: "We're sure you're going to want to book a job anyway, though"
                }
            ];


            $("#dd1").ddslick({
                data: ddData,
                height:200,
                imagePosition: "left",
                selectText: "Select your favorite social network"
            });

            $("#housetypeselect").ddslick();
            $("#ctypeselect").ddslick();

            $("#addCTypeBtn").click(function (e) {
                showAdd(e);
            });

            $("#titleTxt1").tipTip();
            $("#descTxt1").tipTip();
            $("#multi1").tipTip();


            // switch views to editable
            $("span[class^='replaceable']").click(function () {
                beginEdit($(this));
            });

            // dont save
            $("input[class^='canc']").click(function () {
                cancelEdit($(this));
            });

            // delete
            $("input[class^='delBtn']").click(function () {
                deleteItem($(this), 'DeleteC', 'cleaningTypes.aspx/deleteCtype');
            });

            // update
            // once any OK is clicked
            $("input[class^='ok']").click(function () {
                updateItem($(this), 'UpdateC', 'cleaningTypes.aspx/UpdateCtype');
            });


            // add
            $("#addBtn").click(function () {

                // first, get the values from the textboxes
                //var title = $("#<%//=titleTxt.ClientID%>").val();
                         //var desc = $("#<%//=descTxt.ClientID%>").val();
                         //var mult = $("#<%//=multi.ClientID%>").val();
                         /*
                                                  // if one is not entered, remove all data
                                                  if (title == "" || desc == "" || mult == "") {
                                                      title = "~noval~";
                                                      desc = "~noval~";
                                                      mult = "~noval~";
                                                  }
                                                  // count the number of columns,
                                                  // which is the number of parameters to be passed in JSON
                                                  var colCount = $(".displayGrid").find('tr')[0].cells.length;
                         
                                                  // get the headers of the columns
                                                  var cols = new Array(colCount);
                         
                                                  for (var gg = 0; gg < colCount; gg++)
                                                      cols[gg] = $("tr:first").children("td:eq('" + gg + "')").text();
                         
                                                  // then send them to the code behind method that
                                                  // will shove the data into the database
                                                  // USING AJAX
                         
                                                  // in this case, combine 2 values to put inside 1 column/parameter
                         
                                                  // save all the values in an array (RIGHT ORDER)
                                                  // so you can just loop through them when setting params
                                                  var dataArr = new Array(colCount - 1);
                                                  dataArr[0] = title;
                                                  dataArr[1] = mult;
                                                  dataArr[2] = desc;
                         
                                                  addItem(cols, dataArr, 'AddC', 'cleaningTypes.aspx/addCType');
                                                  */
            });

            // EVENTS
            $("#nameDone").click(function (e) {

                //$("#nameAHouse").hide();

                $("#cleaningtype").removeClass("disabledDiv");
                $("#cleaningtype :input").attr("disabled", false);
            });

            $("#cleaningDone").click(function (e) {

                //$("#cleaningtype").hide();
                $("#urgency").removeClass("disabledDiv");
                $("#urgency :input").attr("disabled", false);
            });

            $("#urgencyDone").click(function (e) {

                //$("#urgency").hide();
                $("#housetype").removeClass("disabledDiv");
                $("#housetype :input").attr("disabled", false);
            });

            $("#houseDone").click(function (e) {

                // get data for areas
                $.ajax({
                    type: "POST",
                    url: "quickQuote.aspx/getAreaList",
                    data: '{}',
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (msg) {
                        //alert(msg.d);
                        // get the json data

                        var json = JSON.parse(msg.d);
                        
                        var g = new Array();
                        g = json;
                        
                        // save the json data
                        var ddata = new Array();

                        $.each(g, function () {

                            if (this != undefined) {
                                ddata.push({
                                    text: this.fromMin + "-" + this.toMax + " square feet",
                                    value: this.Id,
                                    selected: false
                                });
                            }
                        });
                        makeDDSlick($("#areaSelect"), ddata, "Select your property area");
                    },
                    error: function (msg2) {
                        alert("No options available");
                    }
                });

                //$("#housetype").hide();
                $("#area").removeClass("disabledDiv");
                $("#area :input").attr("disabled", false);
            });

            $("#areaDone").click(function (e) {

                //var g = $("#areaSelect").data('ddslick');

                //$("#area").hide();

                $("#prelim").slideUp('slow', function () {
                    $("#startrooms").fadeIn();
                });
                
            });

            

            $("#str").click(function (e) {

                var n2 = noty({
                    text: 'Click on the blue boxes to open a room',
                    type: 'alert',
                    dismissQueue: true,
                    layout: 'bottomLeft',
                    timeout: 11000,
                    animation: {
                        open: { height: 'toggle' },
                        close: { height: 'toggle' },
                        speed: 170 // opening & closing animation speed
                    },
                });

                var n3 = noty({
                    text: 'Click on the orange boxes to open a list of options for that appliance',
                    type: 'alert',
                    dismissQueue: true,
                    layout: 'bottomLeft',
                    timeout: 11000,
                    animation: {
                        open: { height: 'toggle' },
                        close: { height: 'toggle' },
                        speed: 170 // opening & closing animation speed
                    },
                });
                var n4 = noty({
                    text: 'Click on the options to add the cleaning to the Selections box.',
                    type: 'alert',
                    dismissQueue: true,
                    layout: 'bottomLeft',
                    timeout: 11000,
                    animation: {
                        open: { height: 'toggle' },
                        close: { height: 'toggle' },
                        speed: 170 // opening & closing animation speed
                    },
                });

                var n5 = noty({
                    text: 'Click on the options from the Selections box to remove them',
                    type: 'alert',
                    dismissQueue: true,
                    layout: 'bottomLeft',
                    timeout: 11000,
                    animation: {
                        open: { height: 'toggle' },
                        close: { height: 'toggle' },
                        speed: 170 // opening & closing animation speed
                    },
                });

                var n5 = noty({
                    text: 'Clicking on FINALIZE will remove the room from view, so be sure to double check before you finalize.',
                    type: 'alert',
                    dismissQueue: true,
                    layout: 'bottomLeft',
                    timeout: 11000,
                    animation: {
                        open: { height: 'toggle' },
                        close: { height: 'toggle' },
                        speed: 170 // opening & closing animation speed
                    },
                });

                $("#startrooms").hide();
                $("#showRooms").fadeToggle();
                $("#RoomFolder1").fadeToggle();
            });

            $("#bathroomBtn").click(function (e) {
                $("#bathroomDiv").slideToggle({ duration: 150 });
            });

            $("#ds").click(function () {
                var g = $("#dd1").data('ddslick');
                alert(g.selectedData.text);
            });

            // if any of the Room drawer buttons is clicked
            // open the content container of the room
            /*$("input[id*='Btn']").click(function () {
                


                var btnid = /\d+(?:\.\d+)?/.exec($(this).attr('id'));
                // get all the room content divs, then close all of them
                // at the end, open the content div that corresponds
                // with the button clicked
                $("div[id$='Div" + btnid + "']").slideToggle({ duration: 300 });
            });*/

            // open options container of this appliance
            $("div[class^='rtqapp']").click(function () {

                var appid = /\d+(?:\.\d+)?/.exec($(this).attr('class'));
                $("div[class^='optioncontainer" + appid + "']").slideToggle({ duration: 200 });
            });

            // if this option is clicked, it will transfer itself to the opposite div
            // either from the optioncontainer or to the appselections div
            $("div[class^='rtqoption']").click(function () {

                // get this option's parent (container/appchoices)
                // this is where we can get the room ID

                $(this).fadeOut('fast', function () {

                    var par = $(this).parent().attr('id');
                    var parclass = $(this).parent().attr('class');

                    var roomId = /\d+(?:\.\d+)?/.exec(par);

                    // get the appliance this is in
                    var opid = /\d+(?:\.\d+)?/.exec($(this).attr('id'));

                    var appId = /\d+(?:\.\d+)?/.exec(opid);

                    // remove this from the container it currently is in
                    $(this).detach();

                    // if the parent class name begins with
                    var pattern = /^optioncontainer/;

                    // add this to the opposite container
                    if (parclass.match(pattern)) {
                        $(this).appendTo("div[class^='appchoices" + roomId + "']");
                        $(this).fadeIn();
                    }
                    else {
                        $(this).appendTo("div[class^='optioncontainer" + appId + "']");
                        $(this).fadeIn();
                    }
                });
            });


            // for finalize button, remove the parent container, including the app button
            $("input[id^='finalize']").click(function () {
                // is the room in the building?
                var canfind = "no";

                // fade out the current room
                $("#RoomFolder" + roomcounter).fadeOut('fast', function () {

                    while (canfind == "no" && roomcounter < 100) {
                        // whenever a finalize button is clicked, add 1, meaning next room
                        roomcounter++;

                        // check for the Room (with the roomcounter as ID) if it's here
                        if ($("#RoomFolder" + roomcounter).length > 0) {
                            $("#RoomFolder" + roomcounter).fadeIn();
                            canfind = "yes";
                        }
                    }

                    // if at the end (roomcounter reaches 100) and there is still no room
                    // found, there probably isn't anything else to show. so just DONE
                    if (canfind == "no" && roomcounter > 99)
                        $("#rtqDone").fadeIn('fast');
                });
                /*
                var parId = $(this).attr('id');
                var roomId = /\d+(?:\.\d+)?/.exec(parId);

                $(this).parent().fadeOut();
                $("input[id$='Btn" + roomId + "']").fadeOut();*/
            });
        });

        function finishRTQ() {
            $("#showSummary").fadeIn();
            $("#showRooms").hide();

            $("#housename").append($("#Text1").val());
            $("#totaltime").append("244 mins");
            $("#totalprice").append("$CAD 88.00");
        }

        function sendEmail() {
            var rec = $("#email").val();

            // show popup
            showPop("#regpop");
            // close the notification
            //$.noty.get("noty1").hide();

            // send email behind the scenes
            $.ajax({
                type: "POST",
                url: "quickQuote.aspx/sendEmail",
                data: '{"email": "' + rec + '"}',
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    var quote = msg.d;
                    $("#quoteBox").append("Your Quote Code is: " + quote);
                },
                error: function (msg1) {
                    $("#quoteBox").append("There was an error in creating this quote");
                }
            });

        }

        function proceedReg() {
            var em = $("#email").text();
            window.location.href = '~/selfserve/register.aspx?email=' + em;

        }

        function cancelReg() {
            window.location.reload(true);
        }

    </script>
                     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceholder1" Runat="Server">

    
    <!-- REMEMBER, SLIDEUP TO REMOVE A DIV, SLIDEUP TO SHOW -->

    <h2>Welcome to HomeCleaning Team's REAL-TIME QUOTE SYSTEM</h2>
    
    <div id="intro">
        <h4>With this sytem, not only do you fully customize your cleaning service,<br />
            but you can also enjoy the experience in doing so. Give it a try!
        </h4>
        <p>For hints and tips, you can click on the top-left corner bar</p>
    </div>

    <input id="begin" class="beginBtn" type="button" value="Begin the Quote" />

    <div id="prelim">
    <!-- PRELIMINARY QUESTIONS HERE -->
                <div id="nameAHouse" class="rtqDivPrelim">
                    <h3>Name your property!</h3>
                    <h5>(you can put any nickname, just for you to identify your property(ies) in the future)</h5>
                    <input id="Text1" type="text" class="ttextbox" /><br />
                    <input id="nameDone" type="button" class="beginBtn" value="Next" />
                </div>

                <div id="cleaningtype" class="rtqDivPrelim">
                    <h3>How do you want the service?</h3>
                    <h5>(you can specify every detail of the service later on)</h5>
                    <select id="ctypeselect">
                        <option>Routine Cleaning</option>
                        <option>Deep Cleaning</option>
                        <option>Move-in & Move-out Cleaning</option>
                        <option>Emergency Cleaning</option>
                        <option>Post-renovation Cleaning</option>
                        <option>Rental Turnover Cleaning</option>
                    </select>
                    <input id="cleaningDone" type="button" class="beginBtn" value="Next" />
                </div>

                <div id="urgency" class="rtqDivPrelim">
                    <h3>How soon do you need the service?</h3>
                    <h5>(this is just an estimate so that we can determine where to assign this job to)</h5>
                    <select id="dd1">
                    </select>
                    <input id="urgencyDone" type="button" class="beginBtn" value="Next" />
                </div>



                <div id="housetype" class="rtqDivPrelim">
                    <h3>What's the type of your property?</h3>
                    <select id="housetypeselect">
                        <option>Apartment</option>
                        <option>Condominium</option>
                        <option>Duplex</option>
                        <option>Semi-detached</option>
                        <option>Full Detached</option>
                    </select>
                    <input id="houseDone" type="button" class="beginBtn" value="Next" />
                </div>

                <div id="area" class="rtqDivPrelim">
                    <h3>What's the square footage of your property?</h3>
                    <select id="areaSelect">
                    </select>
                    <input id="areaDone" type="button" class="beginBtn" value="Done" />
                </div>
    
    </div>

                <div id="startrooms" class="rtqDiv">
                    <h3>Let's get started!</h3>
                    <h5>The settings for your property has been saved for this quote,
                        they can be seen at the bottom of the page.
                    </h5>
                    <input id="str" type="button" class="beginBtn" value="Next" />
                </div>


    <!-- HERE, THE ACTUAL RTQ BEGINS -->

            <div id="showRooms" class="rtqDiv">
                <h3>Begin the Quote:</h3>
            </div>

            <div id="showSummary" class="rtqDiv">
                <h3>Congratulations! You've just made an RTQ!</h3>
                
                <div id="housename" class="summaryDiv">
                    <h5>Property Name:</h5>
                </div>

                <div id="totaltime" class="summaryDiv">
                    <h5>Total Time:</h5>
                </div>

                <div id="totalprice" class="summaryDiv">
                    <h5>Total Price:</h5>
                </div>

                <div id="emailentry" class="enterEmailDiv">
                    <p>To view the complete detailed copy of your quote, and in order to be able<br />
                        to book this job, introduce yourself to us and we will get this ball rolling!<br />
                        To start, please enter an email address to receive the complete copy of your RTQ: 
                    </p>
                    <input id="email" class="ttextbox" type="text" />
                    <input id="confirmquote" type="button" class="beginBtn" value="Confirm" onclick="sendEmail();" />
                </div>
            </div>

    <!-- POPUPS -->

    <div id="regpop" class="popup">
        <h4>Thank you for using The HomeCleaningTeam's RealTimeQuote System!</h4><br />
       
        <div id="quoteBox"></div><br />

         While we have you, why not take the time to register now to proceed with<br />
        booking your quote?<br />
        It's gonna be very quick, we promise.<br />
        (Cancelling will remove your quote from our records)<br />

        

        <input type="button" id="reg" class="beginBtn" value="Proceed" onclick="proceedReg();" />
        <input type="button" id="cancel" class="beginBtn" value="Cancel" onclick="cancelReg();"/>
    </div>

    <!-- EXTRA BITS -->
    <br />

</asp:Content>

