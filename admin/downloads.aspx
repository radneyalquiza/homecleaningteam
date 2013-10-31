<%@ Page Language="C#" AutoEventWireup="true" CodeFile="downloads.aspx.cs" Inherits="admin_downloads" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <style>
        body
        {
            font-family: Verdana;
        }
        div.main
        {
            width:80%;
            padding:10px;
            margin:auto;
            border:1px solid #337abe;
        }
        h3
        {
            font-size: 1.2em;
            color: #337abe;
        }
        ul
        {
            list-style:none;
            padding:0;
        }
        li
        {
            background-color:#ff6a00;
            width:80%;
            padding:5px;
            margin-left:0px;
            border:1px solid #ca4400;
            margin:auto;
        }
            li:hover
            {
                background-color:#ffa86f;
                transition:all 0.6s;
            }
        a
        {
            text-decoration:none;
            color:white;
            font-size:1em;
            font-weight:600;
        }
            a:hover
            {
                color:#5b5b5b;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="main">
            <h3>Downloads for Honey</h3>
        --- Download mo dagitoy ne. Nu ada kailangam iupdate ko listaak kadetoy ta maaccess mo latta.
        <ul>
            <li>
                <a href="../files/WithoutYou-MeganNicole.mp3">Without You - Megan Nicole </a>
            </li>
        </ul>
    </div>
    </form>
</body>
</html>
