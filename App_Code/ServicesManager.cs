using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ServicesManager
/// </summary>
public class ServicesManager
{
    hctDBEntities db = new hctDBEntities();

	public ServicesManager()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public List<Room> getRooms()
    {
        return db.Rooms.OrderBy(o=>o.Id).ToList();
    }

    public Room getRoom(int id)
    {
        return db.Rooms.Where(i => i.Id == id).FirstOrDefault();
    }

    public List<RTQApp> getApps()
    {
        return db.RTQApps.OrderBy(o => o.Id).ToList();
    }

    public RTQApp getApp(int id)
    {
        return db.RTQApps.Where(i => i.Id == id).FirstOrDefault();
    }

    public List<RTQApp> getApps(int id)
    {
        return db.RTQApps.Where(i => i.Room_Id == id).ToList();
    }

    public List<RTQOption> getOptions()
    {
        return db.RTQOptions.OrderBy(o => o.Id).ToList();
    }

    public List<RTQOption> getOptions(int id)
    {
        return db.RTQOptions.Where(i => i.RTQApp_Id == id).ToList();
    }

    public List<RTQOptionSub> getOptionSubs()
    {
        return db.RTQOptionSubs.OrderBy(o => o.Id).ToList();
    }


    public RTQOptionSub getSuboption(int id)
    {
        return db.RTQOptionSubs.Where(i => i.Id == id).FirstOrDefault();
    }

    // get list of sub options that match a option
    public List<RTQOptionSub> getOptionSubs(int id)
    {
        return db.RTQOptionSubs.Where(p => p.RTQOption_Id == id).ToList();
    }

    // get a single option
    public RTQOption getOption(int id)
    {
        return db.RTQOptions.Where(i=>i.Id == id).FirstOrDefault();
    }
}