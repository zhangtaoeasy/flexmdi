
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class EmployeeDepartmentHistory extends ValueObject
	{
		
		public function EmployeeDepartmentHistory(args:*=null):void
		{
			super(args);
		}

		
		public var EmployeeID : Number = 0;
		
		public var DepartmentID : String = "";
		
		public var ShiftID : String = "";
		
		public var StartDate : Date;
		
		public var EndDate : Date;
		
		public var ModifiedDate : Date;
		
		
	}
}



