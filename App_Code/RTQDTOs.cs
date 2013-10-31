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