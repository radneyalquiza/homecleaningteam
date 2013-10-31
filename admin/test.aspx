<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation = "false" CodeFile="test.aspx.cs" Inherits="admin_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="../Styles/component.css" rel="stylesheet" />
    <link href="../Styles/animations.css" rel="stylesheet" />
    <link href="../Styles/Site.css" rel="stylesheet" />

<script src="../Scripts/modernizr.custom.js"></script>

    <style>
        body
        {
            font-size:1.2em;
        }
        td
        {
            background-color:#ff8400;
        }
    </style>

    <script>
    </script>

</head>
	<body>	

<form id="form1" runat="server">
    <div>
    <img src = "http://www.aspsnippets.com/images/Blue/Logo.png" /><br />
    </div>
    <div style = "font-family:Arial">This is a test page</div>
    <div class="div1">
    <table border = "1" width = "200">
    <tr><td>Name</td><td>Age12334</td></tr>
    <tr><td>John</td><td>11</td></tr>
    <tr><td>Sam</td><td>13</td></tr>
    <tr><td>Tony</td><td>12</td></tr>
    </table>
    </div>
    <div>
    <asp:Button ID="btnExport" runat="server" Text="Export" onclick="btnExport_Click" /></div>
    <p><asp:LinkButton ID="lnkExport" runat="server" onclick="lnkExport_Click" Text="Export"/></p>     
</form>

    

	</body>
</html>
