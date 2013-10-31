<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="employees.aspx.cs" Inherits="admin_employees_employees" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script>
        $(function ($) {
                //getCustomers();
                $("#employeestable").atlasTable({
                    header: 'Employee Records',
                    editable: true,
                    //showInlineControls: false,
                    getAllUrl: 'employees.aspx/getEmployees',
                    getOneUrl: 'employees.aspx/getEmployeeInfo',
                    saveOneUrl: 'employees.aspx/saveEmployeeInfo',
                    addOneUrl: 'employees.aspx/createEmployeeInfo',
                    deleteOneUrl: 'employees.aspx/deleteEmployee',

                    //showColumnHeaders: false,
                    //recordSearchItem: 'EmployeeID',
                    hiddenColumns: ['Email1', 'MobilePhone'],
                    onComplete: function () {
                        $(this).find("#rate").mask('00.00');
                        $(this).find("#home").mask('(000)-000-0000');
                        $(this).find("#work").mask('(000)-000-0000');
                        $(this).find("#mobile").mask('(000)-000-0000');
                        $(this).find("#postal").mask('S0S 0S0');
                    },
                    formFields: {
                        EmployeeID: {
                            domid: 'cid',
                            title: 'Customer ID',
                            type: 'text',
                            enabled: 'false',
                            notForAdd: 'true'
                        },
                        FirstName: {
                            domid: 'cfname',
                            title: 'First Name',
                            type: 'text',
                        },
                        LastName: {
                            domid: 'clname',
                            title: 'Last Name',
                            type: 'text',
                        },
                        Status: {
                            domid: 'status',
                            title: 'Active',
                            type: 'checkbox',
                            states: { 'checked': 'Active', 'unchecked': 'Inactive' }
                        },
                        HireDate: {
                            domid: 'join',
                            title: 'Join Date',
                            type: 'text',
                            enabled: 'false',
                            notForAdd: 'true'
                        },
                        Type: {
                            domid: 'type',
                            title: 'Employee Type',
                            type: 'select',
                            options: {
                                'CLN': 'Cleaner',
                                'SPV': 'Supervisor',
                                'MAN': 'Manager',
                                'ADM': 'Administrator',
                                'DTE': 'Data Entry',
                            }
                        },
                        Rate: {
                            domid: 'rate',
                            title: 'Pay Rate',
                            type: 'text'
                        },
                        HomePhone: {
                            domid: 'home',
                            title: 'Home Phone',
                            type: 'text',
                            placeholder: 'Not Available',
                        },
                        WorkPhone: {
                            domid: 'work',
                            title: 'Work Phone',
                            type: 'text',
                            placeholder: 'Not Available',
                        },
                        MobilePhone: {
                            domid: 'mobile',
                            title: 'Mobile Phone',
                            type: 'text',
                            placeholder: 'Not Available',
                        },
                        Email1: {
                            domid: 'email1',
                            title: 'Email 1',
                            type: 'text',
                        },
                        Email2: {
                            domid: 'email2',
                            title: 'Email 2',
                            type: 'text',
                        },
                        Bldg: {
                            domid: 'bldg',
                            title: 'Building #',
                            type: 'text'
                        },
                        Unit: {
                            domid: 'unit',
                            title: 'Unit #',
                            type: 'text'
                        },
                        Street: {
                            domid: 'street',
                            title: 'Street Name',
                            placeholder: 'Not Available',
                            type: 'text'
                        },
                        City: {
                            domid: 'city',
                            title: 'City',
                            placeholder: 'Not Available',
                            type: 'text'
                        },
                        Postal: {
                            domid: 'postal',
                            title: 'Postal Code',
                            type: 'text'
                        },
                        AddressID: {
                            domid: 'addressid',
                            type: 'hidden',
                            notForAdd: 'true'
                        }
                    }   // end of options
                    // if the input field is a checkbox, you need to pass the 2 state values (1/0, true/false, etc)
                }); // end of atlasTable
                

                $("#availman").click(function () {
                    alert("Feature coming soon! Manage your employee availability for easy scheduling!");
                });
                

            });


    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="pageTitle">    
        <span>Employee Management</span>
    </div>

    <div class="mainDiv" style="width:80%">

        <div id="employeestable">
        </div>
    </div>
    <br />
    <input type="button" class="formBtn" id="availman" value="Availability Manager" />
</asp:Content>

