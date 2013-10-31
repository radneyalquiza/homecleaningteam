<%@ Page Title="" Language="C#" MasterPageFile="~/admin/rtqMaster.master" AutoEventWireup="true" CodeFile="qQuote.aspx.cs" Inherits="admin_qQuote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />


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
    <script src="<%= ResolveUrl("~/Scripts/jquery.easing.1.3.js") %>" type="text/javascript">
    </script>
   <!-- <script src="<%= ResolveUrl("~/Scripts/circleMenu.js") %>" type="text/javascript">
    </script>-->
    <script src="<%= ResolveUrl("~/Scripts/jquery.icheck.js") %>" type="text/javascript">
    </script>
                       
    <script src="<%= ResolveUrl("~/Scripts/equalize.min.js") %>" type="text/javascript">
    </script>
    <!--<script src="<%= ResolveUrl("~/Scripts/html5shiv.js") %>" type="text/javascript">
    </script>
    -->
    <script src="<%= ResolveUrl("~/Scripts/respond.min.js") %>" type="text/javascript">
    </script>
            
    <script src="<%= ResolveUrl("~/Scripts/masonry.pkgd.min.js") %>" type="text/javascript">
    </script>
            
    <script src="<%= ResolveUrl("~/Scripts/jquery.transit.min.js") %>" type="text/javascript">
    </script>
    
    <script src="<%= ResolveUrl("~/Scripts/jquery.atlasPageTransition.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/html2canvas.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/jquery.atlasChecklist.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/jquery.mCustomScrollbar.js") %>" type="text/javascript">
    </script>
    
    <script src="<%= ResolveUrl("~/Scripts/withinViewport.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/jquery.bullseye-1.0.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/jquery.withinViewport.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/jquery.viewport.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/jquery.mousewheel.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/jquery.visible.js") %>" type="text/javascript">
    </script>

    <script src="<%= ResolveUrl("~/Scripts/jquery.atlasTooltip.js") %>" type="text/javascript">
    </script>

    <!-- STYLE 
    <link href="~/Styles/admin.css" rel="stylesheet" type="text/css" />-->
    <link href="../Styles/rtq.css" rel="stylesheet" />
    <link href="../Styles/line/orange.css" rel="stylesheet" />
    <link href="../Styles/line/blue.css" rel="stylesheet" />
    <link href="../Styles/tipTip.css" rel="stylesheet" />
    <!--<link href="../Styles/main.css" rel="stylesheet" />-->
    <link href="../Styles/grid.css" rel="stylesheet" />
    <link href="../Styles/atlasChecklist.css" rel="stylesheet" />
    <link href="../Styles/mainmenu.css" rel="stylesheet" />

    <link href="../Styles/atlasPageTransitions.css" rel="stylesheet" />
    <link href="../Styles/atlasTooltip.css" rel="stylesheet" />

    <!-- FONTS -->
    <link href='http://fonts.googleapis.com/css?family=Acme' rel='stylesheet' type='text/css' />
    <link href='http://fonts.googleapis.com/css?family=Ubuntu' rel='stylesheet' type='text/css'/>
    

    <style>
        * { -moz-box-sizing: border-box; -webkit-box-sizing: border-box; box-sizing: border-box; }

        #rtqoutercont
        {
            width:100%;
            height:100%;
            margin:auto;
            margin-top:-25px;
            font-family: 'Open Sans', sans-serif;
        }

        .prelimDiv
        {
            margin:auto;
            border-radius:7px;
            padding:10px;
            background-color:white;
            width:60%;
        }

        .pr
        {
            opacity:0.1;
        }


        select
        {
           margin-top:-2px;
           width:auto;
           font-size: 0.9em;
           font-weight:600;
           line-height: 1;
           border: 0;
           height: 25px;
           -webkit-appearance: none;
           border-radius:5px;
           border:1px solid #999;
           padding:3px;
           color:#5a5a5a;
           font-family:Verdana;
           box-shadow: 1px 1px 1px #808080;
            /*border:1px dashed #808080;*/
        }
            select:focus
            {
                outline: none;
                border: 1px solid #7bc1f7;
                box-shadow: 0px 0px 8px #7bc1f7;
                -moz-box-shadow: 0px 0px 8px #7bc1f7;
                -webkit-box-shadow: 0px 0px 8px #7bc1f7;
            }

            select.inline
            {
                height:22px;
                font-size:0.85em;
                margin-left:16px;
            }

        /* inner container for an appliance */
        div[class^='choices']
        {
            width:99%;
            margin:auto;
            text-align:center;
            min-height:250px;
            background-color:white;
            padding:0px 0px 2px 0px;
            /*box-shadow: 3px 3px 2px #888;*/
        }

        /* container for each row of appliances in each room
           this will ensure equal heights of all 3 divs in each row    
        */
        div[class^='appRowContainer']
        {
            text-align:center;
            margin:auto;
        }

        /* container for an appliance */
        div[class^='choiceContainer']
        {
            width:33%;
            text-align:center;
            padding:2px 2px 2px 2px;
            border-radius:5px;
            /*float:left;*/
            min-height:250px;
            display:table-cell;
            /*box-shadow: 3px 3px 2px #888;*/
        }

        ul
        {
            list-style: none;
            /*width:95%;*/
            padding-left:0px;
            margin:auto;
        }

        .applist
        {
            display: inline;
        }
        .outer
        {
            text-align: center;
        }

        /* the title of an appliance*/
        .appHead
        {
            color: white;
            font-size:20px;
            font-weight:600;
            /*background-color:#a7a7a7;*/
            background-color:#70b8d8;
            border-top-left-radius:5px;
            border-top-right-radius:5px;
            text-align:left;
            padding:4px;
            cursor:default;
            margin-bottom:8px;
        }

        /* for sub options */
        div [id^='inner']
        {
            width:100%;
            display: none;
            position:absolute;
            z-index:99;
            /*background-color:#ededed;*/
            background-color:#3b3b3b;
            border:3px solid white;
            padding:5px;
            border-radius:5px;
            box-shadow: 0px 3px 1px -1px #808080;
        }

        /* for value textboxes */
        div [id^='valuebox']
        {
            width:99%;
            display: none;
            position:absolute;
            z-index:99;
            /*background-color:#ededed;*/
            background-color:#3b3b3b;
            border:3px solid white;
            padding:5px;
            border-radius:5px;
            box-shadow: 0px 3px 1px -1px #808080;
            color:white;
            text-align:center;
        }

        select[id^='valueinput']
        {
            width:50px;
            padding:2px;
        }


        li
        {
            margin:auto;
        }

        .prel2
        {
            margin:auto;
            width:90%;
        }

        			#slider {
				width:600px;
				height:250px;
				
				/*IE bugfix*/
				padding:0;
				margin:0;
			}
			
			#slider li { list-style:none; }
			
			#preliminary {
				width:600px;
				margin:50px auto;
                display:none;
			}


        #choicex
        {
        }
        #choicehold
        {
            width:80%;
        }
        #applistcont
        {
            width:200px;
            height:200px;
        }

        .box
        {
            padding:9px;
            background-color:white;
            font-size:0.80em;
            box-shadow: 0px 3px 1px -1px #999;
            border-radius:5px;
            margin-top:8px;
        }

        .rtqcont1
        {
            width:91%;
            margin:auto;
        }
        .item {width: 35%; background-color:#c0e6ff; margin:2px; padding:10px}

        #roomtitle
        {
            color:black;
            font-size:25px;
            font-weight:600;
        }

        .roomnumselect
        {
            display:inline-block;
            width:50px;
            height:50px;
            background-color:#c0e6ff;
            color:#484848;
            border-radius:999px;
            transition:background-color 0.4s;
            transition:font-weight 0.3s;
            transition:color 0.3s;
            transition:border 0.4s;
        }

            .roomnumselect:hover
            {
                cursor:pointer;
                background-color:#59a9dd;
                color:white;
                font-weight:600;
                border:12px solid #337abe
            }

        input[class^='slideoutbtn']
        {
            background-color:white;
            color:#808080;
            cursor:pointer;
            position:absolute;
            right:5%;
            border:0px;
           /* opacity:0;*/
            padding:5px;
            border-bottom-left-radius:2px;
            border-bottom-right-radius:2px;
            box-shadow: 0px 3px 1px -2px #cccccc;
            font-size:0.8em
        }

        .selectedNum
        {
            background-color:#337AAA;
            color:#ededed;
        }
        .revealTexts
        {
            display:none;
        }

        * { -moz-box-sizing: border-box; -webkit-box-sizing: border-box; box-sizing: border-box; }

        .notification
        {
            position:absolute;
            top:50%;
            left:50%;
            width:200px;
            margin-left:-100px;
            font-size:0.8em;
            color:white;
            background-color:black;
            border:4px solid white;
            text-align:center;
            display:none;
            z-index:99;
            padding:5px 5px 5px 5px;
            padding-top:15px;
            border-radius:5px;
            box-shadow: 0px 3px 1px -1px #999;
        }
            .notification h4
            {
                font-size:1.2em;
                line-height:0.6em;
                font-weight:600;
                color:white;
                letter-spacing:1px;
            }

        .popupapply
        {
            top:50%;
            left:50%;
            margin-left:-325px;
            margin-top:-225px;
            width:650px;
            height:450px;
            background-color:#e8e8e8;
            border:4px solid #337abe;
            padding:15px;
            border-radius:15px;
            display:none;
            text-align:center;
            position:fixed;
            z-index:999;
            box-shadow: 0 8px 6px -6px black;
            color:#484848;
        }
            .popupapply h2
            {
                margin-top:-2px;
            }

        .popupapplybtn, .popupunapplybtn
        {
            width:28px;
            height:28px;
            background-color:#eee;
            padding:3px;
            border-radius:5px;
            display:none;
            text-align:center;
            position:absolute;
            z-index:99;
            box-shadow: 0px 3px 1px -1px #808080;
            font-size:0.8em;
            color:#484848;
            border:1px solid #337abe;
            top:5%;
            left:98%;
            transition:all 0.3s;
        }

        .popupapplybtn
        {
            background-image:url("../Styles/img/to-do-list_checked3.png");
            background-repeat:no-repeat;
            background-position:center; 
        }
        .popupunapplybtn
        {
            background-image:url("../Styles/img/check-all-delete.png");
            background-repeat:no-repeat;
            background-position:center; 
        }

            .popupapplybtn:hover
            {
                cursor:pointer;
                /*border:1px solid black;*/
                background-color:#59a9dd;
                color:white;
            }
            .popupunapplybtn:hover
            {
                cursor:pointer;
                /*border:1px solid #d02f2f;*/
               background-color:#ef8383;
                color:white;
            }

            .popupapply p
            {
                font-size:0.8em;
                line-height:1em;
            }
        .popupapply span
        {
            color:#ff7d00
        }

        .btnvisible
        {
            transition:all 0.5s;
            display:block;
            background-color:#337AAA;
        }
        .propertyquestionsclass
        {
            width:90%;
            margin:auto;
            padding:10px;
            border-radius:5px;
            display:none;
            margin-top:120px;
            text-align:center;
        }
            h3.prop
            {
                color:#d3d3d3;
                text-shadow:none;
                text-align:center;
                line-height:25px;
            }
        .propertyquestioninner
        {
            width:90%;
            margin:auto;
        }
        .propertydesc
        {
            text-align:center;
            margin:auto;
            padding:10px;
        }
        li.grid-half
        {
            margin-top:-15px;
        }
        li.grid-third
        {
            margin-top:-15px;
        }
        
        .propertyquestionpart, .servicequestionpart 
        {
            display:none;
            text-align:center;
            width:99%;
            margin:auto;
        }

        .propertydiv
        {
            min-height:100px;
            border-radius:5px;
            background-color:#91cef6;
            box-shadow: 0px 3px 1px -1px #999;
            margin:auto;
            margin-top:6px;
            margin-left:6px;
            padding:20px;
        }

            .propertydiv h1
            {
                color:#484848;
                font-size:1em;
                margin-top:2px;
                margin-bottom:8px;
                font-weight:600;
                letter-spacing:1px;
            }

            .propertydiv h4
            {
                color:#484848;
                font-size:0.8em;
                letter-spacing:0px;
            }

            .propertydiv .ttextbox
            {
                height:25px;
            }

        .proptitle
        {
            width:99%;
            background-color:#337AAA;
            margin:auto;
            height:55px;
            padding:5px 5px 5px 5px;
            border-radius:5px;
            border:1px solid #065d8f;
        }

        div[class^='show']
        {
            display:none;
            width:85%;
            margin:auto;
        }
        div.demoimage
        {
            margin:auto;
            position:relative;
        }

        #quoteBox .quotenumber
        {
            color:#337abe;
            font-size:1.5em;
        }

        .popup
        {
            width:70%;
        }

        .popupapply img
        {
            width:60%;
            min-width:220px;
        }

        .tutorial
        {
            width:100%;
            height:300px;
            position:relative;
        }

        #closeapply
        {
            position:absolute;
            top:5px;
            left:5px;
            background-color:#59a9dd;
            color:white;
            border:none;
            border-radius:10px;
            font-size:0.8em;
            padding:5px;
        }
            #closeapply:hover
            {
                background-color:#337AAA;
                cursor:pointer;
            }

        

        html, form, body{ height: 100%; width:100%;  margin: 0px;
    padding: 0px }

        @media only screen and (max-height: 400px)
        {
            form             {
                overflow:auto;
            }

        }

        @media only screen and (max-width: 840px)
        {
            .propertyquestionsclass
            {
                margin-top:120px;

                width:95%;
            }
            .propertyquestioninner
            {
                width:95%;
            }
            .propertydiv select
            {
                width:80%;
            }
            .propertydiv .ttextbox
            {
                width:80%;
            }
            .popupapply
            {
                width:750px;
                margin-left:-375px;
            }
        }

        @media only screen and (max-width: 768px)
        {
            .pageTransItem
            {
                padding-top:10px;
            }
            .propertyquestionsclass
            {
                margin-top:10px;

            }
            .propertydiv .ttextbox
            {
                width:80%;
            }
            .propertydiv select
            {
                width:80%;
            }
            .propertyquestioninner
            {
                width:90%;
            }
            .popupapply
            {
                width:600px;
                margin-left:-300px;
            }
            .pad
            {
                padding-top:0px;
            }

        }
        @media only screen and (max-width: 640px)
        {
            .propertyquestionsclass
            {
                margin-top:10px;

            }
            .propertydiv select
            {
                width:80%;
            }
            .propertydiv .ttextbox
            {
                width:80%;
            }
            .popupapply
            {
                width:500px;
                margin-left:-250px;
            }
            .pad
            {
                padding-top:0px;
            }
        }

        @media only screen and (max-width: 480px)
        {
            .propertyquestionsclass
            {
                margin-top:10px;

            }
            .propertyquestioninner
            {
                width:95%;
            }
            .popupapply
            {
                width:350px;
                margin-left:-175px;
            }
            .pad
            {
                padding-top:0px;
            }
        }
        @media only screen and (max-width: 320px)
        {
            .propertyquestionsclass
            {
                margin-top:10px;

            }
            .propertyquestioninner
            {
                width:98%;
            }
            .popupapply
            {
                width:180px;
                margin-left:-90px;
            }
            .pad
            {
                padding-top:0px;
            }
        }

    </style>


    <script>
        var numbath = 0;   // global value for number of bathrooms
        var numbed = 0;    // global value for number of bedrooms
        var $container;    // container for masonry flavoured pages


        // global value containers
        // bathroom and bedroom will have 2d arrays because
        // both can contain more than 1 room (array element),
        // looking like:

        //  b1   b2   b3   b4
        //  o1   o5   o9   o13
        //  o2   o6   o10  o14
        //  o3   o7   o11  o15
        //  o4   o8   o12  o16

        // the array will be initialized first with the number of bath/bedrooms
        // chosen by the user. then each element (which is an array) will be
        // pushed into by the option selection.

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

        $(function ($) {
            
            $("#nextroom").hide();
            $("#finish").hide();

            $("#init").click(function () {
                $("#cont").atlasChecklist();
                $("#cont2").atlasChecklist();
            });
            $("#ckall").click(function() {
                $("#cont").atlasChecklist('checkAll');
            });
            $("#unckall").click(function () {
                $("#cont").atlasChecklist('uncheckAll');
            });
            $("#toggle").click(function () {
                $("#cont").atlasChecklist('toggleItem', {dataname:'id', data:1});
            });
            $("#destroy").click(function () {
                $("#cont").atlasChecklist('destroy');
                $("#cont2").atlasChecklist('destroy');
            });
            $("#checkbyclass").click(function () {
                $("#cont").atlasChecklist('checkbyClass', 'chk');
            });
            $("#expand").click(function () {
                $("#cont").atlasChecklist('expandAll');
            });
            $("#setidentifier").click(function () {
                $("#cont").atlasChecklist('setDefaultDataName', 'optionid');
            });


            function createRoom(roomnum) {
                var roomname;
                var roomname2;
                roomnum = roomnum - 1;
                
                switch (roomnum) {
                    case 0: roomname = "Bathroom"; break;
                    case 1: roomname = "Bedroom"; break;
                    case 2: roomname = "Kitchen"; break;
                    case 3: roomname = "DiningRoom"; break;
                    case 4: roomname = "LivingRoom"; break;
                    case 5: roomname = "Office"; break;
                    default: roomname = "none"; break;
                }
                $("#" + roomname + "Container").fadeOut(200);
                roomnum++;
                switch (roomnum) {
                    case 0: roomname2 = "Bathroom"; break;
                    case 1: roomname2 = "Bedroom"; break;
                    case 2: roomname2 = "Kitchen"; break;
                    case 3: roomname2 = "DiningRoom"; break;
                    case 4: roomname2 = "LivingRoom"; break;
                    case 5: roomname2 = "Office"; break;
                    default: roomname2 = "none"; break;
                }
                currentRoom += 1;
                setTimeout(function () {
                    callCreateRoom(currentRoom, roomname2);
                    if (roomname2 == "Office") { $("#finish").show(); $("#nextroom").hide(); }
                }, 400);
            }


            $("#nextroom").click(function () {
                //if (roomActive == true) {
                    // ($('.typeselector select').val() != "") {
                 //       setFloorType();
                //        console.log(currentRoom);
                //        $('.typeselector select').val("");
                        createRoom(currentRoom);
                //        roomActive = false;
                        
                //    } else {
                //        alert('Please select a floor type.');
                //    }
                //}
                //else {
                //    setFloorType();
                //    createRoom(currentRoom);
                //    roomActive = false;
                    
                //}
            });
            /*
            function setFloorType() {
                switch (currentRoom - 1) {
                    case 0: bathfloortype = $('.typeselector select').val(); console.log('bath ' + bathfloortype); break;
                    case 1: bedfloortype = $('.typeselector select').val(); console.log('bed ' + bedfloortype); break;
                    case 2: kitchenfloortype = $('.typeselector select').val(); console.log('kitc ' + kitchenfloortype); break;
                    case 3: diningfloortype = $('.typeselector select').val(); console.log('din ' + diningfloortype); break;
                    case 4: livingfloortype = $('.typeselector select').val(); console.log('liv ' + livingfloortype); break;
                    case 5: officefloortype = $('.typeselector select').val(); console.log('off ' + officefloortype); break;
                }
            }
            */
            $("#cont3").atlasChecklist();

            $("#ck").click(function () {
                var list = $("#cont").atlasChecklist('getCheckedText');

                $("#output").html(list);

                var list2 = $("#cont2").atlasChecklist('getCheckedText');

                $("#output").append(list2);
            });
            $("#ck2").click(function () {
                var list = $("#cont").atlasChecklist('getCheckedData');
                console.log(list);

                $("#output").html(list);

                var list2 = $("#cont2").atlasChecklist('getCheckedData');

                $("#output").append(list2);
            });

            var space = false;
            $(document).keyup(function(evt) {
                if (evt.keyCode == 32) {
                    $('input:visible:not(".ok2"):not("#end")').click();
                }
            }).keydown(function(evt) {
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
                    $(".propertyquestionpart").fadeIn(300);
                });
            });

            $("#gotoservicequestions").click(function () {
                $(".propertyquestionpart").fadeOut(500, function () {
                    $("#end").fadeIn(200);
                    $(".servicequestionpart").fadeIn(500);
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
                    console.log($("#cleaningtype option:selected").text());

                    $(".tips#disclaimer").show(1, function () {
                        $(".tips#disclaimer").find('p:first-child').show(1, function () {
                             $(this).addClass("slideUp");
                         });
                    });
                    appendToSidebar("Quote Type", "Quick Quote");


                    //showPopup("numBathrooms");
                    //$("#outer").show();   // this is the tutorial
                });
            });

            // disclaimer buttons
            $('.ok').click(function () {
                $(this).parent().removeClass("slideUp");
                $(this).parent().next().delay(500).show(1, function () {
                    $(this).addClass('slideUp');
                });
            });

            // for a tip beside gif arrow 
            $(".gifarrow").hover(
                function () {

                },
                function () {

                }
            );

            // load all quick quote (basic) selections
            $("#qquote").click(function () {
                quotetype = "routine";    // that's what she said
                $(this).parent().parent().fadeOut(400, function () {
                    $(".tips#disclaimer").fadeIn(1, function () {
                        $(".tips#disclaimer").find('p:first-child').show(1, function () {
                            $(this).addClass("slideUp");
                        });
                    });
                });
                appendToSidebar("Quote Type", "Quick Quote");
                // call pre-loader
            });
            // load all deep (deep cleaning type) selections
            $("#deepquote").click(function () {
                quotetype = "deep";    // that's what she said
                $(this).parent().parent().fadeOut(400, function () {
                    $(".tips#disclaimer").fadeIn(1, function () {
                        $(".tips#disclaimer").find('p:first-child').show(1, function () {
                            $(this).addClass("slideUp");
                        });
                    });
                });
                appendToSidebar("Quote Type", "Deep Cleaning Quote");
                // call pre-loader
            });

            // when the last disclaimer button is clicked, we have to ajax the first room
            $("#startquote").click(function () {
                // animate out
                $('.topBar').addClass('topBar-pullup');
                $('.pad').css('padding-top', '40px');
                $('.topBar h1').hide();//.html('RTQ&#0153;');
                $('.topBar h4').hide();
                $('.topBar .topBarDiv').addClass('topBarDiv-pullup').append('<p>Real-Time Quote System <span>by The Home Cleaning Team</span></p>');
                $('.topBar .topBarDiv').append('<input type="button" id="reset" class="resetBtn" value="Reset RTQ" />');

                $("#reset").click(function () { location.reload(); });

                //$('.topBar h4').html('<img src="../Styles/img/logofin3.png" />');
                $('.sidebar').css('margin-top', '-60px');

              /*  var floortypes = '<div id="floortype" class="typeselector">';
                floortypes += '<strong>Choose floor type:</strong><br/><select>';
                floortypes += '<option value="">Select...</option>';
                floortypes += '<option value="HRDWD">Hardwood</option>';
                floortypes += '<option value="MRBL">Marble</option>';
                floortypes += '<option value="CRMC">Ceramic</option>';
                floortypes += '<option value="LAMT">Laminate</option>';
                floortypes += '</select></div>';
                */

                //$('body').append(floortypes);
                $(this).parent().fadeOut(200);
                $('body').css('overflow', 'auto');
                createRoom(currentRoom);
            });

            // ajax for creating rooms
            function callCreateRoom(room, roomname) {
                $("#loadercontainer").show();
                $.ajax({
                    type: 'POST',
                    url: 'qQuote.aspx/callRoom',
                    data: '{ "roomnum" : "' + room + '"}',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    async: false,
                    crossDomain: true,
                    success: function (msg1) {

                        $("#nextroom").fadeIn(200);

                        // will receive room
                        console.log('back from create service data' + roomname + " " + room);
                        $("#loadercontainer").hide();
                        $("#" + roomname + "Container").append(msg1.d);
                        $("#" + roomname + "Container").fadeIn(300);
                        $('#disclaimer').hide();
                        if (currentRoom > 1)
                            $(document).find('.gifarrow').remove();

                        setMultiRoom(room, roomname);
                    },
                    error: function (error) {
                        alert("Error: Retrieving data failed.");
                    }
                });
            }

            // for positioning multirooms
            var roompos = new Array(300, 640, 980, 1320);

            function addRoom(room, roomname) {
                
                $("#loadercontainer").show();
                $.ajax({
                    type: 'POST',
                    url: 'qQuote.aspx/callRoom',
                    data: '{ "roomnum" : "' + room + '"}',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    async: false,
                    crossDomain: true,
                    success: function (msg1) {
                        // will receive room
                        console.log('back from create service data' + roomname + " " + room);
                        $("#loadercontainer").hide();
                        $("#" + roomname + "Container").append(msg1.d);
                        $("#" + roomname + "Container").fadeIn(300);
                        $('#disclaimer').hide();
                        if (currentRoom > 1)
                            $(document).find('.gifarrow').remove();

                        setMultiRoom(room, roomname);
                    },
                    error: function (error) {
                        alert("Error: Retrieving data failed.");
                    }
                });
            }

            function setMultiRoom(room, roomname) {
                $(".arrowdown").click(function () {
                    console.log('activate');
                    if ($(this).parent().parent().parent().find('.roomCont').length == 4)
                        $(this).parent().parent().find('.addroom').html('Done');
                    $(document).find('.gifarrow').remove();
                    if ($(this).parent().parent().find(".appslist").is(':hidden')) {
                        $(this).parent().parent().find('.appl').atlasChecklist({ containerWidth: '320' });
                        $(this).parent().parent().find('.appl').atlasChecklist('setDefaultDataName', 'optionid');
                        $(this).parent().parent().find('.appl').atlasChecklist('setDataName', { 'dataName': 'appname', 'dataIdentifier': 'appname' });
                        $(this).parent().parent().find('.appl').atlasChecklist('setDataName', { 'dataName': 'timeunit', 'dataIdentifier': 'timeunit' });
                        $(this).parent().parent().find('.appl').atlasChecklist('setDataName', { 'dataName': 'optionname', 'dataIdentifier': 'optionname' });
                        $(this).parent().parent().find('.appl').atlasChecklist('checkbyClass', quotetype);
                        var subs = $(this).parent().parent().find('.appl').find('.sub');
                        if (subs.length > 0) {
                            $.each(subs, function () {
                                $(this).atlasChecklist('setDefaultDataName', 'suboptionid');
                                //$(this).atlasChecklist('setDataName', 'appname');
                                //$(this).atlasChecklist('setDataName', 'timeunit');

                            });
                        }
                        $(this).parent().parent().find(".appslist").delay(400).slideDown();
                    }
                    $(this).unbind('click');
                });
                

                // for adding rooms
                $(".addroom").click(function () {
                    console.log(roompos);
                    $(this).parent().parent().find('.roomtitle').find('.arrowdown').hide();
                    $(this).parent().parent().find('.roomtitle').find('.xbtn').show();
                    console.log($(this).parent().parent().parent().find('.roomCont').length);
                    // if the room container's length is still less than 4, add more
                    if ($(this).parent().parent().parent().find('.roomCont').length < 5) {

                        //if (!confirm('Would you like to apply the same options to the added room?')) {
                            var chk = $(this).parent().find('.appl');   // get all the apps
                            $.each(chk, function () {
                                //console.log($(this).find('.sub').atlasChecklist('getCheckedData'));
                                //console.log($(this).atlasChecklist('getCheckedData'));
                            });
                            var count = $(this).parent().parent().parent().find('.roomCont').length;
                            var origtext = $(this).parent().parent().find('.roomtitle').find('.titletxt').text();
                            $(this).parent().parent().find('.roomtitle').find('.titletxt').text(origtext + ' # ' + (count));
                            $(this).parent().parent().css('left', roompos[count - 1] + 'px').addClass('roomCont-back');
                            $(this).parent().parent().css('top', '110px');

                            if ($(this).parent().parent().parent().find('.roomCont').length < 4)
                                addRoom(room, roomname);
                            $(this).hide();
                        //}
                        //else console.log('Apply options!');
                    }
                    else
                        roompos = 300;

                    if ($(this).parent().parent().parent().find('.roomCont').length > 4)
                        $(this).parent().parent().parent().find('.roomCont').removeClass('roomCont-back');
                });

                $(".xbtn").click(function () {
                    $(this).parent().parent().find('.appslist').slideUp(300, function () {
                        var roomc = $(this).parent().parent(); // #_______roomContainer
                        $(this).parent().remove();
                        var count = 0;
                        $.each(roomc.find('.roomCont'), function () {

                            if ($(this).find('.appslist').is(':visible') && $(this).hasClass('roomCont-back')) {// && parseInt($(this).css('left').replace(' px', '')) > 360) {
                                console.log($(this).find('.roomtitle'));
                                var origtext = $(this).find('.roomtitle').find('.titletxt').text().replace(/[0-9]/g, '').replace(' ', '').replace('#', '');
                                $(this).find('.roomtitle').find('.titletxt').text(origtext + ' # ' + (count + 1));
                                $(this).css('left', roompos[count] + 'px');
                                count++;
                            }
                        });
                        count = 0;
                    });
                });

                // to delete a current room
                $(".del").click(function () {
                    $(this).parent().parent().parent().parent().remove();
                });
            }

            $("#finish").click(function () {
                collectData();
            });

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

            // aggregate quote data
            function collectData() {
                
                var databuild = new Array();    // will hold an array of room data (6 or less)
                var rooms = new Array("Bathroom", "Bedroom", "Kitchen", "DiningRoom", "LivingRoom", "Office");
                // loop through rooms
                for (var i = 0; i < rooms.length; i++) {
                    if (rooms[i] == "Bathroom" || rooms[i] == "Bedroom") {
                        // get the multiple instances of this room
                        var multi = $('#' + rooms[i] + 'Container').find('.roomCont');
                        console.log(multi);
                        for (var v = 0; v < multi.length; v++) {
                            var tempdata = $(multi[v]).find('.appl').atlasChecklist('getCheckedItems');
                            var tempapps = $(multi[v]).find('.appl').atlasChecklist('getCheckedDataByName', 'appname').unique();
                            var tempdatabuild = new Object();
                            tempdatabuild.RoomName = rooms[i];
                            tempdatabuild.FloorType = $(multi[v]).find('.typeselector select').val();
                            tempdatabuild.Apps = new Array();
                            // loop through the apps in this room
                            for (var j = 0; j < tempapps.length; j++) {
                                var tempapp = new Object();
                                tempapp.AppName = tempapps[j];
                                tempapp.Options = new Array();
                                for (var x = 0; x < tempdata.length; x++) {
                                    if (tempdata[x].data('appname') == tempapps[j]) {
                                        var temp = new Object();
                                        temp.TimeUnit = tempdata[x].data('timeunit');
                                        totalTime += parseInt(temp.TimeUnit);
                                        temp.OptionName = tempdata[x].data('optionname');
                                        tempapp.Options.push(temp);
                                    }
                                }
                                tempdatabuild.Apps.push(tempapp);
                            }
                            databuild.push(tempdatabuild);
                        }

                    }
                    else {
                        var tempdata = $('#' + rooms[i] + 'Container').find('.roomCont').find('.appl').atlasChecklist('getCheckedItems');
                        var tempapps = $('#' + rooms[i] + 'Container').find('.roomCont').find('.appl').atlasChecklist('getCheckedDataByName', 'appname').unique();
                        var tempdatabuild = new Object();
                        tempdatabuild.RoomName = rooms[i];
                        tempdatabuild.FloorType = $('#' + rooms[i] + 'Container').find('.roomCont').find('.typeselector select').val();
                        tempdatabuild.Apps = new Array();
                        // loop through the apps in this room
                        for (var j = 0; j < tempapps.length; j++) {
                            var tempapp = new Object();
                            tempapp.AppName = tempapps[j];
                            tempapp.Options = new Array();
                            for (var x = 0; x < tempdata.length; x++) {
                                if (tempdata[x].data('appname') == tempapps[j]) {
                                    var temp = new Object();
                                    temp.TimeUnit = tempdata[x].data('timeunit');
                                    totalTime += parseInt(temp.TimeUnit);
                                    temp.OptionName = tempdata[x].data('optionname');
                                    tempapp.Options.push(temp);
                                }
                            }
                            tempdatabuild.Apps.push(tempapp);
                        }

                        // add the room data to the roomdataarray
                        databuild.push(tempdatabuild);
                    }
                }
                
                var passdata = {};
                passdata.data = databuild;
                $.ajax({
                    type: 'POST',
                    url: 'qQuote.aspx/createQuoteFile',
                    data: JSON.stringify(passdata),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    async: false,
                    success: function (msg1) {
                        // will receive message
                        if (msg1.d != 'false') {
                            $('#BathroomContainer').fadeOut(100);
                            $('#BedroomContainer').fadeOut(100);
                            $('#KitchenContainer').fadeOut(100);
                            $('#DiningRoomContainer').fadeOut(100);
                            $('#LivingRoomContainer').fadeOut(100);
                            $('#OfficeContainer').fadeOut(100);

                            $('#finish').hide();
                            //$('.typeselector').hide();
                            quotepath = msg1.d;
                            showSummary();
                        }
                        else
                            alert('Error while writing Quote data. Please retry the Quote.');
                        
                    },
                    error: function (error) {
                        alert("Error: Retrieving data failed.");
                    }
                });
            }

            function showSummary() {
                $("#quoteSummary").fadeIn(700);

                totalPrice = (totalTime / 60) * 25;

                var time = (totalTime / 60).toFixed(2);
                var timetext = " hour(s)";
                var finaltimetext = "";
                if (time < 1) {
                    time = Math.floor(time * 60);
                    timetext = " minutes";
                    finaltimetext = time + timetext;
                }
                else {
                    var num = Math.floor(time);
                    var decimal = time % num;
                    var minutes = Math.floor(decimal * 60);

                    finaltimetext += num + " hours";
                    finaltimetext += ", " + minutes + " minutes";
                }

                $("#loadercontainer").fadeOut(500); // hide loader

                if (propertyName != "")
                    $("#housename").find('h2').html(propertyName);
                else
                    $("#housename").find('h2').html("(Default)");

                $("#totaltime").find('h2').html(finaltimetext);
                $("#totalprice").find('h2').html((totalPrice).toFixed(2) + " CAD");
            }

            // for navigating
            var currentroomlocation;
            var nextroomlocation;

            // for multiple rooms
            var bathroomNames;
            var bedroomNames;

            var bathroomInstances;


            $("#begin").click(function (e) {

            });

            $("input[class^='slideoutbtn']").click(function () {
                $container.masonry();

                // find this button's siblings and remove them.
                var par = $(this).parent();

                var ul = par.children('ul');

                var li = ul.children('li');

                // hide all non-selected items
                $(li).children('div[class="icheckbox_line-orange"]').each(function () {
                    $(this).iCheck('disable');
                });

                // disable all selected items
                $(li).children('div[class="icheckbox_line-orange checked"]').each(function () {
                    var g = $(this).find('*');
                    g.iCheck('disable');
                });

                // remove non-selected sub options (radio)
                $(li).children('div[id^="inner"]').each(function () {
                    $(this).children('div[class="iradio_line-blue"]').each(function () {
                        $(this).iCheck('disable');
                    });
                });

                // disable selected radios
                $(li).children('div[id^="inner"]').each(function () {
                    $(this).children('div[class="iradio_line-blue checked"]').each(function () {
                        var a = $(this).find('*');
                        a.iCheck('disable');
                    });
                });
                
            });

            function appendToSidebar(header, data) {
                if (data == "" || data == "Select..." || data == null)
                    data = "N/A";
                if (data.length > 17) {
                    data = data.substr(0, 13);
                    data += "...";
                }
                $(".sidebar table").append("<tr><td class='header'>" + header + "</td></tr><tr><td class='data'>" + data + "</td></tr>");
            }            

            function setChecks2() {

                $('.lineCheck').each(function () {
                    var self = $(this),
                      label = self.next(),
                      label_text = label.text();

                    label.remove();
                    self.iCheck({
                        checkboxClass: 'icheckbox_line-orange',
                        insert: '<div class="icheck_line-icon"></div><span class="chk' + label_text + '">' + label_text + '</span>'
                    });


                    // whenever a checkbox is clicked, add the id to the respective array
                    self.on('ifChecked', function (event) {
                    });
                    self.on('ifUnchecked', function (event) {
                    });
                        /*
                        // add a class to the parent to make it available for saving to db (room)
                        $(this).closest('.roomMain').addClass('optionsSelected'); console.log($(this).closest('.roomMain').attr('class'));

                        // add a class to the box parent to make it available for saving to db (app)
                        $(this).closest('.box').addClass('optionsSelected'); console.log($(this).closest('.box').attr('class'));

                        if ($(this).hasClass('popupcheck')) {
                            //if (!$(this).hasClass('lineConflict')) {
                            $(this).parent().find('ins').hover(
                                function () { $(this).parent().parent().find('div.notapplied').show(); },
                                function () { $(this).parent().parent().find('div.notapplied').hide(); }
                            );

                            $(this).parent().parent().find('.popupapplybtn').hover(
                                function () { $(this).show(); },
                                function () { $(this).hide(); }
                            );
                            $(this).parent().parent().find('.popupunapplybtn').hover(
                                function () { $(this).show(); },
                                function () { $(this).hide(); }
                            );

                            $(this).parent().parent().find('.popupunapplybtn').click(
                                function () {
                                    applyOptionToAllRooms(self);
                                    $(this).hide();
                                    $(this).parent().find('.popupunapplybtn').removeClass('notapplied');
                                    $(this).parent().find('.popupapplybtn').addClass('notapplied');
                                }
                             );
                            $(this).parent().parent().find('.popupapplybtn').click(
                                function () {
                                    applyOptionToAllRooms(self);
                                    $(this).hide();
                                    $(this).parent().find('.popupapplybtn').removeClass('notapplied');
                                    $(this).parent().find('.popupunapplybtn').addClass('notapplied');
                                }
                             );
                        }

                        processCheckbox(self, 'checked');
                    });



                    // whenever a checkbox is unclicked, remove the id from the respective array
                    self.on('ifUnchecked', function (event) {

                        if ($(this).hasClass('popupcheck')) {

                            if ($(this).parent().parent().find('.popupapplybtn').is(":visible"))
                                $(this).parent().parent().find('.popupapplybtn').hide();
                            if ($(this).parent().parent().find('.popupunapplybtn').is(":visible"))
                                $(this).parent().parent().find('.popupunapplybtn').hide();


                            $(this).parent().find('ins').unbind('mouseenter mouseleave');
                            $(this).parent().parent().find('.popupapplybtn').unbind('mouseenter mouseleave');
                            $(this).parent().parent().find('.popupapplybtn').unbind('click');

                            $(this).parent().parent().find('.popupunapplybtn').unbind('mouseenter mouseleave');
                            $(this).parent().parent().find('.popupunapplybtn').unbind('click');

                            $(this).parent().parent().find('.popupunapplybtn').removeClass('notapplied');
                            $(this).parent().parent().find('.popupapplybtn').removeClass('notapplied');
                            $(this).parent().parent().find('.popupapplybtn').addClass('notapplied');
                        }

                        processCheckbox(self, 'unchecked');

                        // just in case this option has been added to the WHICHOPTIONSTOAPPLY,
                        // remove it from there
                        self.parent().removeClass('checked');

                        applyOptionToAllRooms(self);

                    });

                    // if this checkbox item has multiple sub options, add a title attribute,
                    // and add a tooltip
                    if ($(this).hasClass('lineConflict')) {
                        //$(this).parent().find('ins').attr("title", "This item has multiple sub-options.<br/>Click on it to view the sub-options.");
                        //$(this).parent().find('ins').tipTip({ delay: 60, defaultPosition: "bottom", fadeOut: 50 });
                    }*/

                });
            }

            $("#fill").click(function () {
                html2canvas(document.getElementById('top'), {
                    onrendered: function (canvas) {
                        $('body').css('overflow', 'auto');
                        document.body.appendChild(canvas);
                    }
                });
            });

            $("#read").click(function () {
                $.ajax({
                    type: 'POST',
                    url: 'qQuote.aspx/read',
                    data: '{}',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    async: true,
                    success: function (msg1) {
                        // will receive room
                        console.log(msg1.d);
                        $("#out").html(msg1.d);
                    },
                    error: function (error) {
                        alert("Error: Retrieving data failed.");
                    }
                });
            });
            $('#btn123').atlasTooltip({ pos: 'bottom' });
            $('#btn123').atlasTooltip({ pos: 'right' });
            $('#btn123').atlasTooltip({ pos: 'top' });
            $('#btn123').atlasTooltip({ pos: 'left' });

            $('#btn111').atlasTooltip({ pos: 'right', contents: '<strong>Be strong!</strong>' });
        });

    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div id="rtqoutercont">
      <!--  <div class="navButton">
            MENU
        </div>-->
        
        <div id="loadercontainer">
            <!--<img src="../Styles/img/image.gif" /> 
            <img src="../Styles/img/84.gif" />--><img src="../Styles/img/477.gif" />
        </div>

                
        <div id="top" class="topBar">
            <div class="topBarDiv">
                <h1>REAL-TIME QUOTE SYSTEM</h1>
                <h4>by The Home Cleaning Team</h4>
               <!-- <input id="btn1" type="button" value="button" />-->
         <!--   <nav>
                <ul>
                    <li>Back to the Main Site</li>
                    <li>Restart RTQ</li>
                </ul>
            </nav>-->
                </div>
        </div>


            <div id="intro" class="contentContainer">
                <h1 class="introH1"><span>Welcome to the</span> Real-Time Quote System</h1>
                <div><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget ligula dolor. Ut nunc sapien, mattis quis vehicula ac, venenatis ut lorem.
                    Aenean laoreet elit sit amet lectus gravida porta. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nulla volutpat quam lobortis
                    tortor sollicitudin sollicitudin. Praesent porta neque pretium tortor faucibus egestas. In ac sem sit amet enim hendrerit malesuada. </p></div>           

                    <p>You can get started with your quote by clicking on Begin.</p>
                    <input type="button" value="Begin Quote" id="startQuote" class="mainBtn" />
                <div id="out"></div>

                <div id="btn123" style="height:65px; width:200px; background-color:#c0e6ff">Test</div>

                <input type="button" value="Hover over me!" id="btn111" />
            </div>
         <!-- 
            <ul id="cont" style="width:300px">
                <li><span>ite34563464 36346436y34</span>
                    <ul>
                        <li><span>subitem11</span>
                            <ul>
                                <li class="chk"><span>subitem111</span>
                                    <ul>
                                        <li class="chk"><span>subitem112</span></li>
                                        <li><span>subitem112</span></li>
                                    </ul>
                                </li>
                                <li><span>subitem112</span></li>
                            </ul>
                        </li>
                        <li class="chk" data-optionid="test"><span>subitem12</span></li>
                    </ul>
                </li>
                <li><span>item2</span>
                    <ul class="isRadioList">
                        <li class="chk"><span>subitem21</span></li>
                        <li><span>subitem22</span></li>
                        <li><span>subitem23</span></li>
                    </ul>
                </li>
                <li class="chk" data-optionid="1"><span>item3</span></li>
            </ul>

            <ul id="cont2" class="isRadioList" style="width:300px">
                <li><span>item1</span>
                </li>
                <li><span>item2</span>
                </li>
                <li class="chk"><span>item3</span></li>
            </ul>

            <input type="button" id="ck" value="get checked text" />
            <input type="button" id="ck2" value="get checked data" />
            <input type="button" id="ckall" value="check all" />
            <input type="button" id="unckall" value="uncheck all" />
            <input type="button" id="toggle" value="toggle 0" />
            <input type="button" id="destroy" value="destroy" />
            <input type="button" id="init" value="init" />
            <input type="button" id="checkbyclass" value="checkbyclass" />
            <input type="button" id="expand" value="expand all" />
            <input type="button" id="setidentifier" value="set data identifier" />
        

        <div style="width:200px; position:absolute; top:140px; left:2px; padding:5px; background-color:#c0e6ff; border-radius:3px;" id="output">
            <p>Checked Items:</p>
        </div>
       
            -->

        <div id="nextroom"></div>
        <div id="finish">Finish Quote!</div>

        <div id="propertyquestions" class="propertyquestionsclass">
            
          <div class="propertyquestioninner">
            <div class="propertyquestionpart">
                <h3 class="prop">Questions about your Property</h3>
                <div class="propertydesc grid-whole equalize">
                    <ul id="ulpropertyinfo">
                        <li class="grid-third s-grid-whole padded">
                            <div class="propertydiv padded-inner content-box box">
                                <h1>Name your property</h1>
                                <h4>(pick any nickname, to identify the property i.e. "Jacob's House" or "135 King St")</h4>
                                <div style="height:auto; width:auto"><input id="name" type="text" class="ttextbox" /></div>
     
                            </div>
                        </li>
                        <li class="grid-third s-grid-whole padded">
                            <div class="propertydiv padded-inner content-box box">
                                <h1>What's the type of your property?</h1>
                                        <select id="housetype">
                                            <option value="1">Apartment</option>
                                            <option value="2">Condominium</option>
                                            <option value="3">Duplex</option>
                                            <option value="4">Semi-detached</option>
                                            <option value="5">Fully Detached</option>
                                            <option value="6">Townhouse</option>
                                        </select>
                            </div>
                        </li>
                        <li class="grid-third s-grid-whole padded">
                            <div class="propertydiv padded-inner content-box box">
                                <h1>What's the square footage of your property?</h1>
                                        <select id="area">
                                            <option value="1"><649 ft</option>
                                            <option value="2">650-999 ft</option>
                                            <option value="3">1000-1499 ft</option>
                                            <option value="4">1500-1999 ft</option>
                                            <option value="5">2000-2499 ft</option>
                                            <option value="6">2500-2999 ft</option>
                                            <option value="7">3000+ ft</option>
                                        </select>
                            </div>
                        </li>
                        <li class="grid-third s-grid-whole padded">
                            <div class="propertydiv padded-inner content-box box">
                                <h1>Do you have any pets?</h1>
                                        <select id="pets">
                                            <option value="None">Select...</option>
                                            <option value="Dog/s">Dog/s</option>
                                            <option value="Cat/s">Cat/s</option>
                                        </select>
                            </div>
                        </li>
                    </ul>
                </div>
                <input type="button" id="gotoservicequestions" class="mainBtn" value="Proceed to Service Questions" /> 
                <br />
                <br />
            </div>
            <div class="servicequestionpart">
                <h3 class="prop">Questions about the Service</h3>
                <div class="propertydesc grid-whole equalize">
                    <ul class="ulserviceinfo">
                        <li class="grid-half s-grid-whole padded">
                            <div class="propertydiv padded-inner content-box box">
                                <h1>How soon do you need the service?</h1>
                                <h4>(this is a range so that we can determine where to assign this job)</h4>
                                <select id="daterange">
                                    <option>Just shopping around</option>
                                    <option>Next 48 hours</option>
                                    <option>This week</option>
                                    <option>Next two weeks</option>
                                    <option>Next month</option>
                                
                                </select>
                            </div>
                        </li>
                        <li class="grid-half s-grid-whole padded">
                            <div class="propertydiv padded-inner content-box box">
                                <h1>What type of cleaning are you looking for?</h1>
                                <h4>(you can specify every detail of the service later on)</h4>
                                <select id="cleaningtype">
                                    <option value="1">Routine Cleaning</option>
                                    <option value="2">Deep Cleaning</option>
                                    <option value="3">Move-in & Move-out Cleaning</option>
                                    <option value="4">Emergency Cleaning</option>
                                    <option value="5">Post-renovation Cleaning</option>
                                    <option value="6">Rental Turnover Cleaning</option>
                                </select>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
          
              <input type="button" id="end" class="mainBtn" value="Proceed to Quote Details" /> 
                <br />
                <br />
          </div>

        </div>

        <!-- container for the sidebar content -->
        <div class="sidebar">
            <table>
            </table>
        </div>


        <!-- container for selecting the type of quote the user can make -->
        <div class="quotetype">
            <h3>What type of Real-Time Quote<br />do you wish to create?</h3>
            <ul>
                <li id="qquote" class="tooltipcontainer">Quick Quote
                    <div class="tooltip">
                        <h3>The Easy Quick Quote</h3>
                        <p>It is the faster way of creating a Real-Time Quote (RTQ).
                           If you're in a hurry and need to create a basic quote depending
                            on the <span>Type of Cleaning</span> on the side bar,
                            the basic options will be filled out for you and you're good to go.<br />
                            Of course, you have the ability to change any of the options you want.
                        </p>
                    </div>
                </li>
                <li id="deepquote" class="tooltipcontainer">Deep Cleaning Quote
                    <div class="tooltip">
                        <h3>The Detailed Deep Cleaning Quote</h3>
                        <p>It is the more detailed way of creating a Real-Time Quote (RTQ).
                           Depending on the <span>Type of Cleaning</span> on the side bar,
                            the basic options and the applicable deep cleaning options will be filled out for you and you're good to go.<br />
                            Of course, you have the ability to change any of the options you want.
                        </p>
                    </div>
                </li>
            </ul>

        </div>
                
        <!-- Container for messages before first room -->
        <div id="disclaimer" class="tips">
                <p>Since you have selected <strong class="cleaningtypespan"></strong>, options usually included in<br />
                    <strong class="cleaningtypespan"></strong> for <strong class="propertytypespan"></strong> properties will
                    be automatically selected.<br />
                If Deep Cleaning is required for a room, for example the bathroom, you can upgrade a room's options from 
                    Routine to Deep Cleaning when prompted! Light dusting options automatically change to detailed
                    scrubbing options.<br />
                You have the ability to edit, add and remove all options as you see fit!
                <br />
                <br/>Go ahead and start the quote!<br /><input type="button" id="startquote" class="ok2" value="Go to First Room!" /><br/>
        </div>

        <div class="bigprompt">
            <p>We have a bathroom cleaning system that truly deep cleans your washroom.<br />
               We remove the ceiling exhaust fan and wash it and replace it.<br />
                We wash and sanitize the door frame and door and door handles,<br />
                We wash all the window frames, Glass and Blinds,<br />
                The shower is scrubbed from Top to bottom each tile and the grout is washed and sanitized.<br />
                We scrub and sanitize the tub, faucets and knobs.<br />
                We clean inside the vanity and inside the medicine cabinet,<br />
                everything comes out we wash and sanitize the shelves, doors on both sides,<br />
                knobs and hardware and everything gets put back! We also wash all the baseboards and sweep and<br />
                mop the floor in addition to the sink, counters and toilet being cleaned inside and out!</p>
            <div class="tooltipcontainer" style="display:inline-block"><input type="button" class="ok2" value="Click Here" /><div class="tooltip">Ctertreterter tretret retg</div></div>
            <div class="tooltipcontainer" style="display:inline-block"><input type="button" class="ok2" value="Click Here" /><div class="tooltip">Click!tee rer54365475456 56546t htrhrt trhrtyrt y45 7y4 hft fth fh ewtewt erterter ter tertreterter tretret retg</div></div>
            
        </div>
                
        <!-- Containers for the dynamic room data -->
        <div id="BathroomContainer" style=""></div>
        <div id="BedroomContainer" style=""></div>
        <div id="KitchenContainer" style=""></div>
        <div id="DiningRoomContainer" style=""></div>
        <div id="LivingRoomContainer" style=""></div>
        <div id="OfficeContainer" style=""></div>


        <div id="quoteSummary" class="summaryDiv" style="display:none">
                <h3>Congratulations! You've just made a RTQ!</h3>
                
                <div id="housename" class="summaryInnerDiv">
                    <h5>Property Name:</h5>
                    <h2></h2>
                </div>

                <div id="totaltime" class="summaryInnerDiv">
                    <h5>Total Time:</h5>
                    <h2></h2>
                </div>

                <div id="totalprice" class="summaryInnerDiv">
                    <h5>Total Price:</h5>
                    <h2></h2>
                </div>

                <div id="emailentry" class="enterEmailDiv">
                    <p>To view the complete detailed copy of your quote, and in order to be able<br />
                        to book this job, introduce yourself to us and we will get this ball rolling!<br />
                        To start, please enter an email address to receive the complete copy of your RTQ: 
                    </p>
                    <input id="email" class="ttextbox" type="text" /><br/>
                    <input id="confirmquote" type="button" class="beginBtn" value="Confirm" onclick="sendEmail();" />
                </div>
        </div>


    </div>


    <div id="numBathrooms" class="numpick">
       <!-- <div class="bClose">x</div>-->
        <br />
        <h3>How many BATHROOMS need cleaning?</h3>

        <ul class="numList">
            <li class="roomnumselect"><div class="alignDiv">1</div><div class="DivHelper"></div></li>
            <li class="roomnumselect"><div class="alignDiv">2</div><div class="DivHelper"></div></li>
            <li class="roomnumselect"><div class="alignDiv">3</div><div class="DivHelper"></div></li>
            <li class="roomnumselect"><div class="alignDiv">4</div><div class="DivHelper"></div></li>
        </ul>

        <div class="revealTexts"></div>

        <input id="closeBath" class="beginBtn" type="button" value="Done" />

    </div>
    <div id="numBedrooms" class="numpick">
       <!-- <div class="bClose">x</div>-->
        <br />
        <h3>How many BEDROOMS need cleaning?</h3>

        <ul class="numList">
            <li class="roomnumselect"><div class="alignDiv">1</div><div class="DivHelper"></div></li>
            <li class="roomnumselect"><div class="alignDiv">2</div><div class="DivHelper"></div></li>
            <li class="roomnumselect"><div class="alignDiv">3</div><div class="DivHelper"></div></li>
            <li class="roomnumselect"><div class="alignDiv">4</div><div class="DivHelper"></div></li>
        </ul>

        <div class="revealTexts"></div>

        <input id="closeBed" class="beginBtn" type="button" value="Done" />

    </div>

    <div class="notification">
        <h4>Notification</h4>
        <p>Options have been applied!</p>
    </div>

    
    <div class="popupapply">
        <h2>Information:</h2>
        <p>Options in <span>Ceilings & Walls</span>, <span>Floors</span> & <span>Windows & Blinds</span> can be applicable to all rooms.
        You can save time in your quote by selecting the option here now and applying it to the rest of the rooms.<br />
        Click on the White buttons that appear once you hover on an option in these categories.</p>
        <div class="tutorial">
            <div class="pageTransContainer" id="outer">
                <div class="pageTransItem"><p>Initially, hovering over an option in these categories will highlight it.</p><img src="../Styles/img/hoveroption.png" /></div>
                <div class="pageTransItem"><p>Clicking on an option will check the option. Clicking it again will uncheck it.</p><img src="../Styles/img/clickoption.png" /></div>
                <div class="pageTransItem"><p>TIP: If you hover away from the options of one of the categories above, you can hover over again...</p><img src="../Styles/img/hoveraway.png" /></div>
                <div class="pageTransItem"><p>...to show the Apply button. This will apply this option to all other remaining rooms.</p><img src="../Styles/img/hoverapplybutton.png" /></div>
                <div class="pageTransItem"><p>If you choose to apply an option to all remaining rooms, you can also cancel it just by clicking the replacing Unapply button.</p><img src="../Styles/img/unapplybuttonclick.png" /></div>
            
                <div class="pageTransItem"><p>For options that have multiple sub-options, it works a little differently. You can hover over an option.</p><img src="../Styles/img/hoverconflictoption.png" /></div>
                <div class="pageTransItem"><p>Clicking on these options will reveal a set of sub-options. You can select one of these sub-options to close the black window.</p><img src="../Styles/img/hoverradio.png" /></div>
                <div class="pageTransItem"><p>After selecting one of the sub-options, it will replace the option they are under.</p><img src="../Styles/img/clickradio.png" /></div>
                <div class="pageTransItem"><p>Then you can choose to apply or unapply this option!</p><img src="../Styles/img/radioconflicthover.png" /></div>

                <div class="pageTransItem"><p>Meanwhile, the blue button at the bottom will apply ALL options you select into the multiple rooms for <span>Bathrooms</span> and <span>Bedrooms</span></p><img src="../Styles/img/applytoall.png" /></div>

                <div class="pageTransItem"><p>Note that unchecking an option after applying it will simply not apply it. However if you applied any option from the first room, you can change any other options in the next rooms.</p></div>
            </div>
        </div>
        <br />
        <input type="button" id="closeapply" value="Close"/>
    </div>
    

    <div id="regpop" class="popup">
        <h3>Thank you for using The HomeCleaningTeam's RealTimeQuote System!</h3><br />
       
        <div id="quoteBox">Please wait a few seconds while we send a detailed quote to you...<br />
            <img id="quoteloader" src="../Styles/img/239.gif" /></div><br />

        <div id="regbox">
             While we have you, why not take the time to register now to proceed with<br />
            booking your quote?<br />
            It's gonna be very quick, we promise.<br />
            (Cancelling will remove your quote from our records)<br />

            <input type="button" id="reg" class="beginBtn" value="Proceed" onclick="proceedReg();" />
            <input type="button" id="cancel" class="beginBtn" value="Cancel" onclick="cancelReg();"/>
        </div>
    </div>

    <div id="invoiceDiv">
    </div>


    <script>
        // some functions need to be here because some DOM elements are added dynamically via
        // AJAX requests.

        var flag = "false";
        var quote = "";

        function showPopup(container) {
            $('#' + container).bPopup({
                closeClass: 'closeAdd',
                modalClose: false,
                opacity: 0.6,
                positionStyle: 'fixed', //'fixed' or 'absolute'
                modalColor: '#337abe',
                transition: 'slideIn',
                appendTo: 'form'
            });
        }


        // go to the next room; accessed by the Next Room button
        function goNextRoom(nextroom) {
            // decide which room to go if 
            switch (nextroom) {
                case "Bathroom":
                    $("#loadercontainer").show();
                    setTimeout(function () { createRooms(nextroom, numbath, "Bedroom") }, 1100);
                    break;
                case "Bedroom":
                    $("#loadercontainer").show();
                    $("#BathroomContainer").fadeOut(500, function () {
                        //$("#BedroomContainer").delay(1000).fadeIn(500);
                        setTimeout(function () { createRooms(nextroom, numbed, "Kitchen") }, 1100);
                    });
                    
                    break;
                case "Kitchen":
                    $("#loadercontainer").show();
                    $("#BedroomContainer").fadeOut(500, function () {
                        //$("#KitchenContainer").delay(1000).fadeIn(500);
                        setTimeout(function () { createRooms(nextroom, 1, "Dining Room")}, 1100);
                    });
                    
                    kitchenservice = new Array();
                    kitchenradios = new Array();
                    break;
                case "Dining Room":
                    $("#loadercontainer").show();
                    $("#KitchenContainer").fadeOut(500, function () {
                        //$("#DiningRoomContainer").fadeIn(500);
                        setTimeout(function () { createRooms(nextroom, 1, "Living Room")}, 1100);
                    });
                    
                    diningroomservice = new Array();
                    diningroomradios = new Array();
                    break;
                case "Living Room":
                    $("#loadercontainer").show();
                    $("#DiningRoomContainer").fadeOut(500, function () {
                        //$("#LivingRoomContainer").fadeIn(500);
                        setTimeout(function () { createRooms(nextroom, 1, "Office")}, 1100);
                    });
                    
                    livingroomservice = new Array();
                    livingroomradios = new Array();
                    break;
                case "Office":
                    $("#loadercontainer").show();
                    $("#LivingRoomContainer").fadeOut(500, function () {
                        //$("#OfficeContainer").fadeIn(500);
                        setTimeout(function () { createRooms(nextroom, 1, "")}, 1100);
                    });
                    
                    officeservice = new Array();
                    officeradios = new Array();
                    
                    break;
                default:    // this will finally show the quote summary
                    createSummary();
                    break;
            }
        }
        
        // close the number of bathrooms selection
        $("#closeBath").click(function () {

            // once the Done button for this room is clicked,
            // initialize the options array

            // if the number of bathrooms selected were more than 1,
            // declare a 2d array. otherwise, declare a normal array
            if (numbath > 1) {
                bathroomservice = new Array(numbath);
                for (var i = 0; i < numbath; i++) bathroomservice[i] = new Array();
                bathroomradios = new Array(numbath);
                for (var i = 0; i < numbath; i++) bathroomradios[i] = new Array();
            }
            else {
                bathroomservice = new Array();
                bathroomradios = new Array();
            }

            // at this point, the array will have 4 arrays. each array
            // will represent each room clone, and the option ids will
            // be added as the user clicks each option.

            bClose($(this).parent());
            goNextRoom("Bathroom");

            $(".popupapply").delay(1000).fadeIn(300);

            var divs = $('.popupapply').find('div');

        });


        // close the number of bathrooms selection
        $("#closeBed").click(function () {

            if (numbed > 1) {
                bedroomservice = new Array(numbed);
                for (var i = 0; i < numbed; i++) bedroomservice[i] = new Array();
                bedroomradios = new Array(numbed);
                for (var i = 0; i < numbed; i++) bedroomradios[i] = new Array();

                // set the number of selected items for ironing
                selectednumofitems = new Array();   // 1 value for each room (element in array)
            }
            else {
                bedroomservice = new Array();
                bedroomradios = new Array();
                selectednumofitems = 0;
            }

            bClose($(this).parent());
            goNextRoom("Bedroom");

        });
        
        // !!!!!!!!!!!!!!!!!!!!!!!!!
        // !! NOTE
        // !!!!!!!!!!!!!!!!!!!!!!!!!
        // there will be a SKIP so that instead of choosing
        // the number of rooms for bath/bed, the user can skip
        // both if they want.

        // start the next popup question for number of bedrooms
        function finishBath(room) {
            $("#BathroomContainer").fadeOut();
            showPopup("numBedrooms");
        }


        $('#numBathrooms li.roomnumselect').click(function () {

            $(this).parent().find("li").removeClass("selectedNum");
            $(this).addClass("selectedNum");

            var numrooms = parseInt($(this).find('.alignDiv').text());

            $("#closeBath").removeAttr('disabled').css("opacity", 1);

            numbath = numrooms;
        });

        $('#numBedrooms li.roomnumselect').click(function () {

            $(this).parent().find("li").removeClass("selectedNum");
            $(this).addClass("selectedNum");

            var numrooms = parseInt($(this).find('.alignDiv').text());

            $("#closeBed").removeAttr('disabled').css("opacity", 1);

            numbed = numrooms;
        });


        // ajax call to dynamically create 1 or more rooms
        function createRooms(whichRoom, numroom, nextRoom) {

            var dataToSend = "MethodName=CreateRooms&NumRooms=" + numroom + "&WhichRoom=" + whichRoom + "&NextRoom=" + nextRoom;

            $.ajax({
                url: 'qQuote.aspx/createRooms',
                data: dataToSend,
                dataType: "text",
                async: true,
                cache: false,
                beforeSend: function () {

                },
                type: "POST",
                crossDomain: true,
                success: function (msg1, textStatus) {

                    $("#loadercontainer").fadeOut(500);

                    whichRoom = whichRoom.replace(" ", '');

                    $("#" + whichRoom + "Container").append(msg1);

                    // now set up all rooms returned 
                    setChecks();

                    $(".roomouter").atlasPageTrans({ backgroundColor: "#dcdcdc", navigationButtons: "double" });

                    $("#" + whichRoom + "Container").fadeIn(500);

                    $container = $("#" + whichRoom + "Container").find("div.roomMain");

                    $container.masonry({
                        itemSelector: '.grid-third',
                        hiddenStyle: { opacity: 0, transform: 'scale(0.001)' },
                        visibleStyle: { opacity: 1, transform: 'scale(1)' }
                    });

                    beginApply($container);

                    //delete $.fn.atlasPageTrans;
                    //$("#bathroomContainer").show();

                },
                error: function (msg2, textStatus, errorThrown) { alert("Error while retrieving rooms."); }
            });
        }

        function processRadio(element, state) {
            // get the array index
            var parentContainer = element.parent().parent().parent().parent().parent().parent().parent().parent().parent().parent(); //.attr('class');
            var arrayindex;
            var index;

            var classes = parentContainer.attr('class').split(" "); //separate classes

            var son = parentContainer.find('.roomMain');
            var whichArray = son.attr('id').replace("room", "");

            if (classes[1].indexOf('clone') == 0) {
                arrayindex = classes[1].replace(/\D/g, ''); // the second class is "clone"
            }

            switch (whichArray) {

                case "Bathroom":
                    if (classes[1].indexOf('clone') == 0) {
                        if (state == 'checked') {
                            bathroomradios[arrayindex].push(element);
                        }
                        else {
                            for (var i = 0; i < bathroomradios[arrayindex].length; i++) {
                                if (element.val() == bathroomradios[arrayindex][i].val()) {
                                    bathroomradios[arrayindex].splice(i, 1);
                                }
                            }
                        }
                    }
                    else {
                        if (state == 'checked')
                            bathroomradios.push(element);
                        else
                            for (var i = 0; i < bathroomradios.length; i++)
                                if (element.attr('value') == $(bathroomradios[i]).val()) {
                                    bathroomradios.splice(i, 1);
                                }
                    }
                    break;


                case "Bedroom":
                    if (classes[1].indexOf('clone') == 0)
                        if (state == 'checked')
                            bedroomradios[arrayindex].push(element);
                        else {
                            for (var i = 0; i < bedroomradios[arrayindex].length; i++)
                                if (element.attr('value') == bedroomradios[arrayindex][i].attr('value')) {
                                    bedroomradios[arrayindex].splice(i, 1);
                                }
                        }
                    else {
                        if (state == 'checked')
                            bedroomradios.push(element);
                        else
                            for (var i = 0; i < bedroomradios.length; i++)
                                if (element.attr('value') == bedroomradios[i].attr('value')) {
                                    bedroomradios.splice(i, 1);
                                }
                    }
                    break;


                case "Kitchen":
                    if (state == 'checked')
                        kitchenradios.push(element);
                    else
                        for (var i = 0; i < kitchenradios.length; i++)
                            if (element.attr('value') == kitchenradios[i].attr('value')) {
                                kitchenradios.splice(i, 1);
                            }
                    break;


                case "DiningRoom":
                    if (state == 'checked')
                        diningroomradios.push(element);
                    else
                        for (var i = 0; i < diningroomradios.length; i++)
                            if (element.attr('value') == diningroomradios[i].attr('value')) {
                                diningroomradios.splice(i, 1);
                            }
                    break;


                case "LivingRoom":
                    if (state == 'checked')
                        livingroomradios.push(element);
                    else
                        for (var i = 0; i < livingroomradios.length; i++)
                            if (element.attr('value') == livingroomradios[i].attr('value')) {
                                livingroomradios.splice(i, 1);
                            }
                    break;


                case "Office":
                    if (state == 'checked')
                        officeradios.push(element);
                    else
                        for (var i = 0; i < officeradios.length; i++)
                            if (element.attr('value') == officeradios[i].attr('value')) {
                                officeradios.splice(i, 1);
                            }
                    break;

            }
        }


        function processCheckbox(element, state) {

            // get the array index
            var parentContainer = element.parent().parent().parent().parent().parent().parent().parent().parent(); //.attr('class');
            var arrayindex;
            var index;

            var classes = parentContainer.attr('class').split(" "); //separate classes

            // get the roomMain container, then get its ID which has this format
            // e.g. "roomBathroom", "roomOffice"
            // this will enable me to get exactly which room you're at, and which
            // array to push the element into
            var son = parentContainer.find('.roomMain');
            var whichArray = son.attr('id').replace("room", "");

            // if the room this checkbox belongs to belongs to a multi-clone
            // instance, select the array index depending on the container's clone #
            if (classes[1].indexOf('clone') == 0) {
                arrayindex = classes[1].replace(/\D/g, ''); // the second class is "clone"
            }

            switch (whichArray) {


                case "Bathroom":
                    if (classes[1].indexOf('clone') == 0) {
                        if (state == 'checked')
                            bathroomservice[arrayindex].push(element);
                        else {
                            for (var i = 0; i < bathroomservice[arrayindex].length; i++)
                                if (element.attr('id') == bathroomservice[arrayindex][i].attr('id')) {
                                    bathroomservice[arrayindex].splice(i, 1);
                                }
                        }
                    }
                    else {
                        if (state == 'checked')
                            bathroomservice.push(element);
                        else
                            for (var i = 0; i < bathroomservice.length; i++)
                                if (element.attr('id') == bathroomservice[i].attr('id')) {
                                    bathroomservice.splice(i, 1);
                                }
                    }
                    break;


                case "Bedroom":
                    if (classes[1].indexOf('clone') == 0) {
                        if (state == 'checked')
                            bedroomservice[arrayindex].push(element);
                        else
                            for (var i = 0; i < bedroomservice[arrayindex].length; i++)
                                if (element.attr('id') == bedroomservice[arrayindex][i].attr('id')) {
                                    bedroomservice[arrayindex].splice(i, 1);
                                }
                    }
                    else {
                        if (state == 'checked')
                            bedroomservice.push(element);
                        else
                            for (var i = 0; i < bedroomservice.length; i++)
                                if (element.attr('id') == bedroomservice[i].attr('id')) {
                                    bedroomservice.splice(i, 1);
                                }
                    }
                    break;


                case "Kitchen":
                    if (state == 'checked')
                        kitchenservice.push(element);
                    else
                        for (var i = 0; i < kitchenservice.length; i++)
                            if (element.attr('id') == kitchenservice[i].attr('id')) {
                                kitchenservice.splice(i, 1);
                            }
                    break;


                case "DiningRoom":
                    if (state == 'checked')
                        diningroomservice.push(element);
                    else
                        for (var i = 0; i < diningroomservice.length; i++)
                            if (element.attr('id') == diningroomservice[i].attr('id')) {
                                diningroomservice.splice(i, 1);
                            }
                    break;


                case "LivingRoom":
                    if (state == 'checked')
                        livingroomservice.push(element);
                    else
                        for (var i = 0; i < livingroomservice.length; i++)
                            if (element.attr('id') == livingroomservice[i].attr('id')) {
                                livingroomservice.splice(i, 1);
                            }
                    break;


                case "Office":
                    if (state == 'checked')
                        officeservice.push(element);
                    else
                        for (var i = 0; i < officeservice.length; i++)
                            if (element.attr('id') == officeservice[i].attr('id')) {
                                officeservice.splice(i, 1);
                            }
                    break;

            }

            /*  if (classes[1].indexOf('clone') == 0)
                  alert(bathroomservice[arrayindex].length);
              else
                  alert(bathroomservice.length);*/
        }
        

        // apply events to checkboxes and radio buttons
        function setChecks() {
            $('.lineCheck').each(function () {
                var self = $(this),
                  label = self.next(),
                  label_text = label.text();

                label.remove();
                self.iCheck({
                    checkboxClass: 'icheckbox_line-orange',
                    insert: '<div class="icheck_line-icon"></div><span class="chk' + label_text + '">' + label_text + '</span>'
                });


                // whenever a checkbox is clicked, add the id to the respective array
                self.on('ifChecked', function (event) {

                    // add a class to the parent to make it available for saving to db (room)
                    $(this).closest('.roomMain').addClass('optionsSelected'); console.log($(this).closest('.roomMain').attr('class'));

                    // add a class to the box parent to make it available for saving to db (app)
                    $(this).closest('.box').addClass('optionsSelected'); console.log($(this).closest('.box').attr('class'));

                    if ($(this).hasClass('popupcheck')) {
                        //if (!$(this).hasClass('lineConflict')) {
                        $(this).parent().find('ins').hover(
                            function () { $(this).parent().parent().find('div.notapplied').show(); },
                            function () { $(this).parent().parent().find('div.notapplied').hide(); }
                        );

                        $(this).parent().parent().find('.popupapplybtn').hover(
                            function () { $(this).show(); },
                            function () { $(this).hide(); }
                        );
                        $(this).parent().parent().find('.popupunapplybtn').hover(
                            function () { $(this).show(); },
                            function () { $(this).hide(); }
                        );

                        $(this).parent().parent().find('.popupunapplybtn').click(
                            function () {
                                applyOptionToAllRooms(self);
                                $(this).hide();
                                $(this).parent().find('.popupunapplybtn').removeClass('notapplied');
                                $(this).parent().find('.popupapplybtn').addClass('notapplied');
                            }
                         );
                        $(this).parent().parent().find('.popupapplybtn').click(
                            function () {
                                applyOptionToAllRooms(self);
                                $(this).hide();
                                $(this).parent().find('.popupapplybtn').removeClass('notapplied');
                                $(this).parent().find('.popupunapplybtn').addClass('notapplied');
                            }
                         );
                    }

                    processCheckbox(self, 'checked');
                });



                // whenever a checkbox is unclicked, remove the id from the respective array
                self.on('ifUnchecked', function (event) {

                    if ($(this).hasClass('popupcheck')) {

                        if ($(this).parent().parent().find('.popupapplybtn').is(":visible"))
                            $(this).parent().parent().find('.popupapplybtn').hide();
                        if ($(this).parent().parent().find('.popupunapplybtn').is(":visible"))
                            $(this).parent().parent().find('.popupunapplybtn').hide();


                        $(this).parent().find('ins').unbind('mouseenter mouseleave');
                        $(this).parent().parent().find('.popupapplybtn').unbind('mouseenter mouseleave');
                        $(this).parent().parent().find('.popupapplybtn').unbind('click');

                        $(this).parent().parent().find('.popupunapplybtn').unbind('mouseenter mouseleave');
                        $(this).parent().parent().find('.popupunapplybtn').unbind('click');

                        $(this).parent().parent().find('.popupunapplybtn').removeClass('notapplied');
                        $(this).parent().parent().find('.popupapplybtn').removeClass('notapplied');
                        $(this).parent().parent().find('.popupapplybtn').addClass('notapplied');
                    }

                    processCheckbox(self, 'unchecked');

                    // just in case this option has been added to the WHICHOPTIONSTOAPPLY,
                    // remove it from there
                    self.parent().removeClass('checked');

                    applyOptionToAllRooms(self);

                });

                // if this checkbox item has multiple sub options, add a title attribute,
                // and add a tooltip
                if ($(this).hasClass('lineConflict')) {
                    //$(this).parent().find('ins').attr("title", "This item has multiple sub-options.<br/>Click on it to view the sub-options.");
                    //$(this).parent().find('ins').tipTip({ delay: 60, defaultPosition: "bottom", fadeOut: 50 });
                }

            });

            $("#closeapply").click(function () {
                $(this).parent().fadeOut(100);
            });

            $('.lineRadioCheck').each(function () {
                var self = $(this),
                  label = self.next(),
                  label_text = label.text();

                label.remove();
                self.iCheck({
                    radioClass: 'iradio_line-blue',
                    insert: '<div class="icheck_line-icon"></div><span class="rad' + label_text + '">' + label_text + '</span>'
                });

                // set the click event for radio buttons (which is to remove the container)
                self.on('ifChecked', function (event) {

                    // store the checkbox (the one conflicted) related to this radio
                    var conflictCheck = self.parent().parent().parent().parent().find("input.lineCheck");

                    var siblingradios = self.parent().parent().parent().find('input');

                    // to have a radiobutton effect, remove all of the checked choices in this div, then
                    // re check the on actually clicked

                    $.each(siblingradios, function () {
                        processRadio($(this), 'unchecked');
                        //$(this).iCheck('uncheck');
                    });

                    // if the value of the clicked radio (blue) option is "", it's a "NO THANKS"
                    // which means deselect the current option and set the text of the checkbox
                    // to whatever it's value was before.
                    if (self.attr('value') != "") {

                        // get this radio's values
                        var v = $(this).parent().text();

                        console.log($(this).data("noteenabled"));

                        // if the option is laundry, it will have note enabled data
                        // which will insert a notes section to the invoice
                        if ($(this).data("noteenabled") != null) {
                            if ($(this).data("noteenabled") == "true")
                                noteenabled = true;
                        }

                        // fade out the container of this radio (and the radio as well)
                        $(this).parent().parent().parent().delay(100).fadeOut(400);
                        // set the values of the checkbox that triggers the container of this radio
                        conflictCheck.parent().find('span').html(v);
                        // check the checkbox if it isnt yet
                        conflictCheck.iCheck('check');
                        conflictCheck.attr('value', v);
                        processRadio(self, 'checked');
                    }
                    else {
                        self.parent().parent().parent().delay(100).fadeOut(400);
                        // set this checkbox's text with it's own value (because it doesn't have a number)
                        conflictCheck.parent().find('span').html(conflictCheck.data("optionname") + " - No, thanks.");
                        conflictCheck.iCheck('uncheck');
                        processRadio(self, 'unchecked');
                    }
                    $container.masonry();
                });

            });
            
            // for options that will require a specific value (show a textbox for the value entry)
            $(".variablevalue").on('ifClicked', function () {
                var parentContainer = $(this).parent().parent(); //.attr('class');

                // get this checkbox's id
                var thisId = $(this).attr('id');

                $(this).tipTip({ delay: 150, defaultPosition: "left" });

                // get this option's number
                thisId = thisId.replace(/\D/g, '');

                // get the div that contains the same id, and show / remove it
                var thisinner = parentContainer.find('div#valuebox' + thisId);

                // add options to the selectbox inside this div
                var selectbox = thisinner.find('select');

                for (var i = 0; i < numofitems; i++) {
                    selectbox.append("<option value='" + (i + 1) + "'>" + (i + 1) + "</option>");
                }

                if ($(thisinner).is(":hidden")) {

                    var parentpos = $(thisinner).parent().position();

                    $(thisinner).css({
                        top: parentpos.top - ($(thisinner).height() + 5),
                        left: parentpos.left - 15
                    });


                    $(thisinner).fadeIn();

                    //$(this).iCheck('check');
                } else {
                    /* $("div #inner" + thisId).slideUp();
                     var g = $("div #inner" + thisId).find('input');
                     g.iCheck('uncheck');
                     $(this).iCheck('uncheck');*/
                }

                $("input[id^='doneValuebox']").click(function () {

                    selectednumofitems = parseInt($(this).parent().find('select').val());
                    $(this).parent().fadeOut();
                    $(this).parent().parent().find('.lineCheck').iCheck('check');
                });

            });

            // if there is a conflicted checkbox, show a floating div where sub options are in
            $("input[id^='conflict']").on('ifClicked', function (event) {

                var parentContainer = $(this).parent().parent().parent().parent(); //.attr('class');

                // get this checkbox's id
                var thisId = $(this).attr('id');

                $(this).tipTip({ delay: 150, defaultPosition: "left" });

                // get this option's number
                thisId = thisId.replace(/\D/g, '');

                // get the div that contains the same id, and show / remove it
                var thisinner = parentContainer.find('div#inner' + thisId);

                if ($(thisinner).is(":hidden")) {

                    var parentpos = $(thisinner).parent().position();

                    $(thisinner).css({
                        top: parentpos.top - ($(thisinner).height() + 5),
                        left: parentpos.left - 17
                    });

                    $(thisinner).fadeIn();

                    //$(this).iCheck('check');
                } else {
                    /* $("div #inner" + thisId).slideUp();
                     var g = $("div #inner" + thisId).find('input');
                     g.iCheck('uncheck');
                     $(this).iCheck('uncheck');*/
                }
            });



        } // end setChecks()


        // this function enables me to track and check all rtq options that
        // the user clicked to apply to all rooms after the first one.
        // i will initialize 2 arrays and save 2 types of data like the
        // checkbox and the radio button.
        // a checkbox will have "Light fixtures"
        // a radio will have "Dust Light fixtures"

        function applyOptionToAllRooms(input) {

            var optionname; // store the option name to look for it later


            if (input.hasClass("lineCheck")) {
                // if this checkbox has sub options, get it's value instead of data
                // and save it into the radios array
                if (input.hasClass("lineConflict")) {
                    console.log(input.attr("value"));
                    optionname = input.data("optionname");
                    if (whichRadiosToApply != null) {

                        // there are 2 parts in saving a conflicted rtq option
                        // 1 - save the DATA attribute which contains this checkbox's name
                        // 2 - save the VALUE attribute which contains the radio button selected

                        // check if the checkbox's option name is already in the apply array
                        if (whichChecksToApply.indexOf(optionname.toLowerCase()) < 0 ) {
                            console.log("added check" + input.data("optionname"));
                            whichChecksToApply.push(optionname.toLowerCase());
                        }
                        else // otherwise remove
                            whichChecksToApply.splice(whichChecksToApply.indexOf(optionname.toLowerCase()), 1);

                        // 
                        if (whichRadiosToApply.indexOf(input.attr("value").toLowerCase()) < 0) {
                            console.log("added radio" + input.attr("value"));
                            whichRadiosToApply.push(input.attr("value").toLowerCase());
                        }
                        else
                            whichRadiosToApply.splice(whichRadiosToApply.indexOf(input.attr("value").toLowerCase()), 1);
                    }
                }
                else {
                    console.log(input.data("optionname"));
                    optionname = input.data("optionname").toLowerCase();
                    if (whichChecksToApply != null) {
                        if (whichChecksToApply.indexOf(optionname.toLowerCase()) < 0) {
                            console.log("added check" + optionname);
                            whichChecksToApply.push(optionname.toLowerCase());
                        }
                        else
                            whichChecksToApply.splice(whichChecksToApply.indexOf(optionname.toLowerCase()), 1);
                    }
                }
            }

        }

        // this will search and check all the options with the names in the whichchecks arrays.
        function beginApply(roomcontainer) {

            // must pass a Room name parameter to exclude other rooms every
            // call of beginApply (using selectors to select specific rooms to apply

                var checks = roomcontainer.find("input[type='checkbox'].lineCheck");
                var radios = roomcontainer.find("input[type='radio'].lineRadioCheck");

                $.each(checks, function () {
                    // after looking for all checkboxes
                    // loop through the array of option names to be applied
                    if ($(this).hasClass("lineConflict")) {
                        //if (whichRadiosToApply.indexOf($(this).data("optionname").toLowerCase()) > -1) {
                        //    console.log("checked radio " + $(this).data("optionname").toLowerCase());
                        //    $(this).iCheck('check');
                        //}
                        if ($(this).attr("value").toLowerCase() != null && typeof $(this).attr("value").toLowerCase() != "undefined")
                            if (whichChecksToApply.indexOf($(this).attr("value").toLowerCase()) > -1) {
                                console.log("checked checkbox " + $(this).attr("value").toLowerCase());
                                $(this).iCheck('check');
                            }
                    }
                    else
                        if ($(this).data("optionname").toLowerCase() != null && typeof $(this).data("optionname").toLowerCase() != "undefined")
                            if (whichChecksToApply.indexOf($(this).data("optionname").toLowerCase()) > -1)
                                $(this).iCheck('check');

                });
                $.each(radios, function () {
                    // after looking for all radio buttons
                    // loop through the array of option names to be applied
                    if ($(this).data("optionname").toLowerCase() != null && typeof $(this).data("optionname").toLowerCase() != "undefined")
                        if (whichRadiosToApply.indexOf($(this).data("optionname").toLowerCase()) > -1) {
                            console.log("checked radio " + $(this).data("optionname"));
                            $(this).iCheck('check');
                        }
                        
                });
            //}
        }


        // clone options selected into all rooms
        function cloneServicePattern(whichService) {

            // for sure this will be activated with multi-clone room

            // the structure looks like
            // BATHROOM SERVICE
            //      arr1        arr2        arr3        arr4
            //      chk1   >    chk1   >    chk1   >    chk1
            //      chk2   >    chk2   >    chk2   >    chk2

            // so each checkbox on arr1(room1) will be applied to all other
            // checkboxes in other instances of the bath/bedrooms.
            // the catch is that i need to look for the grandparents in order
            // to look for the other instances from the point of view of the checkbox
            // being clicked.

            // the bath/bedroomservice 2d arrays contain DOM elements and they all contain all
            // information including the grandparents, classes, values, plugins, etc.
            // this enables me to activate or deactivate checkboxes from the remaining
            // rooms through the Apply button.

            // NOTE the Apply button only exists in the first instance of a room.
            // this will always apply whatever is in the first room to the rest of the rooms.
            // The rest will be independent though so users can still change the other rooms'
            // selections even if the Apply button has already been clicked. Same with the first
            // room, they can change it however they want. Clicking on the Apply button will
            // clear whatever is in the rest of the rooms and apply what is on the first.

            if (whichService == "Bathroom") { // if this is a bathroom cloneset
                // loop through the cloned rooms (bath 1, bath 2, etc)
                for (var h = 0; h < bathroomservice.length; h++) {

                    if (bathroomservice[h][0] != null) {
                        // in the bathroom instance, use the first checkbox(in the array)
                        // to look for every checkbox's grandparent which is the pageTransItem container
                        var parentContainer = bathroomservice[h][0].parent().parent().parent().parent().parent().parent().parent().parent();

                        // loop through the rows of checkboxes inside 1 instance (array column)
                        for (var i = 0; i < bathroomservice[h].length; i++) // iterate first clone
                        {
                            // get the value of the current checkbox
                            var thisval = bathroomservice[h][i].attr('value');
                            // get the grandparent of the current checkbox, get the proceeding pageTransItem,
                            // then get the checkboxes inside the neighbor, then look through them
                            parentContainer.next().find('input[type="checkbox"].lineCheck').each(function () {
                                if ($(this).attr('value') == thisval)
                                    $(this).iCheck('check');
                            });
                        }
                        $(".notification").find('p').html("Options have been applied to the rest of the " + whichService + "s.");
                    }
                    else
                        $(".notification").find('p').html("Error: No options selected to be applied.");
                }

                for (var h = 0; h < bathroomradios.length; h++) {

                    if (bathroomradios[h].length > 0) {

                        for (var i = 0; i < bathroomradios[h].length; i++) {

                            if (bathroomradios[h][i] != null) {
                                var listContainer = bathroomradios[h][i].parent().parent().parent().parent();

                                // get the checkbox
                                var thischeckbox = listContainer.find('input.lineCheck');

                                // get this checkbox's id
                                var thisId = thischeckbox.attr('id');
                                // get this option's number
                                thisId = thisId.replace(/\D/g, '');

                                // i can now use the checkbox id to find the inner div that contains the same
                                // id
                                var pageInnerContainer = bathroomradios[h][i].parent().parent().parent().parent().parent().parent().parent().parent().parent().parent();

                                var thisinner = pageInnerContainer.next().find('div#inner' + thisId);

                                var thisval = bathroomradios[h][i].attr('value');
                                thisinner.find('input[type="radio"].lineRadioCheck').each(function () {
                                    if ($(this).attr('value') == thisval) {
                                        $(this).iCheck('check');
                                    }
                                });
                            }
                        }
                    }
                }
            }
            else {  // if this is a bedroom cloneset
                for (var h = 0; h < bedroomservice.length; h++) {

                    if (bedroomservice[h][0] != null) {
                        // get the grandparent which is the pageTransItem container
                        var parentContainer = bedroomservice[h][0].parent().parent().parent().parent().parent().parent().parent().parent();

                        for (var i = 0; i < bedroomservice[h].length; i++) // iterate first clone
                        {
                            var thisval = bedroomservice[h][i].attr('value');
                            parentContainer.next().find('input[type="checkbox"].lineCheck').each(function () {
                                if ($(this).attr('value') == thisval)
                                    $(this).iCheck('check');
                            });
                        }
                        $(".notification").find('p').html("Options have been applied to the rest of the " + whichService + "s.");
                    }
                    else
                        $(".notification").find('p').html("Error: No options selected to be applied.");
                }

                for (var h = 0; h < bedroomradios.length; h++) {

                    if (bedroomradios[h].length > 0) {

                        for (var i = 0; i < bedroomradios[h].length; i++) {

                            if (bedroomradios[h][i] != null) {

                                var listContainer = bedroomradios[h][i].parent().parent().parent().parent();

                                // get the checkbox
                                var thischeckbox = listContainer.find('input.lineCheck');

                                // get this checkbox's id
                                var thisId = thischeckbox.attr('id');
                                // get this option's number
                                thisId = thisId.replace(/\D/g, '');

                                // i can now use the checkbox id to find the inner div that contains the same
                                // id
                                var pageInnerContainer = bedroomradios[h][i].parent().parent().parent().parent().parent().parent().parent().parent().parent().parent();

                                var thisinner = pageInnerContainer.next().find('div#inner' + thisId);

                                var thisval = bedroomradios[h][i].attr('value');
                                thisinner.find('input[type="radio"].lineRadioCheck').each(function () {
                                    if ($(this).attr('value') == thisval) {
                                        $(this).iCheck('check');
                                    }
                                });
                            }
                        }
                    }
                }

            }

            $(".notification").fadeIn(300).delay(3500).fadeOut(300);

        }

        function extractRTQData(serviceArray, radioArray) {

            var returnarray = new Array();
            var returnradio = new Array();

            var finalreturn;

            // check if the passed array is not null and has something
            if (typeof serviceArray !== 'undefined' && serviceArray.length > 0) {

                // extract the values (option id) from the contents of the arrays
                for (var i = 0; i < serviceArray.length; i++) {
                    // the current element could be another array
                    if (serviceArray[i] instanceof Array) {
                        for (var j = 0; j < serviceArray[i].length; j++) {
                            // there can be values that are the names of the options
                            // themselves, which are conflicted. so i need to extract
                            // the option number (id) from its html id
                            if (!isNaN(serviceArray[i][j].val())) {
                                returnarray.push(serviceArray[i][j].val());
                            }
                            else {
                                var thisId = serviceArray[i][j].attr('id');
                                // get this option's number
                                thisId = thisId.replace(/\D/g, '');
                                returnarray.push(thisId);
                            }
                        }
                    }
                    else {
                        if (!isNaN(serviceArray[i].val())) {
                            returnarray.push(serviceArray[i].val());
                        }
                        else {
                            var thisId = serviceArray[i].attr('id');
                            thisId = thisId.replace(/\D/g, '');
                            returnarray.push(thisId);
                        }

                    }
                }
            }
            else {
                alert("Error: Some required values are empty. Please contact the Web Developer.");
            }

            // check if the passed array is not null and has something
            if (typeof radioArray !== 'undefined' && radioArray.length > 0) {

                // extract the values (option id) from the contents of the arrays
                for (var i = 0; i < radioArray.length; i++) {
                    // the current element could be another array
                    if (radioArray[i] instanceof Array) {
                        for (var j = 0; j < radioArray[i].length; j++) {
                            returnradio.push(radioArray[i][j].val());
                        }
                    }
                    else
                        returnradio.push(radioArray[i].val());
                }
            }

            // note: combine the 2 arrays so that they can both be passed back

            if (returnarray.length > 0 || returnradio.length > 0) {
                finalreturn = new Array();
                finalreturn.push(returnarray);
                finalreturn.push(returnradio);
            }
            else
                finalreturn = null;

            return finalreturn;
        }


        function finishQuote() {

            propertyName = $("#nametxt").val();

            $("#loadercontainer").show(); // show loader

            $("#OfficeContainer").fadeOut(500);

            var othrinf = "N/A";

            if (noteenabled == true)
                othrinf = "Please remember to show the cleaner where the dirty laundry bin is and familiarize them with your laundry machines";

            setTimeout(function () {

                // ajax all data to be created in the db
                // send service data and wait for the total to be returned

                // this section will cascade down because 1 has to be created before
                // the next. i.e. house > room/quote > app > option

                var bathcount = 0;
                var bedcount = 0;
                var roomid;

                // house
                $.ajax({
                    type: 'POST',
                    url: 'qQuote.aspx/createHouseObject',
                    data: '{ "otherinfo" : "' + othrinf + '", "cleaningtypeid" : "' +
                        $('#cleaningtype').val() + '", "housename":"' + $("#name").val() + '", "housetype":"' + $('#housetype option:selected').text() + '", "area":"' +
                        $('#area option:selected').text() + '", "pets":"' + $('#pets').val() + '" }',  // change the id to dynamic
                    contentType: 'application/json; charset=utf-8',
                    async: false,
                    dataType: 'json',
                    success: function (msg) {
                        console.log(msg.d.__type);

                        var roomnamearray = new Array();
                        var roomcontainers = $('div.roomMain.optionsSelected');
                        if (roomcontainers != null && roomcontainers.length > 0)
                            for (var i = 0; i < roomcontainers.length; i++) {
                                // get the 3rd class name which is the Room name
                                roomnamearray.push($(roomcontainers[i]).attr('class').split(' ')[1]);
                            }
                        
                        // send rooms, apps and options
                        for (var o = 0; o < roomnamearray.length; o++) {

                            // save the room first, then apps+options
                            $.ajax({
                                type: 'POST',
                                url: 'qQuote.aspx/createRoomObject',
                                data: '{ "room" : "' + roomnamearray[o] + '" }',
                                contentType: 'application/json; charset=utf-8',
                                dataType: 'json',
                                async: false,
                                success: function (msg) {
                                    console.log('back from creating room ' + roomnamearray[o]);
                                    roomid = msg.d;
                                }
                            });

                            var appnamearray = new Array();
                            var appcontainers = $(roomcontainers[o]).find('.optionsSelected');

                            if (appcontainers != null && appcontainers.length > 0)
                                for (var i = 0; i < appcontainers.length; i++) {
                                    appnamearray.push($(appcontainers[i]).find('.appHead').html().replace("&amp;", "&"));
                                }

                            var checkarray = null;
                            var radioarray = null;

                            for (var i = 0; i < appnamearray.length; i++) {
                                switch (roomnamearray[o]) {
                                    case "Bathroom":
                                        if (bathroomservice != null) {
                                            if (numbath > 1) {
                                                checkarray = bathroomservice[bathcount];
                                            }
                                            else
                                                checkarray = bathroomservice;
                                        }
                                        if (bathroomradios != null) {
                                            if (numbath > 1) {
                                                radioarray = bathroomradios[bathcount];
                                            }
                                            else
                                                radioarray = bathroomradios;
                                        }
                                        break;
                                    case "Bedroom":
                                        if (bedroomservice != null) {
                                            if (numbed > 1) {
                                                checkarray = bedroomservice[bedcount];
                                            }
                                            else
                                                checkarray = bedroomservice;
                                        }
                                        if (bedroomradios != null) {
                                            if (numbed > 1) {
                                                radioarray = bedroomradios[bedcount];
                                            }
                                            else
                                                radioarray = bedroomradios;
                                        }
                                        break;
                                    case "Kitchen":
                                        if (kitchenservice != null)
                                            checkarray = kitchenservice;
                                        if (kitchenradios != null)
                                            radioarray = kitchenradios;
                                        break;
                                    case "DiningRoom":
                                        if (diningroomservice != null)
                                            checkarray = diningroomservice;
                                        if (diningroomradios != null)
                                            radioarray = diningroomradios;
                                        break;
                                    case "LivingRoom":
                                        if (livingroomservice != null)
                                            checkarray = livingroomservice;
                                        if (livingroomradios != null)
                                            radioarray = livingroomradios;
                                        break;
                                    default:    //office
                                        if (officeservice != null)
                                            checkarray = officeservice;
                                        if (officeradios != null)
                                            radioarray = officeradios;
                                        break;
                                }

                                //if (bathcount < 4 && bedcount < 4) {
                                    var arraycombined = extractRTQData(checkarray, radioarray);
                                    if (arraycombined != null && arraycombined.length > 1) {
                                        checkarray = arraycombined[0];
                                        radioarray = arraycombined[1];
                                    }

                                    console.log(checkarray.length);
                                    console.log(appnamearray.length);

                                    $.ajax({
                                        type: 'POST',
                                        url: 'qQuote.aspx/createRoomAppOption',
                                        data: '{ "options" : "' + checkarray + '", "suboptions" : "' + radioarray + '","appname": "' + appnamearray[i] + '", "roomid":"' + roomid + '" }',
                                        contentType: 'application/json; charset=utf-8',
                                        dataType: 'json',
                                        async: false,
                                        success: function (msg) {
                                            console.log('back from creating rooms' + msg.d);
                                            totalTime += msg.d;
                                        }
                                    });
                                //}
                            }   // apparray loop

                            // go to next bathroom
                            if (roomnamearray[o] == "Bathroom" && numbath > 1)
                                bathcount++;
                            if (roomnamearray[o] == "Bedroom" && numbed > 1)
                                bedcount++;
                            
                        }   // roomarray loop
                                                
                    },  // house creation success ajax
                    error: function (error) {
                        alert("Error: Retrieving data failed.");
                    }   // house creation error ajax

                }); // house creation ajax


                // =========    after the shenanigans, show data to user

                $("#quoteSummary").fadeIn(700);

                totalPrice = (totalTime / 60) * 25;

                var time = (totalTime / 60).toFixed(2);
                var timetext = " hour(s)";
                var finaltimetext = "";
                if (time < 1) {
                    time = Math.floor(time * 60);
                    timetext = " minutes";
                    finaltimetext = time + timetext;
                }
                else {
                    var num = Math.floor(time);
                    var decimal = time % num;
                    var minutes = Math.floor(decimal * 60);

                    finaltimetext += num + " hours";
                    finaltimetext += ", " + minutes + " minutes";
                }

                $("#loadercontainer").fadeOut(500); // hide loader

                if (propertyName != "")
                    $("#housename").find('h2').html(propertyName);
                else
                    $("#housename").find('h2').html("(Default)");

                $("#totaltime").find('h2').html(finaltimetext);
                $("#totalprice").find('h2').html((totalPrice).toFixed(2) + " CAD");

            }, 1000);

        }


        function sendServiceData(array) {

            // always expect something wrong to happen.
            // otherwise, there will always be 2 elements in this array

            if (array != null || array.length > 1) {
                var checks = array[0];
                var radios = array[1];
                
                var dataToSend = { MethodName: 'createServiceData', obj: checks, obj2: radios }

                $.ajax({
                    type: 'POST',
                    url: 'qQuote.aspx/createServiceData',
                    data: '{ "obj" : "' + checks + '", "obj2": "' + radios + '" }',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    async:false,
                    crossDomain: true,
                    success: function (msg1) {
                        // will receive total
                        console.log('back from create service data');
                        totalTime += parseInt(msg1.d);
                    },
                    error: function (error) {
                        alert("Error: Retrieving data failed.");
                    }
                });
            }
            else {
                alert("Error: There is insufficient data to process the RTQ.");
                return false;
            }

        }

        function sendEmail() {

            if ($("#email").val() != "") {
                var rec = $("#email").val();

                // show popup
                showPop("#regpop");
                // close the notification
                //$.noty.get("noty1").hide();

                $("#quoteloader").show();
                $("#regbox").hide();

                if (propertyName == "" || propertyName == null)
                    propertyName = "(Default)";

                // create the quote before sending the email
                $.ajax({
                    type: 'POST',
                    url: 'qQuote.aspx/createQuoteRecord',
                    data: '{ "quotepath":"' + quotepath + '", "email" : "' + $("#email").val() + '", "price" : "' + totalPrice.toFixed(2) + '", "time" : "' + totalTime + '", "qname":"' + propertyName + '" }',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (msg) {
                        console.log(msg.d); // receive the table for the quote summary

                        $("#invoiceDiv").append(msg.d).show();
                        $("#invoiceDiv").css('top', '100px');
                        $("#serviceDetailDiv").masonry({
                            itemSelector: '.roomtable'
                        });
                        html2canvas(document.getElementById('invoiceDiv'), {
                            onrendered: function (canvas) {
                                document.body.appendChild(canvas);
                                $(canvas).hide();
                                var image = canvas.toDataURL("image/png");
                                image = image.replace('data:image/png;base64,', '');
                                $("#invoiceDiv").hide();
                                $.ajax({
                                    type: 'POST',
                                    url: 'qQuote.aspx/UploadImage',
                                    data: '{ "imageData" : "' + image + '", "email" : "' + rec + '" }',
                                    contentType: 'application/json; charset=utf-8',
                                    dataType: 'json',
                                    success: function (msg) {

                                        
                                        $("#quoteloader").delay(1000).fadeOut(300, function () {
                                            $("#quoteBox").html("");
                                            $("#regbox").fadeIn(500);
                                            quote = msg.d;
                                            $("#quoteBox").append("Your Quote Code is:<br/><span class='quotenumber'>" + quote + "</span>");
                                        });
                                        /*   },
                                        error: function (msg1) {
                                        $("#quoteBox").append("There was an error in creating this quote");
                                        }*/
                                    }
                                });

                            }
                        });
                        
                        // here, create the canvas image of the div

                        // create an invoice, save into an image file into the file system, then
                        // attach to an email before sending the email

                        
                    }
                });
            }
            else
                alert("Please enter a valid email address.");
        }

        function proceedReg() {
            var em = $("#email").val();
            window.location.href = '../selfserve/register.aspx?email=' + em + "&quotecode=" + quote + "&area=" + $('#area').val() + "&housetype=" + $("#housetype").val() + "&housename=" + $("#name").val();
        }
        function cancelReg() {
            if (confirm('You will now be taken back to the beginning of the RTQ.')) {
                window.location.reload(true);
            }
        }

    </script>

</asp:Content>
