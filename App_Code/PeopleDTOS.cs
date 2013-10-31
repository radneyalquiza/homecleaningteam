using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PeopleDTOS
/// </summary>
public class PeopleDTOS
{
	public PeopleDTOS()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}

public class CustomerDTOTable
{
    protected internal CustomerDTOTable() { }
    public string CustomerID;
    public string FirstName;
    public string LastName;
    public string Status;
    public string JoinDate;
}

public class CustomerDTO
{
    protected internal CustomerDTO() { }
    public int AddressID;   // these need to be hidden
    public int PersonID;

    public string CustomerID;
    public string FirstName;
    public string LastName;
    public string Status;
    public string JoinDate;
    public string HomePhone;
    public string WorkPhone;
    public string MobilePhone;
    public string Email1;
    public string Email2;

    public string Bldg;
    public string Unit;
    public string Street;
    public string City;
    public string Postal;

    public string HouseType;
    public string Area;
}

public class EmployeeDTOTable
{
    protected internal EmployeeDTOTable() { }
    public string EmployeeID;
    public string FirstName;
    public string LastName;
    public string Status;
    public string Rate;
    public string Email1;
    public string HomePhone;
    public string MobilePhone;
}

public class EmployeeDTO
{
    protected internal EmployeeDTO() { }
    public int AddressID;   // these need to be hidden

    public string EmployeeID;
    public string FirstName;
    public string LastName;
    public string Status;
    public string Type;
    public string Rate;
    public string HireDate;
    public string RemoveDate;
    public string HomePhone;
    public string WorkPhone;
    public string MobilePhone;
    public string Email1;
    public string Email2;

    public string Bldg;
    public string Unit;
    public string Street;
    public string City;
    public string Postal;
}