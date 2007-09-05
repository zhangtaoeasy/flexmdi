
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class vEmployeeDepartmentHistory extends ValueObject
	{
		
		public function vEmployeeDepartmentHistory(args:*=null):void
		{
			super(args);
		}

		
		public var EmployeeID : Number = 0;
		
		public var Title : String = "";
		
		public var FirstName : String = "";
		
		public var MiddleName : String = "";
		
		public var LastName : String = "";
		
		public var Suffix : String = "";
		
		public var Shift : String = "";
		
		public var Department : String = "";
		
		public var GroupName : String = "";
		
		public var StartDate : Date;
		
		public var EndDate : Date;
		
		
	}
}



