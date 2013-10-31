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