<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="schedule.aspx.cs" Inherits="admin_schedule_schedule" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script>
        $(function () {

            // page is now ready, initialize the calendar...

            $('#calendar').fullCalendar({
                height: 600
                // put your options and callbacks here
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="pageTitle">    
        <span>Calendar</span>
    </div>

    <div class="mainDiv" style="width: 70%; margin: auto">
        <div id="calendar"></div>
    </div>
</asp:Content>

