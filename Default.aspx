<%@ Page Title="The HomeCleaningTeam - Home" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="head">
    
    <script>
        $(function ($) {

            $("#createQuote").click(function () {
                alert("You will now be taken to our 'RTQ' Web Application");
                window.location.href = "admin/qQuote.aspx";
            });

        });

    </script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">


        <div class="mainDiv">
            <h2>Welcome to Home Cleaning Team!</h2>
            
            <p>"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor<br />
                incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis<br />
                nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.<br />
                Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat<br />
                nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia<br />
                deserunt mollit anim id est laborum."</p>

            <input type="button" value="Create Quote!" id="createQuote" class="mainBtn" />
        </div>
        <div class="clear">
        </div>
</asp:Content>
