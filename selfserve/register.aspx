<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="selfserve_register" %>

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

    <script src="<%= ResolveUrl("~/Scripts/jquery.mask.js") %>" type="text/javascript">
    </script>
    


    <script>
        function getQueryStrings() {
            var assoc = {};
            var decode = function (s) { return decodeURIComponent(s.replace(/\+/g, " ")); };
            var queryString = location.search.substring(1);
            var keyValues = queryString.split('&');

            for (var i in keyValues) {
                var key = keyValues[i].split('=');
                if (key.length > 1) {
                    assoc[decode(key[0])] = decode(key[1]);
                }
            }

            return assoc;
        }
        var quote;
        var email;
        var area = 1;   // these will default if the customer didnt do RTQ before
        var housename = "Default";
        var housetype = 1;  // these will default if the customer didnt do RTQ before
        var address;
        var qstring;
        
        $(function ($) {

            $("#fname").focus();

            // get the passed value
            qstring = getQueryStrings();
            if (qstring["email"] != null && qstring["email"] != "")
                email = qstring["email"];
            if (qstring["quotecode"] != null && qstring["quotecode"] != "")
                quote = qstring["quotecode"];
            if (qstring["area"] != null && qstring["area"] != "")
                area = qstring["area"];
            if (qstring["housetype"] != null && qstring["housetype"] != "")
                housetype = qstring["housetype"];
            if (qstring["housename"] != null && qstring["housename"] != "")
                housename = qstring["housename"];
            
            if (email != "" && email != "undefined")
                $("#email1").val(email);

            console.log(email);
            console.log(quote);
            console.log(area);
            console.log(housetype);
            console.log(housename);

            // apply masking
            $("#home").mask("(000)-000-0000");
            $("#mobile").mask("(000)-000-0000");
            $("#work").mask("(000)-000-0000");
            $("#bldg").mask("0000");
            $("#unit").mask("0000");
            $("#postalcode").mask("S0S 0S0");

            // when register button is clicked
            $("#regBtn").click(function () {
                // check for required values
                var $emptyItems = $(".requiredField").filter(function () { return $(this).val() == ""; });

                if ($emptyItems.length < 1) {
                    // proceed with registration
                    createCustomer();
                    createAddress();
                    createProperty();
                    createPerson();
                }
                else {
                    $.each($emptyItems, function () {
                        if ($(this).val() == "") {
                            $(this).parent().append("<span>*Required</span>");
                        }
                    });
                }
            });

            // send data for customer creation
            function createCustomer() {
                $.ajax({
                    type: 'POST',
                    url: 'register.aspx/createCustomer',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    async: false,
                    crossDomain: true,
                    success: function (msg1) {
                        // will receive total
                        //console.log(msg1.d);
                        if (msg1.d != "false")
                            console.log("customer yes");
                        else
                            console.log("customer no");
                    },
                    error: function (error) {
                        alert("Error: Client Creation Failed.");
                    }
                });
            }
            function createAddress() {
                
                $.ajax({
                    type: 'POST',
                    url: 'register.aspx/createAddress',
                    contentType: 'application/json; charset=utf-8',
                    data: '{ "bldg":"' + $("#bldg").val() + '", "unit":"' + $("#unit").val() +
                          '", "street":"' + $("#street").val() + '", "city":"' + $("#city").val() +
                          '", "postalcode":"' + $("#postalcode").val() + '"}',
                    dataType: 'json',
                    async: false,
                    crossDomain: true,
                    success: function (msg1) {
                        // will receive total
                        //console.log(msg1.d);
                        if (msg1.d != 0 && msg1.d != "undefined") {
                            console.log("address yes");
                            address = msg1.d;
                        }
                        else
                            console.log("address no");
                    },
                    error: function (error) {
                        alert("Error: Client Creation Failed.");
                    }
                });
            }
            function createProperty() {
                $.ajax({
                    type: 'POST',
                    url: 'register.aspx/createProperty',
                    contentType: 'application/json; charset=utf-8',
                    data: '{ "name":"' + housename + '", "address":"' + address + '", "area":"' + area +
                          '", "housetype":"' + housetype + '"}',
                    dataType: 'json',
                    async: false,
                    crossDomain: true,
                    success: function (msg1) {
                        // will receive total
                        //console.log(msg1.d);
                        if (msg1.d != "false")
                            console.log("property yes");
                        else
                            console.log("property no");
                    },
                    error: function (error) {
                        alert("Error: Client Creation Failed.");
                    }
                });
            }
            function createPerson() {
                $.ajax({
                    type: 'POST',
                    url: 'register.aspx/createPerson',
                    contentType: 'application/json; charset=utf-8',
                    data: '{ "fname":"' + $("#fname").val() + '", "lname":"' + $("#lname").val() + '", "email1":"' + $("#email1").val() +
                          '", "email2":"' + $("#email2").val() + '", "home":"' + $("#home").val() +
                          '", "mobile":"' + $("#mobile").val() + '", "work":"' + $("#work").val() + '"}',
                    dataType: 'json',
                    async: false,
                    crossDomain: true,
                    success: function (msg1) {
                        // will receive total
                        if (quote != "" && quote != null && quote != "undefined") {
                            createInvoice(quote);
                        }
                        else {
                            if (msg1.d != "false")
                                showPop("#regpop");
                            else
                                alert("Registration Failed.");
                        }
                    },
                    error: function (error) {
                        alert("Error: Client Creation Failed.");
                    }
                });
            }

            function createInvoice() {
                $.ajax({
                    type: 'POST',
                    url: 'register.aspx/createInvoice',
                    contentType: 'application/json; charset=utf-8',
                    data: '{ "quote":"' + quote + '"}',
                    dataType: 'json',
                    async: false,
                    crossDomain: true,
                    success: function (msg1) {
                        // will receive total
                        if (msg1.d != "false")
                            showPop("#regpop");
                        else
                            console.log("person no");
                    },
                    error: function (error) {
                        alert("Error: Client Creation Failed.");
                    }
                });
            }

            function proceedBook() {
                if (quote != "" && quote != null) {
                    window.location.href = '../selfserve/jobBooking.aspx?quote=' + quote;
                }
            }
        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <div class="mainDiv">
        <h2>Register</h2>

        
            <div class="blockContainer">
                <h3>Personal Information</h3>
                    <div class="inputholder"><label>First Name </label><input type="text" id="fname" placeholder='ex. John' /></div>
                    <div class="inputholder"><label>Last Name </label><input type="text" id="lname" placeholder='ex. Smith' class="requiredField" /></div>
            </div>
            <div class="blockContainer">
                <h3>Contact Information</h3>
                    <div class="inputholder"><label>Email Address 1 </label><input type="text" id="email1" placeholder='example@email.com' class="requiredField" /></div>
                    <div class="inputholder"><label>Email Address 2 </label><input type="text" id="email2" placeholder='example@email.com' /></div>
                    <div class="inputholder"><label>Home Phone </label><input type="text" id="home" placeholder='(123)-456-7890' class="requiredField" /></div>
                    <div class="inputholder"><label>Mobile Phone </label><input type="text" id="mobile" placeholder='(123)-456-7890' /></div>   
                    <div class="inputholder"><label>Work Phone </label><input type="text" id="work" placeholder='(123)-456-7890' /></div> 
            </div>
            <div class="blockContainer">
                <h3>Address Information</h3>
                    <div class="inputholder"><label>Building Number </label><input type="text" id="bldg" placeholder='Building Number' class="requiredField" /></div>   
                    <div class="inputholder"><label>Unit Number </label><input type="text" id="unit" placeholder='Unit Number' /></div>  
                    <div class="inputholder"><label>Street Address </label><input type="text" id="street" placeholder='Street Name' class="requiredField" /></div>  
                    <div class="inputholder"><label>City/Municipality </label><input type="text" id="city" placeholder='City' /></div>    
                    <div class="inputholder"><label>Postal Code </label><input type="text" id="postalcode" placeholder='A1A 1A1' class="requiredField" /></div>            
            </div>
                <input type="button" id="regBtn" class="mainBtn" value="Register Now" />
    </div>
        <div id="regpop" class="popup">
        <h3>Registration has been completed!</h3><br />
       
        <div id="regbox">
            Thank you for joining the Members of The Home Cleaning Team!<br />
            You can now book a job (provided you created or have a Quote confirmation code)<br />
            Press Exit button to navigate away from the page.<br />

            <input type="button" id="reg" class="beginBtn" value="Book" onclick="proceedBook();" />
            <input type="button" id="cancel" class="beginBtn" value="Exit" onclick="window.location.href = '../Default.aspx';
"/>
        </div>
    </div>
    <br />
</asp:Content>

