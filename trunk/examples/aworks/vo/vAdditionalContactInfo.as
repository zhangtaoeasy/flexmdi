
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class vAdditionalContactInfo extends ValueObject
	{
		
		public function vAdditionalContactInfo(args:*=null):void
		{
			super(args);
		}

		
		public var ContactID : Number = 0;
		
		public var FirstName : String = "";
		
		public var MiddleName : String = "";
		
		public var LastName : String = "";
		
		public var TelephoneNumber : String = "";
		
		public var TelephoneSpecialInstructions : String = "";
		
		public var Street : String = "";
		
		public var City : String = "";
		
		public var StateProvince : String = "";
		
		public var PostalCode : String = "";
		
		public var CountryRegion : String = "";
		
		public var HomeAddressSpecialInstructions : String = "";
		
		public var EMailAddress : String = "";
		
		public var EMailSpecialInstructions : String = "";
		
		public var EMailTelephoneNumber : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



