
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class Store extends ValueObject
	{
		
		public function Store(args:*=null):void
		{
			super(args);
		}

		
		public var CustomerID : Number = 0;
		
		public var Name : String = "";
		
		public var SalesPersonID : Number = 0;
		
		public var Demographics : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



