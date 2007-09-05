
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class vIndividualCustomer extends ValueObject
	{
		
		public function vIndividualCustomer(args:*=null):void
		{
			super(args);
		}

		
		public var CustomerID : Number = 0;
		
		public var Title : String = "";
		
		public var FirstName : String = "";
		
		public var MiddleName : String = "";
		
		public var LastName : String = "";
		
		public var Suffix : String = "";
		
		public var Phone : String = "";
		
		public var EmailAddress : String = "";
		
		public var EmailPromotion : Number = 0;
		
		public var AddressType : String = "";
		
		public var AddressLine1 : String = "";
		
		public var AddressLine2 : String = "";
		
		public var City : String = "";
		
		public var StateProvinceName : String = "";
		
		public var PostalCode : String = "";
		
		public var CountryRegionName : String = "";
		
		public var Demographics : String = "";
		
		
	}
}



