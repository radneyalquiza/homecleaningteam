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

    <script src="../Scripts/rtq.js"></script>
    <script src="../Scripts/common-functions.js"></script>

    <link href="../Styles/atlasPageTransitions.css" rel="stylesheet" />
    <link href="../Styles/atlasTooltip.css" rel="stylesheet" />

    <!-- FONTS -->
    <link href='http://fonts.googleapis.com/css?family=Acme' rel='stylesheet' type='text/css' />
    <link href='http://fonts.googleapis.com/css?family=Ubuntu' rel='stylesheet' type='text/css'/>
    

    <style>
    </style>


    <script>
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div id="loadercontainer">
        <!--<img src="../Styles/img/image.gif" /> 
            <img src="../Styles/img/84.gif" />-->
        <img src="../Styles/img/320.GIF" />
    </div>

    <!-- multipurpose modal cover -->
    <div class="cover"></div>


    <div id="quoteSample">
        <div id="rooms"></div>
        <div class="wrap">
            <div class="edit">I need to make changes.</div>
            <div class="finish">All is good, Finish!</div>
        </div>
    </div>

    <span class="nextGroup"></span>
    <span class="prevGroup"></span>

    <div id="quote-edit">
        <span class="edit-title">EDIT MODE<span class="close-edit"></span></span>
        <div class="cont"></div>
        <span class="load-left"></span>
        <span class="load-right"></span>
    </div>


    <div id="rtqoutercont">

        <!-- container for deleted rooms in case the user wants to put it back -->
        <div class="garbage">
            <span class="title">Extra Rooms:</span>
            <div class="tilelist">
                <div class="tile bathroom"></div>
                <div class="tile bedroom"></div>
                <div class="tile kitchen"></div>
                <div class="tile diningroom"></div>
                <div class="tile livingroom"></div>
            </div>
            <div class="deletedrooms"></div>
        </div>

      <!--  <div class="navButton">
            MENU
        </div>-->

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




            </div>

        <div id="nextroom"></div>
        <div id="finish">Finish Quote!</div>

        <div id="propertyquestions" class="propertyquestionsclass">
            
          <div class="propertyquestioninner">
            <div class="propertyquestionpart">
                <h3 class="prop">Questions about your Property</h3>
                <div class="propertydesc grid-whole equalize">
                    <ul id="ulpropertyinfo">
                        <li class="grid-half s-grid-whole padded">
                            <div class="propertydiv padded-inner content-box box">
                                <h1>Name your property</h1>
                                <h4>(pick any nickname, to identify the property i.e. "Jacob's House" or "135 King St")</h4>
                                <div style="height:auto; width:auto"><input id="name" type="text" class="ttextbox" /></div>
     
                            </div>
                        </li>
                        <li class="grid-half s-grid-whole padded">
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
                        </ul>
                </div>
                <div class="propertydesc grid-whole equalize">
                    <ul id="ul2">
                        <li class="grid-half s-grid-whole padded">
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
                        <li class="grid-half s-grid-whole padded">
                            <div class="propertydiv padded-inner content-box box">
                                <h1>Do you have any pets?</h1>
                                        <select id="pets">
                                            <option value="None">Nope.</option>
                                            <option value="Dog/s">Dog/s</option>
                                            <option value="Cat/s">Cat/s</option>
                                        </select>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="propertydesc grid-whole equalize">
                    <ul id="ul1">
                        <li class="grid-half s-grid-whole padded">
                            <div class="propertydiv padded-inner content-box box">
                                <h1>How many Bathrooms?</h1>
                                <ul class="atlas-radio" id="bathnumslist">
                                    <li>N/A</li>
                                    <li>1</li>
                                    <li>2</li>
                                    <li>3</li>
                                    <li>4</li>
                                </ul>
                            </div>
                        </li>
                        <li class="grid-half s-grid-whole padded">
                            <div class="propertydiv padded-inner content-box box">
                                <h1>How many Bedrooms?</h1>
                                <ul class="atlas-radio" id="bednumslist">
                                    <li>N/A</li>
                                    <li>1</li>
                                    <li>2</li>
                                    <li>3</li>
                                    <li>4</li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </div>

                <div class="propertydesc grid-whole equalize">
                    <input type="button" id="gotoservicequestions" class="mainBtn" value="Proceed to RTQ Options" /> 
                </div>
                <br />
            </div>
            <div class="servicequestionpart">
                <h3 class="prop">Your Realtime Quote</h3>
                <div class="propertydesc equalize" id="serv">
                    <ul class="ulserviceinfo">
                        <li>
                            <div class="box">
                                <h1>How soon do you need the service?</h1>
                                <select id="daterange">
                                    <option>Just shopping around</option>
                                    <option>Next 48 hours</option>
                                    <option>This week</option>
                                    <option>Next two weeks</option>
                                    <option>Next month</option>

                                </select>
                            </div>
                        </li>
                        <li>
                            <div class="box">
                                <h1>What type of cleaning are you looking for?</h1>
                                <select id="cleaningtype">
                                    <option value="">Select below...</option>
                                    <option value="routine-std">Routine Cleaning - Standard</option>
                                    <option value="routine-prm">Routine Cleaning - Premium</option>
                                    <option value="deep-std">Deep Cleaning - Standard</option>
                                    <option value="deep-prm">Deep Cleaning - Premium</option>
                                </select>
                            </div>
                        </li>
                    </ul>
                    <div class="sidebutton"></div>
                </div>
                <!--<div class="cleaningtypediv">
                    <ul>
                        <li>
                            <div class="cleaningtype o1" data-val="routine-std">
                                <span class="title">Routine Cleaning (Standard)</span>
                                <div class="desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                                    Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                                    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
                                    Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                </div>
                            </div>
                            </li>
                        <li>
                            <div class="cleaningtype o2" data-val="routine-prm">
                                <span class="title">Routine Cleaning (Premium)</span>
                                <div class="desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                                    Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                                    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
                                    Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                </div>
                            </div>
                            </li>
                        <li>
                            <div class="cleaningtype o3" data-val="deep-std">
                                <span class="title">Deep Cleaning (Standard)</span>
                                <div class="desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                                    Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                                    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
                                    Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                </div>
                            </div>
                                </li>
                        <li>
                            <div class="cleaningtype o4" data-val="deep-prm">
                                <span class="title">Deep Cleaning (Premium)</span>
                                <div class="desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                                    Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                                    Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
                                    Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>-->




            </div>
          
             <!-- <input type="button" id="end" class="mainBtn" value="Proceed to Quote Details" /> -->
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
        <div id="BathroomContainer" style="">
            <div class="roomheader">Bathroom</div>
        </div>
        <div id="BedroomContainer" style="">
            <div class="roomheader">Bedroom</div>
        </div>
        <div id="KitchenContainer" style="">
            <div class="roomheader">Kitchen</div>
        </div>
        <div id="DiningRoomContainer" style="">
            <div class="roomheader">Dining Room</div>
        </div>
        <div id="LivingRoomContainer" style="">
            <div class="roomheader">Living Room</div>
        </div>
        <div id="OfficeContainer" style="">
            <div class="roomheader">Office</div>
        </div>


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







         <!--       <div class="roomgroupdiv">
                    <div class="categoriesdiv">
                        <ul class="categorieslist">
                            <li><span>C1</span></li>
                            <li><span>C2</span></li>
                            <li><span>C3</span></li>
                            <li><span>C4</span></li>
                            <li><span>C5</span></li>
                        </ul>
                    </div>
                    <div class="roomgrouplistcontainer">
                        <ul class="roomgrouplist">
                            <li><span class="title">R1</span>
                                <div class="appcont">
                                    <div class="optioncont">
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                    </div>
                                </div>
                                <div class="appcont">
                                    <div class="optioncont">
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                    </div>
                                </div>
                            </li>
                            <li><span class="title">R2</span>
                                <div class="appcont">
                                    <div class="optioncont">
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                    </div>
                                </div>
                            </li>
                            <li><span class="title">R3</span>
                                <div class="appcont">
                                    <div class="optioncont">
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                    </div>
                                </div>
                                <div class="appcont">
                                    <div class="optioncont">
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                    </div>
                                </div>
                            </li>
                            <li><span class="title">R4</span>
                                <div class="appcont">
                                    <div class="optioncont">
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                    </div>
                                </div>
                                <div class="appcont">
                                    <div class="optioncont">
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                    </div>
                                </div>
                                <div class="appcont">
                                    <div class="optioncont">
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                    </div>
                                </div>
                            </li>
                            <li><span class="title">R5</span>
                                <div class="appcont">
                                    <div class="optioncont">
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                    </div>
                                </div>
                                <div class="appcont">
                                    <div class="optioncont">
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                        <div class="option">Option</div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                        <span class="clearfix"></span>
                    </div>
                </div>
    -->
    <script>
   
    </script>

</asp:Content>
