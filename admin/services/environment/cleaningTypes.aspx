<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPage.master" AutoEventWireup="true" CodeFile="cleaningTypes.aspx.cs" Inherits="admin_services_cleaningTypes" %>

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

    <script src="<%= ResolveUrl("~/Scripts/jquery.ddslick.min.js") %>" type="text/javascript">
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

                     $("#addCTypeBtn").click(function (e) {
                         showAdd(e);
                     });

                     $("#titleTxt1").tipTip();
                     $("#descTxt1").tipTip();
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
                         deleteItem($(this), 'DeleteC', 'cleaningTypes.aspx/deleteCtype');
                     });

                     // update
                     // once any OK is clicked
                     $("input[class^='ok']").click(function () {
                         alert("ds");
                         updateItem($(this), 'UpdateC', 'cleaningTypes.aspx/UpdateCtype');
                     });


                     // add
                     $("#addBtn").click(function () {

                         // first, get the values from the textboxes
                         var title = $("#<%=titleTxt.ClientID%>").val();
                         var desc = $("#<%=descTxt.ClientID%>").val();
                         var mult = $("#<%=multi.ClientID%>").val();

                         // if one is not entered, remove all data
                         if (title == "" || desc == "" || mult == "") {
                             title = "~noval~";
                             desc = "~noval~";
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
                         dataArr[0] = title;
                         dataArr[1] = mult;
                         dataArr[2] = desc;

                         addItem(cols, dataArr, 'AddC', 'cleaningTypes.aspx/addCType');

                     });

                     //  when a dropdown list changes value selected
                     // drop.change(function () {
                     //     var selectedVal = $("#< option:selected").attr('value');
                     //     notify(selectedVal, "success");
                     // });

                     

                 });

            </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h3>Cleaning/Service Type Management</h3>

    <div>
        <!-- Display gridview right away -->
        These are your current Service Type options:<br />
        
        <asp:GridView ID="areaList" CssClass="displayGrid" runat="server"></asp:GridView>

        <!-- Dynamically create a table here -->
        <div id="tableData"></div>

        <br />
        <!-- add new area -->
        <input id="addCTypeBtn" type="button" class="menuButton" value="Add New Cleaning/Service Type" />
  
        <br /><br />
        <select id="dd1">
        </select>
    </div>

    <!-- POPUP -->
        <div id="addPage">
            <div class="bClose">x</div>
        <h3>Add New Cleaning/Service Type</h3>

                <table class="formTable">
                    <tr>
                        <td>
                            <span id="title1" title="Enter a title for the Service Type.">Title:</span>
                        </td>
                        <td>
                            <asp:TextBox ID="titleTxt" cssClass="ttextbox" runat="server"></asp:TextBox><br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="descTxt1" title="Description for the service.">Description:</span>
                        </td>
                        <td>
                            <asp:TextBox ID="descTxt" cssClass="ttextbox" runat="server"></asp:TextBox><br />
                            
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
</asp:Content>

