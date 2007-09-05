
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class vProductModelInstructions extends ValueObject
	{
		
		public function vProductModelInstructions(args:*=null):void
		{
			super(args);
		}

		
		public var ProductModelID : Number = 0;
		
		public var Name : String = "";
		
		public var Instructions : String = "";
		
		public var LocationID : Number = 0;
		
		public var SetupHours : String = "";
		
		public var MachineHours : String = "";
		
		public var LaborHours : String = "";
		
		public var LotSize : Number = 0;
		
		public var Step : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



