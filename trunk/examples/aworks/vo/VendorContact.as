
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class VendorContact extends ValueObject
	{
		
		public function VendorContact(args:*=null):void
		{
			super(args);
		}

		
		public var VendorID : Number = 0;
		
		public var ContactID : Number = 0;
		
		public var ContactTypeID : Number = 0;
		
		public var ModifiedDate : Date;
		
		
	}
}



