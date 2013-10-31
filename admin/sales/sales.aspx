<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="sales.aspx.cs" Inherits="admin_sales_sales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
       
    <script>
        $(function ($) {
            $("#invoicestable").atlasTable({
                header: 'Invoice Records',
                editable: true,
                //showInlineControls: false,
                getAllUrl: 'sales.aspx/getInvoices',
                getOneUrl: 'sales.aspx/getInvoiceInfo',
                saveOneUrl: 'sales.aspx/saveInvoiceInfo',
                addOneUrl: 'sales.aspx/createInvoiceInfo',
                deleteOneUrl: 'sales.aspx/deleteInvoice',
                onComplete: function () {
                    //$(this).find("#rate").mask('00.00');
                    //$(this).find("#home").mask('(000)-000-0000');
                    //$(this).find("#work").mask('(000)-000-0000');
                    //$(this).find("#mobile").mask('(000)-000-0000');
                    //$(this).find("#postal").mask('S0S 0S0');

                    // initialize date picker here
                },
                formFields: {
                    InvoiceID: {
                        domid: 'cid',
                        title: 'Invoice ID',
                        type: 'text',
                        enabled: 'false',
                        notForAdd: 'true'
                    },
                    Name: {
                        domid: 'name',
                        title: 'Name',
                        type: 'text'
                    },
                    DateCreated: {
                        domid: 'create',
                        title: 'Date Created',
                        type: 'text',
                        enabled: 'false'
                    },
                    DateModified: {
                        domid: 'create',
                        title: 'Date Modified',
                        type: 'text',
                        enabled: 'false'
                    },
                    JobStatus: {
                        domid: 'paymentstatus',
                        title: 'Payment Status',
                        type: 'checkbox',
                        states: { 'checked': 'Paid', 'unchecked': 'Pending payment' }
                    },
                    PaymentStatus: {
                        domid: 'jobstatus',
                        title: 'Job Status',
                        type: 'checkbox',
                        states: { 'checked': 'Completed', 'unchecked': 'Pending completion' }
                    },
                    PaymentMethod: {
                        domid: 'paymethod',
                        title: 'Payment Method',
                        type: 'select',
                        options: {
                            'CSH': 'Cash',
                            'DBT': 'Debit Card',
                            'CCD': 'Credit Card',
                            'PAC': 'Pre-Authorized Cheque',
                            'CHQ': 'Cheque',
                            'EMT': 'Email Transfer',
                        }
                    },
                    PaymentDate: {
                        domid: 'paydate',
                        title: 'Payment Date',
                        type: 'text',
                        placeholder: 'Not Available',
                    },
                    CustomerName: {
                        domid: 'customer',
                        title: 'Customer Name',
                        type: 'text',
                        placeholder: 'Not Available',
                    },
                    Quote: {
                        domid: 'quote',
                        title: 'Quote Code',
                        type: 'text',
                        placeholder: 'Not Available',
                    }
                }   // end of options
                // if the input field is a checkbox, you need to pass the 2 state values (1/0, true/false, etc)
            }); // end of atlasTable


            $("#quotestable").atlasTable({
                header: 'Quote Records',
                editable: true,
                //showInlineControls: false,
                getAllUrl: 'sales.aspx/getQuotes',
                getOneUrl: 'sales.aspx/getQuoteInfo',
                saveOneUrl: 'sales.aspx/saveQuoteInfo',
                addOneUrl: 'sales.aspx/createQuoteInfo',
                deleteOneUrl: 'sales.aspx/deleteQuote',
                onComplete: function () {
                    //$(this).find("#rate").mask('00.00');
                    //$(this).find("#home").mask('(000)-000-0000');
                    //$(this).find("#work").mask('(000)-000-0000');
                    //$(this).find("#mobile").mask('(000)-000-0000');
                    //$(this).find("#postal").mask('S0S 0S0');

                    // initialize date picker here
                },
                formFields: {
                    QuoteCode: {
                        domid: 'cid',
                        title: 'Quote Code',
                        type: 'text',
                        enabled: 'false',
                        notForAdd: 'true'
                    },
                    TotalPrice: {
                        domid: 'price',
                        title: 'Total Price',
                        type: 'text'
                    },
                    TotalTime: {
                        domid: 'time',
                        title: 'Total Time',
                        type: 'text'
                    },
                    Name: {
                        domid: 'name',
                        title: 'Quote Name',
                        type: 'text'
                    },
                    Email: {
                        domid: 'email',
                        title: 'Email Used',
                        type: 'text'
                    },
                    HouseItem: {
                        domid: 'houseitem',
                        title: 'Property',
                        type: 'text'
                    },
                    DateCreated: {
                        domid: 'datecreated',
                        title: 'Date Created',
                        type: 'text'
                    }
                }   // end of options
                // if the input field is a checkbox, you need to pass the 2 state values (1/0, true/false, etc)
            }); // end of atlasTable

        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="pageTitle">    
        <span>Sales Management - Invoices & Quotes</span>
    </div>

    <div class="mainDiv" style="width:95%">

        <ul style="list-style:none; display:block; width:100%">
            <li style="display:table-cell; min-height:600px; width:49%;">
                <div id="invoicestable">
                </div>
            </li>
            <li style="display:table-cell; min-height:600px; width:49%;">
                <div id="quotestable">
                </div>
            </li>
       </ul>
    </div>
    <br />

</asp:Content>

