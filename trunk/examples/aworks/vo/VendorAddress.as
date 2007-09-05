
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class VendorAddress extends ValueObject
	{
		
		public function VendorAddress(args:*=null):void
		{
			super(args);
		}

		
		public var VendorID : Number = 0;
		
		public var AddressID : Number = 0;
		
		public var AddressTypeID : Number = 0;
		
		public var ModifiedDate : Date;
		
		
	}
}



