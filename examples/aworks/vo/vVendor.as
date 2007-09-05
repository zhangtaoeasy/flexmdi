
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class vVendor extends ValueObject
	{
		
		public function vVendor(args:*=null):void
		{
			super(args);
		}

		
		public var VendorID : Number = 0;
		
		public var Name : String = "";
		
		public var ContactType : String = "";
		
		public var Title : String = "";
		
		public var FirstName : String = "";
		
		public var MiddleName : String = "";
		
		public var LastName : String = "";
		
		public var Suffix : String = "";
		
		public var Phone : String = "";
		
		public var EmailAddress : String = "";
		
		public var EmailPromotion : Number = 0;
		
		public var AddressLine1 : String = "";
		
		public var AddressLine2 : String = "";
		
		public var City : String = "";
		
		public var StateProvinceName : String = "";
		
		public var PostalCode : String = "";
		
		public var CountryRegionName : String = "";
		
		
	}
}



