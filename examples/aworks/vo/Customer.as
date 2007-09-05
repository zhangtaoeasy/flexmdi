
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class Customer extends ValueObject
	{
		
		public function Customer(args:*=null):void
		{
			super(args);
		}

		
		public var CustomerID : Number = 0;
		
		public var TerritoryID : Number = 0;
		
		public var AccountNumber : String = "";
		
		public var CustomerType : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



