
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class vEmployeeDepartment extends ValueObject
	{
		
		public function vEmployeeDepartment(args:*=null):void
		{
			super(args);
		}

		
		public var EmployeeID : Number = 0;
		
		public var Title : String = "";
		
		public var FirstName : String = "";
		
		public var MiddleName : String = "";
		
		public var LastName : String = "";
		
		public var Suffix : String = "";
		
		public var JobTitle : String = "";
		
		public var Department : String = "";
		
		public var GroupName : String = "";
		
		public var StartDate : Date;
		
		
	}
}



