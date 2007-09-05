
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class vSalesPerson extends ValueObject
	{
		
		public function vSalesPerson(args:*=null):void
		{
			super(args);
		}

		
		public var SalesPersonID : Number = 0;
		
		public var Title : String = "";
		
		public var FirstName : String = "";
		
		public var MiddleName : String = "";
		
		public var LastName : String = "";
		
		public var Suffix : String = "";
		
		public var JobTitle : String = "";
		
		public var Phone : String = "";
		
		public var EmailAddress : String = "";
		
		public var EmailPromotion : Number = 0;
		
		public var AddressLine1 : String = "";
		
		public var AddressLine2 : String = "";
		
		public var City : String = "";
		
		public var StateProvinceName : String = "";
		
		public var PostalCode : String = "";
		
		public var CountryRegionName : String = "";
		
		public var TerritoryName : String = "";
		
		public var TerritoryGroup : String = "";
		
		public var SalesQuota : String = "";
		
		public var SalesYTD : String = "";
		
		public var SalesLastYear : String = "";
		
		
	}
}



