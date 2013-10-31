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

[ScriptService]
public partial class admin_qQuote : System.Web.UI.Page
{
    // these objects will only exist in this page life cycle.
    // one a postback is initiated, all data will be lost.
    static SecondaryEntitiesManager sec;
    static DynamicElements de;
    static ServicesManager serv;
    static EmailNotifications em;
    static RTQManager rtq;

    static int totalRTQTime;

    static int cleaningtypeid;
    static int areaid;
    static int dateid;
    static string propertyname;
    static int housetypeid;
    static string quotecode;

    public static Quote mainQuote;
    public static HouseItem mainHouse;
    public static List<OptionItem> optionlist;

    static List<AppItem> bathapplist;
    static List<AppItem> bedapplist;
    static List<AppItem> kitchenapplist;
    static List<AppItem> diningapplist;
    static List<AppItem> livingapplist;
    static List<AppItem> officeapplist;

    static List<RoomItem> roomlist;

    static string path = HostingEnvironment.ApplicationPhysicalPath + @"PDF\";

    protected void Page_Load(object sender, EventArgs e)
    {
        // initialize manager classes
        sec = new SecondaryEntitiesManager();
        de = new DynamicElements();
        serv = new ServicesManager();
        em = new EmailNotifications();
        rtq = new RTQManager();
        
        // initialize main quote containers
        mainQuote = null;
        mainHouse = null;

        // initialize list items
        optionlist = new List<OptionItem>();

        bathapplist = new List<AppItem>();
        bedapplist = new List<AppItem>();
        kitchenapplist = new List<AppItem>();
        diningapplist = new List<AppItem>();
        livingapplist = new List<AppItem>();
        officeapplist = new List<AppItem>();

        totalRTQTime = 0;

        roomlist = new List<RoomItem>();

        if (!Page.IsPostBack)
        {
            string nam = Request.Form["MethodName"];
            // check the method name, if the JSON call asks for update,
            // call the code behind's Update method,etc
            #region Ajax methods
            if (Request.Form["MethodName"] == "CreateRooms")// same Method Name 
            {
                createRooms();
                return;
            }
            if (Request.Form["MethodName"] == "createServiceData")// same Method Name 
            {
                //createServiceData();
                return;
            }
            #endregion
        }   
    }

    /* a more generic way of dynamically creating rooms depending on user selection */
    public void createRooms()
    {
        List<Room> rooms = serv.getRooms();
        List<RTQApp> apps = serv.getApps();
        List<RTQOption> options = serv.getOptions();
        List<RTQOptionSub> subs = serv.getOptionSubs();

        int num = 0;
        string whichroom = "";
        string nextroom = "";

        foreach (string key in Request.Form.AllKeys)
        {
            // is this key a NumRooms?
            if (key.Contains("NumRooms"))
                num = Convert.ToInt32(Request.Form["NumRooms"].ToString());
            // is this key a WhichRoom??
            if (key.Contains("WhichRoom"))
                whichroom = Request.Form["WhichRoom"].ToString();
            if (key.Contains("NextRoom"))
                nextroom = Request.Form["NextRoom"].ToString();
        }

        string tableCreate = "No records are available...";

        if (rooms != null && apps != null && options != null)
        {
            // call the createRooms from the manager class
            tableCreate = de.createRooms(rooms, apps, options, subs, num, whichroom, nextroom);
        }

        if (tableCreate != "" && tableCreate != null)
            Response.Write(tableCreate);
        else
        {
            tableCreate = "Error while parsing data.";
            Response.StatusCode = 404;
            Response.Write(tableCreate);
        }

        Response.Flush();
        Response.End();

    }

    [WebMethod()]
    public static int createServiceData(string obj, string obj2)
    {
        List<Room> rooms = serv.getRooms();
        List<RTQApp> apps = serv.getApps();
        List<RTQOption> options = serv.getOptions();
        List<RTQOptionSub> subs = serv.getOptionSubs();

        string checks = null;
        string radios = null;

        /*foreach (string key in Request.Form.AllKeys)
        {
            if (key.Contains("obj"))
            {
                checks = Request.Form["obj"].ToString();
                //ar = JsonConvert.DeserializeObject<Area>(Request.Form["obj"]);
            }
            if (key.Contains("obj2"))
            {
                radios = Request.Form["obj2"].ToString();
                //ar = JsonConvert.DeserializeObject<Area>(Request.Form["obj"]);
            }
        }*/

        if (obj != null && obj != "")
            checks = obj;
        if (obj2 != null && obj2 != "")
            radios = obj2;

        string[] checkarray = null;
        
        if(checks != null)
            checkarray = checks.Split(',');

        string[] enumcheckarray = new string[checkarray.Length];
        
        string[] radioarray = null;
        
        if (radios != null )
            radioarray = radios.Split(',');

        string[] enumradioarray = null;
        
        if ( radioarray != null )
            if ( radioarray.Length > 0 )
               enumradioarray = new string[radioarray.Length];

        int totaltime = 0;

        List<RTQOption> optionarray = new List<RTQOption>();

        // start the quote
        
        // start by creating the house
        //HouseItem house = rtq.createHouse("This is an info.-Make sure to separate each point with hyphens.-Ok.", cleaningtypeid);
        
        // then the quote object
        //Quote quote = null;

        if (checkarray.Length > 0)
        {
            // look for the RTQOptions for each id passed by JSON
            for (int i = 0; i < checkarray.Length; i++)
            {
                RTQOption o = serv.getOption(Convert.ToInt32(checkarray[i]));
                if (o.time != null && o.time > 0)
                {
                    totaltime += Convert.ToInt32(o.time);

                    // create the options and suboptions, then attach them to rooms, then attach
                    // them to a house then to a quote

                    // everytime we add to the total time, we must create an optionitem (regardless of ancestry)

                    //OptionItem oi = rtq.createOption(o.name, Convert.ToInt32(o.time));

                    //RTQApp ra = serv.getApp(o.RTQApp_Id);

                    //if (oi != null) optionlist.Add(oi);
                }
                // need another if statement for 0 values (which are values with number variable)
                else
                {
                    // get the suboptions
                    List<RTQOptionSub> subs2 = serv.getOptionSubs(o.Id);

                    if (radioarray != null)
                        if (radioarray.Length > 0)
                            for (int j = 0; j < radioarray.Length; j++)
                            {
                                foreach (RTQOptionSub s in subs2)
                                    if (s.Id == Convert.ToInt32(radioarray[j]))
                                    {
                                        totaltime += Convert.ToInt32(s.time);

                                        //OptionItem oi = rtq.createOption(s.name, Convert.ToInt32(s.time));

                                        //if (oi != null) optionlist.Add(oi);

                                        radioarray[j] = "9999";
                                        break;
                                    }
                            }
                }
            }
            // before returning to the user, add the total rtq time
            totalRTQTime += totaltime;
        }

        return totaltime;

        //Response.Write(JsonConvert.SerializeObject(totaltime));
        //Response.Flush();
        //Response.End();
    }


    // steps in creating a quote
    // 1. HouseItem
    // 2. RoomItems AND/OR Quote
    // 3. AppItems
    // 4. OptionsItems

    // create the quote now
    // (create the house first though)
  /*  [WebMethod()]
    public static string createQuoteObject(string email, string price, int time)
    {
        string quotename = "Default";
        
        mainQuote = null;
        string tablesummary = "No data.";

        if (mainHouse != null && email != "" && email != null && price != "" && time > 0 && quotecode != null)
        {
            mainQuote = rtq.createQuote(mainHouse.Id, email, price, time, quotename, quotecode);
        }

        // once the quote is saved, generate a string to return to the page so that
        // i can canvas it
        tablesummary = getQuoteInfo(quotecode);

        return tablesummary;
    }*/

  /*  [WebMethod()]
    public static string getQuoteInfo(string code)
    {
        string summary = "";

        // begin fetch
        summary = de.createInvoiceImage(code);

        return summary;
    }*/

    // create the house
    [WebMethod()]
    public static HouseItem createHouseObject(string otherinfo, int cleaningtypeid,
                                                string housename, string housetype,
                                                string area, string pets)
    {
        if ( otherinfo != "" && cleaningtypeid > -1 )
            mainHouse = rtq.createHouse(otherinfo, cleaningtypeid, housename, housetype, area, pets);
        return mainHouse;
    }

    // create the room-app-option lists
    [WebMethod()]
    public static int createRoomAppOption(string options, string suboptions, string appname, int roomid)
    {
        // receive the current room and current app, along with the options and sub options

        int totaltime = 0;

        string[] optionarray = null;
        string[] suboptionarray = null;

        // save the options and suboptions into arrays
        if (options != null && options != "")
            optionarray = options.Split(',');
        if (suboptions != null && suboptions != "")
            suboptionarray = suboptions.Split(',');
        
        // option item
        OptionItem oi = null;

        // in this room, create the current app, and its options
        if (roomid > -1)
        {
            // create the app passed
            AppItem a = rtq.createApp(appname, roomid);

            // assuming all goes well, save all options into this current app
            if (a != null)
            {
                // loop through all passed options
                for (int i = 0; i < optionarray.Length; i++)
                {
                    // get the reference RTQ Option object to get data from it
                    RTQOption o = serv.getOption(Convert.ToInt32(optionarray[i]));

                    if (o != null)
                    {
                        if (o.time == null)
                        {
                            if (suboptionarray != null)
                            {
                                // if the option retrieved has null for time, loop through
                                // the accompanying suboptions array (which is the selected suboption)
                                for (int x = 0; x < suboptionarray.Length; x++)
                                {
                                    // get the list of suboptions associated with this option,
                                    // then save the name and time into the optionitem to be saved
                                    List<RTQOptionSub> oslist = serv.getOptionSubs(Convert.ToInt32(o.Id));
                                    foreach (RTQOptionSub os in oslist)
                                    {
                                        if (os.Id == Convert.ToInt32(suboptionarray[x]))
                                        {
                                            RTQApp app = serv.getApp(o.RTQApp_Id);
                                            if (a.name == app.name)
                                            {
                                                oi = rtq.createOption(os.name, Convert.ToInt32(os.time), a.Id);
                                                totaltime += Convert.ToInt32(oi.time);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            RTQApp app = serv.getApp(o.RTQApp_Id);
                            if (app.name == a.name)
                            {
                                oi = rtq.createOption(o.name, Convert.ToInt32(o.time), a.Id);
                                totaltime += Convert.ToInt32(oi.time);
                            }
                        }
                    }
                }
            }
        }

        return totaltime;
    }


    // get a single room
    [WebMethod()]
    public static string callRoom(int roomnum)
    {
        string table = "";
        if (roomnum > 0)
            table = de.callRoom(roomnum);

        return table;
    }


    // create a single room
    [WebMethod()]
    public static int createRoomObject(string room)
    {
        RoomItem r = null;

        if (room != null && room != "")
        {
            r = rtq.createRoom(room, mainHouse.Id);
        }

        if (r != null)
            return Convert.ToInt32(r.Id);
        else
            return -1;  // return a non-existent ID
    }
    
    // complete the quote and prepare the invoice image to the email
    [WebMethod()]
    public static string UploadImage(string imageData, string email)
    {
        string quote = "UNAVAILABLE";
        string filename = DateTime.Now.ToString().Replace("/", "-").Replace(" ", "-").Replace(":", "") + ".png";
        string fileNameWitPath = path + filename;
        using (FileStream fs = new FileStream(fileNameWitPath, FileMode.Create))
        {
            using (BinaryWriter bw = new BinaryWriter(fs))
            {
                byte[] data = Convert.FromBase64String(imageData);
                bw.Write(data);
                bw.Close();
                quote = sendEmail(email, filename, fileNameWitPath);    // call this object's sendemail
                
                return quote;
            }
        }
    }

    [WebMethod()]
    public static string sendEmail(string email, string invoice, string invoicepath)
    {
        // send email
        EmailNotifications em = new EmailNotifications();
        RTQManager rtq = new RTQManager();
        
        try
        {
            em.sendEmail(email, quotecode, invoice, invoicepath);
        }
        catch (Exception e) { quotecode = "Unable to send email. *Invalid email address."; }
        return quotecode;
    }

    [WebMethod()]
    public static void fill()
    {
        //Directory.CreateDirectory(HostingEnvironment.MapPath("~/quoteDetailStorage/test"));
        //de.filldb();
        using (StreamWriter _testData = new StreamWriter(HostingEnvironment.MapPath("~/quoteDetailStorage/data.txt"), true))
        {
            string s = "";
            for (int x = 0; x < 1000; x++)
            {
                OptionItem o = new OptionItem();
                o.name = "TETEETETE";
                o.time = 25;
                o.AppItem_Id = 1;
                _testData.WriteLine(JsonConvert.SerializeObject(o)); // Write the file.
            }
        }  
    }

    [WebMethod()]
    public static List<RoomDataDTO> read(string quotepath)
    {
        using (StreamReader streamReader = File.OpenText(HostingEnvironment.MapPath(quotepath)))
        {
            string myString = streamReader.ReadToEnd();
            streamReader.Close();
            List<RoomDataDTO> temp = JsonConvert.DeserializeObject<List<RoomDataDTO>>(myString);
            return temp;
        }
    }

    [WebMethod()]
    public static string createQuoteFile(List<RoomDataDTO> data)
    {
        quotecode = rtq.generateEstimateCode();
        string quotepath = "~/quoteDetailStorage/" + quotecode + ".rtq";
        using (StreamWriter _testData = new StreamWriter(HostingEnvironment.MapPath(quotepath), true))
        {
            try
            {
                _testData.WriteLine(JsonConvert.SerializeObject(data)); // Write the file.
                return quotepath;
            }
            catch (Exception e) { return "false"; }
        }
    }

    [WebMethod()]
    public static string createQuoteRecord(string quotepath, string email, string price, string time, string qname)
    {
        int time1 = Convert.ToInt32(time);
        rtq.createQuote(price, time1, qname, email, quotecode, quotepath);
        List<RoomDataDTO> data = read(quotepath);
        string summary = de.createInvoiceImage(data);
        return summary;
    }
}