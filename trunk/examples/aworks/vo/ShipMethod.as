
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ShipMethod extends ValueObject
	{
		
		public function ShipMethod(args:*=null):void
		{
			super(args);
		}

		
		public var ShipMethodID : Number = 0;
		
		public var Name : String = "";
		
		public var ShipBase : String = "";
		
		public var ShipRate : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



