<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="services.aspx.cs" Inherits="admin_services_services" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div>
        <h3>All Services</h3>

        <h4>House Configuration</h4>
        <hr />

        <!-- TAKES YOU TO CLEANING TYPE MANAGEMENT PAGE -->
        <asp:Button ID="Button1" cssClass="menuButton" runat="server" Text="Cleaning Types" OnClick="Button1_Click" /><br />

        <!-- TAKES YOU TO HOUSE TYPE MANAGEMENT PAGE -->
        <asp:Button ID="Button2" cssClass="menuButton" runat="server" Text="House Types" OnClick="Button2_Click" /><br />

        <!-- TAKES YOU TO BUILDING AREAS (SQ FT) MANAGEMENT PAGE -->
        <asp:Button ID="Button3" cssClass="menuButton" runat="server" Text="Building Areas" OnClick="Button3_Click" /><br />

        <!-- TAKES YOU TO PROMOTIONALS/SPECIALS MANAGEMENT PAGE -->
        <asp:Button ID="Button7" cssClass="menuButton" runat="server" Text="Promotions" OnClick="Button7_Click" /><br />


        <h4>Configure RTQ System</h4>
        <hr />

        <!-- TAKES YOU TO RTQ OPTIONS MANAGEMENT PAGE -->
        <asp:Button ID="Button4" cssClass="menuButton" runat="server" Text="RTQ Options" OnClick="Button4_Click" /><br />

        <!-- TAKES YOU TO RTQ APPS MANAGEMENT PAGE -->
        <asp:Button ID="Button5" cssClass="menuButton" runat="server" Text="RTQ Appliances" OnClick="Button5_Click" /><br />

        <!-- TAKES YOU TO ROOMS MANAGEMENT PAGE -->
        <asp:Button ID="Button6" cssClass="menuButton" runat="server" Text="Rooms" OnClick="Button6_Click" /><br />

        <br />
    </div>
</asp:Content>

