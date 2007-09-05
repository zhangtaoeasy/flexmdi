
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class vStoreWithDemographics extends ValueObject
	{
		
		public function vStoreWithDemographics(args:*=null):void
		{
			super(args);
		}

		
		public var CustomerID : Number = 0;
		
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
		
		public var AddressType : String = "";
		
		public var AddressLine1 : String = "";
		
		public var AddressLine2 : String = "";
		
		public var City : String = "";
		
		public var StateProvinceName : String = "";
		
		public var PostalCode : String = "";
		
		public var CountryRegionName : String = "";
		
		public var AnnualSales : String = "";
		
		public var AnnualRevenue : String = "";
		
		public var BankName : String = "";
		
		public var BusinessType : String = "";
		
		public var YearOpened : Number = 0;
		
		public var Specialty : String = "";
		
		public var SquareFeet : Number = 0;
		
		public var Brands : String = "";
		
		public var Internet : String = "";
		
		public var NumberEmployees : Number = 0;
		
		
	}
}



