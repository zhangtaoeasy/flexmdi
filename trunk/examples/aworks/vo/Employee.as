
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class Employee extends ValueObject
	{
		
		public function Employee(args:*=null):void
		{
			super(args);
		}

		
		public var EmployeeID : Number = 0;
		
		public var NationalIDNumber : String = "";
		
		public var ContactID : Number = 0;
		
		public var LoginID : String = "";
		
		public var ManagerID : Number = 0;
		
		public var Title : String = "";
		
		public var BirthDate : Date;
		
		public var MaritalStatus : String = "";
		
		public var Gender : String = "";
		
		public var HireDate : Date;
		
		public var SalariedFlag : String = "";
		
		public var VacationHours : String = "";
		
		public var SickLeaveHours : String = "";
		
		public var CurrentFlag : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



