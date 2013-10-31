<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="customers.aspx.cs" Inherits="admin_customers_customers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    <script>
        $(function ($) {

                //getCustomers();
                $("#customerstable").atlasTable({
                    showInlineControls: false,
                    header: 'Customers',
                    showHeader: true,
                    editable: true,                   // for use with non-ajax data
                    /*useRemoteDataSource: false,
                    defaultData: [
                        {
                            column1:'joe',
                            column2:'jonas',
                            column3:'444-444-4444'
                        },
                        {
                            column1: 'joe',
                            column2: 'jonas',
                            column3: '444-444-4444'
                        }
                    ]*/
                    
                    getAllUrl: 'customers.aspx/getCustomers',
                    getOneUrl: 'customers.aspx/getCustomerInfo',
                    saveOneUrl: 'customers.aspx/saveCustomerInfo',
                    addOneUrl: 'customers.aspx/createCustomerInfo',
                    deleteOneUrl: 'customers.aspx/deleteCustomer',
                    onComplete: function () {
                        $(this).find("#home").mask('(000)-000-0000');
                        $(this).find("#work").mask('(000)-000-0000');
                        $(this).find("#mobile").mask('(000)-000-0000');
                        $(this).find("#bldg").mask('0000');
                        $(this).find("#unit").mask('0000');
                        $(this).find("#postal").mask('S0S 0S0');
                        $("#area").on('change', function () { alert('changed!'); });

                    },
                    formFields: {
                        CustomerID: {
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
                        JoinDate: {
                            domid: 'join',
                            title: 'Join Date',
                            type: 'text',
                            enabled: 'false',
                            notForAdd: 'true'
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
                        Status: {
                            domid: 'status',
                            title: 'Active',
                            type: 'checkbox',
                            states: { 'checked': 'Active', 'unchecked': 'Inactive' }
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
                        Area: {
                            domid: 'area',
                            title: 'Square Footage',
                            type: 'select',
                            options: {
                                '1' : '<649 sq ft',
                                '2' : '650-999 sq ft',
                                '3' : '1000-1499 sq ft',
                                '4' : '1500-1999 sq ft',
                                '5' : '2000-2499 sq ft',
                                '6' : '2500-2999 sq ft',
                                '7' : '3000+ sq ft'
                            },
                            callback: function () {
                                $("#" + this.domid).on('change', function() { alert('changed!'); });
                            }
                        },  
                        HouseType: {
                            domid: 'housetype',
                            title: 'Property Type',
                            type: 'select',
                            options: {
                                '1' : 'Apartment',
                                '2' : 'Condominium',
                                '3' : 'Duplex',
                                '4' : 'Semi-detached',
                                '5' : 'Fully-detached',
                                '6' : 'Townhouse'
                            }
                        },
                        AddressID: {
                            domid: 'addressid',
                            type: 'hidden',
                            notForAdd: 'true'
                        },
                        PersonID: {
                            domid: 'personid',
                            type: 'hidden',
                            notForAdd: 'true'
                        }
                    }   // end of options
                    // if the input field is a checkbox, you need to pass the 2 state values (1/0, true/false, etc)
                }); // end of atlasTable
                $('#customerstable').atlasTooltip({ pos: 'left' });
            });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="pageTitle">    
        <span>Customer Management</span>
    </div>

    <div class="mainDiv" style="width:80%">

        <div id="customerstable">
            <br style="clear: both" />
        </div>
    </div>
    <br />

</asp:Content>

