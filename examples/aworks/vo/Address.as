
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class Address extends ValueObject
	{
		
		public function Address(args:*=null):void
		{
			super(args);
		}

		
		public var AddressID : Number = 0;
		
		public var AddressLine1 : String = "";
		
		public var AddressLine2 : String = "";
		
		public var City : String = "";
		
		public var StateProvinceID : Number = 0;
		
		public var PostalCode : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



