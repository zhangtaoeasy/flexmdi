
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class Location extends ValueObject
	{
		
		public function Location(args:*=null):void
		{
			super(args);
		}

		
		public var LocationID : String = "";
		
		public var Name : String = "";
		
		public var CostRate : String = "";
		
		public var Availability : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



