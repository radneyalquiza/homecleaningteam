using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.IO;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Web.Hosting;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Web.Script.Serialization;

[ScriptService]
public partial class admin_employees_employees : System.Web.UI.Page
{
    static EmployeeManager emp;
    static DynamicElements de;

    protected void Page_Load(object sender, EventArgs e)
    {
        emp = new EmployeeManager();
        de = new DynamicElements();
    }

    [WebMethod()]
    [ScriptMethod(UseHttpGet = true)]
    public static List<EmployeeDTOTable> getEmployees()
    {
        return emp.getEmployees();
    }

    [WebMethod()]
    public static EmployeeDTO getEmployeeInfo(string id)
    {
        EmployeeDTO i = emp.getEmployeeById(id);
        return i;
    }

    [WebMethod()]
    public static string saveEmployeeInfo(string EmployeeID, int AddressID,
        string FirstName, string LastName, string Rate, string Type, string Status, string HomePhone, string WorkPhone,
        string MobilePhone, string Email1, string Email2, string Bldg, string Unit, string Street, string City,
        string Postal)
    {

        bool ret = emp.updateEmployee(EmployeeID, AddressID, FirstName, LastName, Status,
                                            HomePhone, WorkPhone, MobilePhone, Email1, Email2, Bldg, Unit, Street, City,
                                            Postal);
        if (ret == true)
            return "Success";
        else
            return "Fail";
    }
    
    [WebMethod()]
    public static EmployeeDTO createEmployeeInfo(string FirstName, string LastName, string Status, string Type, string Rate, string HomePhone, string WorkPhone,
        string MobilePhone, string Email1, string Email2, string Bldg, string Unit, string Street, string City,
        string Postal)
    {
        EmployeeDTO ret = emp.createEmployee(FirstName, LastName, Status, Type, Rate, HomePhone, WorkPhone,
                                            MobilePhone, Email1, Email2, Bldg, Unit, Street, City, Postal);
        if (ret != null)
            return ret;
        else
            return null;
    }

    [WebMethod()]
    public static string deleteEmployee(string ID)
    {
        bool ret = emp.deleteEmployee(ID);
        return ret.ToString().ToLower();
    }

}