
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class StoreContact extends ValueObject
	{
		
		public function StoreContact(args:*=null):void
		{
			super(args);
		}

		
		public var CustomerID : Number = 0;
		
		public var ContactID : Number = 0;
		
		public var ContactTypeID : Number = 0;
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



