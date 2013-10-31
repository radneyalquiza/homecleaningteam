using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class admin_quickQuote : System.Web.UI.Page
{
    SecondaryEntitiesManager sec;
    DynamicElements de;
    ServicesManager serv;
    EmailNotifications em;
    RTQManager rtq;

    protected void Page_Load(object sender, EventArgs e)
    {
        sec = new SecondaryEntitiesManager();
        de = new DynamicElements();
        serv = new ServicesManager();
        em = new EmailNotifications();
        rtq = new RTQManager();

        if (!IsPostBack)
        {/*
            if (Request.Form["MethodName"] == "GetL")
            {
                getList();
                return;
            }*/

            //generateRooms();
        }
    }
    /*
    public void generateRooms()
    {
        List<Room> rooms = serv.getRooms();
        List<RTQApp> apps = serv.getApps();
        List<RTQOption> options = serv.getOptions();

        //List<Invoice> inv = sec.getInvoices();
        //List<CleaningType> cl = sec.getCleaningTypes();
        string tableCreate = "No records in the database..";

        // you must send also the NAVIGATION PROPERTIES so that i won't have to display them IF i don't want to
        //List<string> types = new List<string>();
        //types.Add(new Customer().GetType());
        //types.Add(new Quote().GetType());
        //types.Add("Property");
        //types.Add(new HouseItem().GetType());

        if (rooms != null && apps != null && options != null)
        {
            tableCreate = de.createRooms(rooms, apps, options);
        }
        //tableCreate = de.populateTable(o, types, cl);

        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script>makeRooms(\"" + tableCreate + "\");</script>", false);

    }


    // *************************************************************************
    // STATIC METHODS - for sending json data to jquery
    // *************************************************************************

    // using this, you can pass data between jquery/ajax and C#
    [WebMethod]
    public static string getAreaList()
    {
        SecondaryEntitiesManager sec = new SecondaryEntitiesManager();
        List<Area> g = sec.getAreas();

        var coll = g.Select(x => new
        {
            fromMin = x.fromMin,
            toMax = x.toMax,
            id = x.Id
        });

        //return Json(coll, JsonRequestBehavior.AllowGet);
        
        var settings = new JsonSerializerSettings
                           {
                               ReferenceLoopHandling = ReferenceLoopHandling.Ignore
                           };

        //return 
        return JsonConvert.SerializeObject(coll, Formatting.Indented, settings);
        

        //return g;
    }

    [WebMethod]
    public static List<CleaningType> getCTypeList()
    {
        SecondaryEntitiesManager sec = new SecondaryEntitiesManager();
        List<CleaningType> g = sec.getCleaningTypes();
        return g;
    }

    [WebMethod]
    public static string sendEmail(string email)
    {
        // send email
        EmailNotifications em = new EmailNotifications();
        RTQManager rtq = new RTQManager();

        string quote = rtq.generateEstimateCode();

        try
        {
            em.sendEmail(email, quote);
        }
        catch (Exception e) { quote = "Unable to send email. *No email entered."; }
        return quote;
    }*/

}