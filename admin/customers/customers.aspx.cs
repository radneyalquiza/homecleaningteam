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
public partial class admin_customers_customers : System.Web.UI.Page
{
    static RTQManager rtq;
    static SalesManager sales;
    static ServicesManager serv;
    static CustomerManager customer;
    static DynamicElements de;

    protected void Page_Load(object sender, EventArgs e)
    {
        rtq = new RTQManager();
        sales = new SalesManager();
        serv = new ServicesManager();
        customer = new CustomerManager();
        de = new DynamicElements();
    }

    [WebMethod()]
    [ScriptMethod(UseHttpGet = true)]
    public static List<CustomerDTOTable> getCustomers()
    {
       return customer.getCustomers();
    }

    [WebMethod()]
    public static CustomerDTO getCustomerInfo(string id)
    {
        CustomerDTO i = customer.getCustomerById(id);
        return i;
    }
    
    [WebMethod()]
    public static string saveCustomerInfo(string CustomerID, int PersonID, int AddressID,
        string FirstName, string LastName, string Status, string HomePhone, string WorkPhone,
        string MobilePhone, string Email1, string Email2, string Bldg, string Unit, string Street, string City,
        string Postal, string HouseType, string Area) {

            bool ret = customer.updateCustomer(CustomerID, PersonID, AddressID, FirstName, LastName, Status,
                                                HomePhone, WorkPhone, MobilePhone, Email1, Email2, Bldg, Unit, Street, City,
                                                Postal, HouseType, Area);
            if (ret == true)
                return "Success";
            else
                return "Fail";
    }

    [WebMethod()]
    public static CustomerDTO createCustomerInfo(string FirstName, string LastName, string Status, string HomePhone, string WorkPhone,
        string MobilePhone, string Email1, string Email2, string Bldg, string Unit, string Street, string City,
        string Postal, string Area, string HouseType)
    {
        CustomerDTO ret = customer.createCustomer(FirstName, LastName, Status, HomePhone, WorkPhone,
                                            MobilePhone, Email1, Email2, Bldg, Unit, Street, City, Postal, Area, HouseType);
        if (ret != null)
            return ret;
        else
            return null;
    }

    [WebMethod()]
    public static string deleteCustomer(string ID)
    {
        bool ret = customer.deleteCustomer(ID);
        return ret.ToString().ToLower();
    }

    [WebMethod()]
    public static string generateCustomerID()
    {
        string iddate = customer.generateCustomerId();
        iddate += "@" + DateTime.Now;
        return iddate;
    }
}