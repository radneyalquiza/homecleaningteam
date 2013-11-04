using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for RTQDTOs
/// </summary>
public class RTQDTOs
{
	public RTQDTOs()
	{
		//
		// TODO: Add constructor logic here
		//
	}

}

// ===================================================================
// RTQ's ROOM DATA INPUTS FROM USER
// ===================================================================
// this DTO is for saving the RTQ Quote data into .rtq files
public class RoomDataDTO
{
    public RoomDataDTO() { }

    public class Option {
        public Option() {}
        public string TimeUnit;
        public string OptionName;
    }

    public class App {
        public App() {}
        public string AppName;
        public Option[] Options; 
    }

    public string RoomName;
    public string FloorType;
    public App[] Apps;
}

// ===================================================================
// RTQ's ROOM DATA OUTPUTS TO USER
// ===================================================================
// this DTO is for parsing RTQ Quote data into the application
public class RoomDataOutDTO
{
    public RoomDataOutDTO() { }

    public class Sub
    {
        public Sub() { }
        public string TimeUnit;
        public string OptionName;
        public string CType;
    }
    public class Option
    {
        public Option() { }
        public string TimeUnit;
        public string OptionName;
        public string CType;
        public Sub[] Subs;
    }

    public class App
    {
        public App() { }
        public string AppName;
        public Option[] Options;
    }

    public string RoomName;
    public App[] Apps;
}