<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="areas.aspx.cs" Inherits="admin_services_areas" %>

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

    <script src="<%= ResolveUrl("~/Scripts/themes/default.js") %>" type="text/javascript">
    </script>



    <!-- STYLE -->
    <link href="~/Styles/admin.css" rel="stylesheet" type="text/css" />
    <link href="../../../Styles/jquery.jgrowl.css" rel="stylesheet" />
    <link href="../../../Styles/tipTip.css" rel="stylesheet" />

    <!-- MY SCRIPTS -->
             <script>

                 // REMEMBER: EVERY ASP.NET WEB CONTROL SHOULD BE WRAPPED WITH THE CLIENTID
                 // AND SAVED TO A LOCAL VARIABLE TO BE ABLE TO CONTROL IT
                 
                 $(function ($) {
                     var drop = $("#<%=test.ClientID%>");
                     var txt = $("#<%=fromTxt.ClientID%>");

                     $("#addAreaBtn").click(function (e) {
                         showAdd(e);
                     });

                     $("#fromTxt1").tipTip();
                     $("#toTxt1").tipTip();
                     $("#multi1").tipTip();


                     // switch views to editable
                     $("span[class^='replaceable']").click(function () {
                         beginEdit($(this));
                     });

                     // dont save
                     $("input[class^='canc']").click(function () {
                         cancelEdit($(this));
                     });

                     // delete
                     $("input[class^='delBtn']").click(function () {
                         deleteItem($(this), 'DeleteA', 'areas.aspx/deleteArea');
                     });

                     // update
                     // once any OK is clicked
                     $("input[class^='ok']").click(function () {
                         updateItem($(this), 'UpdateA', 'areas.aspx/UpdateArea');
                     });


                     // add
                     $("#addBtn").click(function () {

                         // first, get the values from the textboxes
                         var from = $("#<%=fromTxt.ClientID%>").val();
                         var to = $("#<%=toTxt.ClientID%>").val();
                         var mult = $("#<%=multi.ClientID%>").val();

                         // if one is not entered, remove all data
                         if (from == "" || to == "" || mult == "") {
                             from = "~noval~";
                             to = "~noval~";
                             mult = "~noval~";
                         }

                         // count the number of columns,
                         // which is the number of parameters to be passed in JSON
                         var colCount = $(".displayGrid").find('tr')[0].cells.length;
                         // get the headers of the columns
                         var cols = new Array(colCount);

                         for (var gg = 0; gg < colCount; gg++)
                             cols[gg] = $("tr:first").children("td:eq('" + gg + "')").text();
                         
                         // then send them to the code behind method that
                         // will shove the data into the database
                         // USING AJAX

                         // in this case, combine 2 values to put inside 1 column/parameter

                         // save all the values in an array (RIGHT ORDER)
                         // so you can just loop through them when setting params
                         var dataArr = new Array(colCount - 1);
                         dataArr[0] = from;
                         dataArr[1] = to;
                         dataArr[2] = mult;

                         addItem(cols, dataArr, 'AddA', 'areas.aspx/addArea');

                     });

                    //  when a dropdown list changes value selected
                    // drop.change(function () {
                    //     var selectedVal = $("#<%=test.ClientID%> option:selected").attr('value');
                    //     notify(selectedVal, "success");
                    // });



                 });

            </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h3>Areas (Square Footage) Management</h3>

    <div>
        <!-- Display gridview right away -->
        These are your current square footage options:<br />
        
        <asp:GridView ID="areaList" CssClass="displayGrid" runat="server"></asp:GridView>

        <!-- Dynamically create a table here -->
        <div id="tableData"></div>

        <br />
        <!-- add new area -->
        <input id="addAreaBtn" type="button" class="menuButton" value="Add New Area" />
  
        *Test Dropdown: Will show all areas added*<asp:DropDownList ID="test" runat="server"></asp:DropDownList>
        <asp:GridView ID="GridView1" DataSourceID="ObjectDataSource1" runat="server"></asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="getAreas" TypeName="SecondaryEntitiesManager"></asp:ObjectDataSource>
        <br /><br />
    </div>


            <!--
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////
            POPUP CONTAINERS
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        -->


        <div id="addPage">
            <div class="bClose">x</div>
        <h3>Add New Area</h3>

                <table class="formTable">
                    <tr>
                        <td>
                            <span id="fromTxt1" title="Minimum value of the area range. Must be a NUMBER.">From (sqft):</span>
                        </td>
                        <td>
                            <asp:TextBox ID="fromTxt" cssClass="ttextbox" title="Hello" runat="server"></asp:TextBox><br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="toTxt1" title="Maximum value of the area range. Must be a NUMBER.">To (sqft):</span>
                        </td>
                        <td>
                            <asp:TextBox ID="toTxt" cssClass="ttextbox" runat="server"></asp:TextBox><br />
                            
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="multi1" title="This will be the multiplier for the price. Must be a NUMBER or DECIMAL.">Multiplier:</span>
                        </td>
                        <td>
                            <asp:TextBox ID="multi" cssClass="ttextbox" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            <br />
            <br />

                <input id="addBtn" type="button" value="ADD" />
                <input id="closeAdd" type="button" onclick="notify('Cancelled Adding'); bClose();" value="CLOSE" />
        </div>

		<div id="notification" class="top-right"></div>
    

        <!-- USE THIS TO PASS DATA FROM CLIENT JQUERY TO C# -->
        <asp:HiddenField ID="jqueryData" runat="server" />


</asp:Content>

