
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class AddressType extends ValueObject
	{
		
		public function AddressType(args:*=null):void
		{
			super(args);
		}

		
		public var AddressTypeID : Number = 0;
		
		public var Name : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



