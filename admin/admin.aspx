<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="admin.aspx.cs" Inherits="admin_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="pageTitle">    
        <span>Welcome to the Administration Backend of the Real Time Quote System</span>
    </div>
        SELECT FROM THE MENU<br />
    <div class="admin-text">
        <h3>By Radney Alquiza</h3>
        <p>
            The backend software is now usable but it isn't completely finished.
       This version will be regularly updated with features and fixes after release.
       Cleanups on the code will be updated regularly and synchronized with the repository.
        </p>

        <h3>Current Features:</h3>
        <span class="title">Customers</span>
        <ul>
            <li>Add Record - add a new record to the customers table, customer ID is generated automatically.</li>
            <li>View Detailed Record - view customer information, including house type and activity.</li>
            <li>Edit Record - edit all customer records, non-modifiable records are disabled.</li>
            <li>Delete Record - delete any customer record.</li>
        </ul>
        <span class="title">Employees</span>
        <ul>
            <li>Add Record - add a new record to the employees table, employee ID is generated automatically.</li>
            <li>View Detailed Record - view employee information.</li>
            <li>Edit Record - edit all employee records, non-modifiable records are disabled.</li>
            <li>Delete Record - delete any employee record.</li>
        </ul>
        <span class="title">Sales</span>
        <ul>
            <li style='text-decoration:line-through'>Add Record - add a new record to the tables.</li>
            <li style='text-decoration:line-through'>View Detailed Record - view Invoice/Quote information.</li>
            <li>At the moment, only the list of Invoices and Quotes plus their superficial information are viewable.</li>
        </ul>
        <span class="title">Schedule</span>
        <ul>
            <li style='text-decoration:line-through'>Add New Event.</li>
            <li style='text-decoration:line-through'>View Event Information.</li>
            <li style='text-decoration:line-through'>Delete Event.</li>
            <li style='text-decoration:line-through'>Assign Employee to Event.</li>
            <li style='text-decoration:line-through'>Modify Event.</li>
        </ul>

        <h3>Changelog:</h3>
        <span class="ver">Version 0.7 of Admin</span>
        <ul>
            <li>Implemented AtlasTable plugin to manage tabular data.</li>
            <li>Implemented AtlasAJAXOverlay plugin for use with AtlasTable.</li>
            <li>Implemented RTQManager.cs as manager class for managing Sales Information.</li>
            <li>Implemented CustomerManager.cs as manager class for managing Customers.</li>
            <li>Implemented EmployeeManager.cs as manager class for managing Employees.</li>
            <li>Cleaned up Javascript code and Code-behind a little.</li>
        </ul>

        <span class="ver">Version 0.8 of RTQ</span>
        <ul>
            <li>Implemented Simplified RTQ process.</li>
            <li>Implemented AtlasChecklist plugin to manage list data.</li>
            <li>Implemented easier data collection when RTQ is finished.</li>
            <li>Implemented another visual version.</li>
            <li>Implemented floor types.</li>
            <li>Implemented multiple room options [Bedroom] & [Bathroom].</li>
            <li>Implemented room navigation.</li>
            <li>Implemented complete quote creation.</li>
            <li>Implemented NEW QUOTE STORAGE - *.rtq flat files since file system quota is much bigger than database.</li>
            <li>Implemented *.rtq file read and write using RTQ data collected in the RTQ System.</li>
            <li>Added Quotepath column for Quotes table.</li>
            <li>Implemented RoomDataDTO that will contain ALL information about a Room in the quote.</li>
            <li>Implemented Invoice Image creation and emails this image to the email address provided.</li>
        </ul>

        <h3>To be implemented:</h3>
        <span class="ver">~Version 0.9</span>
        <ul>
            <li>Scheduling System.</li>
            <li>Invoice->Quote viewing detailed information</li>
            <li>Availability Manager.</li>
            <li>Quote modification?</li>
        </ul>
        <span class="ver">>Version 1.0</span>
        <ul>
            <li>Code cleanup for file system management.</li>
            <li>Database Refresh, Backup, Cleanup.</li>
            <li>Logins.</li>
        </ul>
    </div>


</asp:Content>

