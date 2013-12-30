using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for RTQManager
/// </summary>
public class RTQManager
{
    hctDBEntities db = new hctDBEntities();

    // Generate estimate code
    public string generateEstimateCode()
    {
        string estimateCode = "";

        //generate estimate code
        Random random = new Random();
        String generateChar = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9";
        char[] seperator = { ',' };
        String[] splitChars = generateChar.Split(seperator);
        String[] randomChars = new String[7];

        for (int i = 0; i < 7; i++)
        {
            randomChars[i] = splitChars[random.Next(0, splitChars.Length)];
            estimateCode += randomChars[i];
        }

        return estimateCode;
    }
    
    //=======================================================================================
    // GETS
    //=======================================================================================

    // get the quote info
    public Quote getQuote(string quotecode)
    {
        return db.Quotes.Where(i => i.quoteCode == quotecode).FirstOrDefault();
    }

    // get the house info
    public HouseItem getHouse(int id)
    {
        return db.HouseItems.Where(i => i.Id == id).FirstOrDefault();
    }

    // get list of rooms in the house
    public List<RoomItem> getRoomsForHouse(int id)
    {
        return db.RoomItems.Where(i => i.HouseItem_Id == id).ToList();
    }

    // get list of apps for a room
    public List<AppItem> getAppsForRoom(int id)
    {
        return db.AppItems.Where(i => i.RoomItem_Id == id).ToList();
    }

    // get list of options for an apps
    public List<OptionItem> getOptionsForApp(int id)
    {
        return db.OptionItems.Where(i => i.AppItem_Id == id).ToList();
    }

    // get list of quotes
    public List<Quote> getQuotes()
    {
        return db.Quotes.OrderBy(i => i.Id).ToList();
    }

    public List<HouseItem> getHouses()
    {
        return db.HouseItems.OrderBy(i => i.otherInfo).ToList();
    }

    public List<Invoice> getInvoices()
    {
        return db.Invoices.OrderBy(i => i.Id).ToList();
    }


    //=======================================================================================
    // RTQ OPTIONS BUILDER
    //=======================================================================================

    // this will usually return at least 2 RoomDataDTOs, which are
    // 1. The filtered options by the cleaning type
    // 2. All the available options
    public List<RoomDataOutDTO> getRoomData(string roomname, string type)
    {
        Room room = db.Rooms.Where(i => i.name.ToLower().Trim() == roomname.ToLower().Trim()).FirstOrDefault();
        List<RTQApp> apps = db.RTQApps.Where(i => i.Room_Id == room.Id).ToList();

        List<RoomDataOutDTO> rdtolist = new List<RoomDataOutDTO>();

        RoomDataOutDTO rdto = new RoomDataOutDTO();
        RoomDataOutDTO rdtodefault = new RoomDataOutDTO();

        rdtodefault.RoomName = roomname;
        rdto.RoomName = roomname;
        List<RoomDataOutDTO.App> applist = new List<RoomDataOutDTO.App>();
        List<RoomDataOutDTO.App> applistDef = new List<RoomDataOutDTO.App>();
        foreach (RTQApp a in apps)
        {
            RoomDataOutDTO.App ap = new RoomDataOutDTO.App();
            RoomDataOutDTO.App apdef = new RoomDataOutDTO.App();
            ap.AppName = a.name;
            apdef.AppName = a.name;

            List<RTQOption> optionsdef = db.RTQOptions.Where(i => i.RTQApp_Id == a.Id).ToList(); // all
            List<RTQOption> options = optionsdef.Where(x => x.ctype.Contains(type) || x.ctype.Contains("N/A")).ToList(); // filter
            optionsdef = optionsdef.Where(x => !x.ctype.Contains(type)).ToList();

            // THIS BLOCK IS FOR FILTERED OPTIONS
            List<RoomDataOutDTO.Option> dtoptions = new List<RoomDataOutDTO.Option>();
            foreach (RTQOption o in options)
            {
                RoomDataOutDTO.Option dtoo = new RoomDataOutDTO.Option();
                dtoo.OptionName = o.name;

                // if this option has multiple sub options (which makes this option's time a null),
                // search for the suboptions that are linked to this option and save them into a
                // collection to return to the application
                if (o.time == null)
                {
                    // list of data from the db to map from
                    // use this to filter subs: .Where(x => x.ctype.Contains(type))
                    List<RTQOptionSub> subs = db.RTQOptionSubs.Where(i => i.RTQOption_Id == o.Id).ToList();
                    // list of data created as a view to map into
                    List<RoomDataOutDTO.Sub> dtosubs = new List<RoomDataOutDTO.Sub>();
                    foreach (RTQOptionSub os in subs)
                    {
                        RoomDataOutDTO.Sub s = new RoomDataOutDTO.Sub();
                        s.OptionName = os.name;
                        s.TimeUnit = os.time.ToString();
                        s.CType = os.ctype;
                        dtosubs.Add(s);
                    }
                    dtoo.Subs = dtosubs.ToArray();
                }
                else
                {
                    // map the data to the RTQOptionData DTO
                    dtoo.TimeUnit = o.time.ToString();
                    dtoo.CType = o.ctype;
                }
                dtoptions.Add(dtoo);
            }
            // after the option loop, cast the option list into an option array
            // and store the data into the dto's Apps.Options array
            ap.Options = dtoptions.ToArray();
            applist.Add(ap);


            // THIS BLOCK IS FOR EXTRA OPTIONS
            List<RoomDataOutDTO.Option> dtoptions2 = new List<RoomDataOutDTO.Option>();
            foreach (RTQOption o in optionsdef)
            {
                RoomDataOutDTO.Option dtoo = new RoomDataOutDTO.Option();
                dtoo.OptionName = o.name;

                // if this option has multiple sub options (which makes this option's time a null),
                // search for the suboptions that are linked to this option and save them into a
                // collection to return to the application
                if (o.time == null)
                {
                    // list of data from the db to map from
                    List<RTQOptionSub> subs = db.RTQOptionSubs.Where(i => i.RTQOption_Id == o.Id).ToList();
                    // list of data created as a view to map into
                    List<RoomDataOutDTO.Sub> dtosubs = new List<RoomDataOutDTO.Sub>();
                    foreach (RTQOptionSub os in subs)
                    {
                        RoomDataOutDTO.Sub s = new RoomDataOutDTO.Sub();
                        s.OptionName = os.name;
                        s.TimeUnit = os.time.ToString();
                        s.CType = os.ctype;
                        dtosubs.Add(s);
                    }
                    dtoo.Subs = dtosubs.ToArray();
                }
                else
                {
                    // map the data to the RTQOptionData DTO
                    dtoo.TimeUnit = o.time.ToString();
                    dtoo.CType = o.ctype;
                }
                dtoptions2.Add(dtoo);
            }
            // after the option loop, cast the option list into an option array
            // and store the data into the dto's Apps.Options array
            apdef.Options = dtoptions2.ToArray();
            applistDef.Add(apdef);
        }
        rdto.Apps = applist.ToArray();
        rdtodefault.Apps = applistDef.ToArray();
        // at the end, we will have a room objects that contain all apps and options
        // for javascript to format
        rdtolist.Add(rdto);
        rdtolist.Add(rdtodefault);
        return rdtolist;
    }

    // get all rooms depending on cleaning type
    public List<List<RoomDataOutDTO>> getAllRoomData(string cleaningtype)
    {
        // lookup data
        List<Room> rooms = db.Rooms.OrderBy(x=>x.description).ToList();
        // this will contain a list of roomdataouts that contain 2 more roomdataouts
        List<List<RoomDataOutDTO>> roomsout = new List<List<RoomDataOutDTO>>();

        foreach (Room r in rooms)
        {
            // create an internal list of roomdataout (1 is the filtered, 1 is the defaults)
            List<RoomDataOutDTO> roomsoutinner = new List<RoomDataOutDTO>();
            RoomDataOutDTO rdto = new RoomDataOutDTO();
            RoomDataOutDTO rdtodefault = new RoomDataOutDTO();

            List<RTQApp> apps = db.RTQApps.Where(i => i.Room_Id == r.Id).OrderBy(x=>x.description).ToList();

            rdtodefault.RoomName = r.name;
            rdto.RoomName = r.name;
            List<RoomDataOutDTO.App> applist = new List<RoomDataOutDTO.App>();
            List<RoomDataOutDTO.App> applistDef = new List<RoomDataOutDTO.App>();

            foreach (RTQApp a in apps)
            {
                RoomDataOutDTO.App ap = new RoomDataOutDTO.App();
                RoomDataOutDTO.App apdef = new RoomDataOutDTO.App();
                ap.AppName = a.name;
                apdef.AppName = a.name;

                List<RTQOption> optionsdef = db.RTQOptions.Where(i => i.RTQApp_Id == a.Id).ToList(); // all
                List<RTQOption> options = optionsdef.Where(x => x.ctype.Contains(cleaningtype) || x.ctype.Contains("N/A")).ToList(); // filter
                //if (cleaningtype != "deep-prm")
                //optionsdef = optionsdef.Where(x => !x.ctype.Contains(cleaningtype) && !x.ctype.Contains("N/A")).ToList();

                // THIS BLOCK IS FOR FILTERED OPTIONS
                List<RoomDataOutDTO.Option> dtoptions = new List<RoomDataOutDTO.Option>();
                foreach (RTQOption o in options)
                {
                    RoomDataOutDTO.Option dtoo = new RoomDataOutDTO.Option();
                    dtoo.OptionName = o.name;

                    // if this option has multiple sub options (which makes this option's time a null),
                    // search for the suboptions that are linked to this option and save them into a
                    // collection to return to the application
                    if (o.time == null)
                    {
                        // list of data from the db to map from
                        // use this to filter subs: .Where(x => x.ctype.Contains(type))
                        List<RTQOptionSub> subs = db.RTQOptionSubs.Where(i => i.RTQOption_Id == o.Id).ToList();
                        // list of data created as a view to map into
                        List<RoomDataOutDTO.Sub> dtosubs = new List<RoomDataOutDTO.Sub>();
                        foreach (RTQOptionSub os in subs)
                        {
                            RoomDataOutDTO.Sub s = new RoomDataOutDTO.Sub();
                            s.OptionName = os.name;
                            s.TimeUnit = os.time.ToString();
                            s.CType = os.ctype;
                            dtosubs.Add(s);
                        }
                        dtoo.CType = o.ctype;
                        dtoo.Subs = dtosubs.ToArray();
                    }
                    else
                    {
                        // map the data to the RTQOptionData DTO
                        dtoo.TimeUnit = o.time.ToString();
                        dtoo.CType = o.ctype;
                    }
                    
                    dtoptions.Add(dtoo);
                }
                // after the option loop, cast the option list into an option array
                // and store the data into the dto's Apps.Options array
                ap.Options = dtoptions.ToArray();
                applist.Add(ap);


                // THIS BLOCK IS FOR EXTRA OPTIONS
                List<RoomDataOutDTO.Option> dtoptions2 = new List<RoomDataOutDTO.Option>();
                foreach (RTQOption ox in optionsdef)
                {
                    RoomDataOutDTO.Option dtoo = new RoomDataOutDTO.Option();
                    dtoo.OptionName = ox.name;

                    // if this option has multiple sub options (which makes this option's time a null),
                    // search for the suboptions that are linked to this option and save them into a
                    // collection to return to the application
                    if (ox.time == null)
                    {
                        // list of data from the db to map from
                        List<RTQOptionSub> subs = db.RTQOptionSubs.Where(i => i.RTQOption_Id == ox.Id).ToList();
                        //&& i.ctype.Contains("routine-std,routine-prm,deep-std,deep-prm")
                        // list of data created as a view to map into
                        List<RoomDataOutDTO.Sub> dtosubs = new List<RoomDataOutDTO.Sub>();
                        foreach (RTQOptionSub osx in subs)
                        {
                            RoomDataOutDTO.Sub s = new RoomDataOutDTO.Sub();
                            s.OptionName = osx.name;
                            s.TimeUnit = osx.time.ToString();
                            s.CType = osx.ctype;
                            dtosubs.Add(s);
                        }
                        dtoo.CType = ox.ctype;
                        dtoo.Subs = dtosubs.ToArray();
                    }
                    else
                    {
                        // map the data to the RTQOptionData DTO
                        dtoo.TimeUnit = ox.time.ToString();
                        dtoo.CType = ox.ctype;
                    }
                    dtoptions2.Add(dtoo);
                }
                // after the option loop, cast the option list into an option array
                // and store the data into the dto's Apps.Options array
                apdef.Options = dtoptions2.ToArray();
                applistDef.Add(apdef);
            }
            rdto.Apps = applist.ToArray();
            rdtodefault.Apps = applistDef.ToArray();
            // at the end, we will have a room objects that contain all apps and options
            // for javascript to format
            roomsoutinner.Add(rdto);
            roomsoutinner.Add(rdtodefault);
            // finally, add this list (2) of roomdataouts into the master list of rooms
            roomsout.Add(roomsoutinner);
        }
        return roomsout;
    }




    //=======================================================================================
    // CREATES
    //=======================================================================================

    // create an invoice attaching a quote
    public Invoice createInvoice(int qid, int cid, string quote)
    {
        Invoice i = new Invoice();

        if ( i != null)
        {
            // need name, customer, etc
            i.Quote_Id = qid;
            i.Customer_Id = cid;
            i.dateCreated = DateTime.Now;
            i.InvoiceID = quote;
            i.paymentStatus = "Not paid";
            i.jobStatus = "Set";
            db.Invoices.AddObject(i);
            db.SaveChanges();
            return i;
        }
        else
            return null;
    }

    // Create a quote while attaching a house item
    public Quote createQuote(string tprice, int ttime, string quotename, string email, string quotecode, string quotepath)
    {
        Quote q = new Quote();
        decimal price;

            //q.HouseItem_Id = houseid;
            if (decimal.TryParse(tprice, out price))
            {
                q.totalPrice = price;
            }
            q.totalTime = ttime;
            q.name = quotename;
            q.quoteCode = quotecode;
            q.email = email;
            q.quotePath = quotepath;
            db.Quotes.AddObject(q);
            db.SaveChanges();
            return q;
    }

    // Create a house item attaching room lists
    public HouseItem createHouse(string otherinfo, int cleaningtypeid, string housename, string housetype,
                                    string area, string pets)
    {
        HouseItem h = new HouseItem();

        if (otherinfo != null && otherinfo != "")
        {
            //h.RoomItems = rooms;    // save a list of the rooms into the house
            h.otherInfo = otherinfo;    // just text
            h.CleaningType_Id = cleaningtypeid;
            h.HouseName = housename;
            h.HouseType = housetype;
            h.Area = area;
            h.Pets = pets;
            db.HouseItems.AddObject(h);
            db.SaveChanges();
            return h;
        }
        else
            return null;
    }

    // Create a room item attaching applicance lists
    public RoomItem createRoom(string roomname, int houseid)
    {
        RoomItem r = new RoomItem();

        if (houseid > -1 && roomname != null && roomname != "")
        {
            r.name = roomname;
            r.HouseItem_Id = houseid;
            r.nickName = "";
            db.RoomItems.AddObject(r);
            db.SaveChanges();
            return r;
        }
        else
            return null;
    }

    // create an appliance item attaching option lists
    public AppItem createApp(string name, int roomid)
    {
        AppItem a = new AppItem();

        if (name != "" && name != null && roomid > -1)
        {
            a.name = name;
            a.RoomItem_Id = roomid;
            db.AppItems.AddObject(a);
            db.SaveChanges();
            return a;
        }
        else
            return null;
    }


    // Create a option item
    public OptionItem createOption(string name, int time, int appid)
    {
        OptionItem o = new OptionItem();

        if (name != "" && name != null && time > 0 && time > -1)
        {
            o.name = name;
            o.time = time;
            o.AppItem_Id = appid;
            db.OptionItems.AddObject(o);
            db.SaveChanges();
            return o;
        }
        else
            return null;
    }
}