
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class EmployeePayHistory extends ValueObject
	{
		
		public function EmployeePayHistory(args:*=null):void
		{
			super(args);
		}

		
		public var EmployeeID : Number = 0;
		
		public var RateChangeDate : Date;
		
		public var Rate : String = "";
		
		public var PayFrequency : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



