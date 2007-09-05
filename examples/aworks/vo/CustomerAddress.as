
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class CustomerAddress extends ValueObject
	{
		
		public function CustomerAddress(args:*=null):void
		{
			super(args);
		}

		
		public var CustomerID : Number = 0;
		
		public var AddressID : Number = 0;
		
		public var AddressTypeID : Number = 0;
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



