
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class Shift extends ValueObject
	{
		
		public function Shift(args:*=null):void
		{
			super(args);
		}

		
		public var ShiftID : String = "";
		
		public var Name : String = "";
		
		public var StartTime : Date;
		
		public var EndTime : Date;
		
		public var ModifiedDate : Date;
		
		
	}
}



