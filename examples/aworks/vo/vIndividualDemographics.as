
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class vIndividualDemographics extends ValueObject
	{
		
		public function vIndividualDemographics(args:*=null):void
		{
			super(args);
		}

		
		public var CustomerID : Number = 0;
		
		public var TotalPurchaseYTD : String = "";
		
		public var DateFirstPurchase : Date;
		
		public var BirthDate : Date;
		
		public var MaritalStatus : String = "";
		
		public var YearlyIncome : String = "";
		
		public var Gender : String = "";
		
		public var TotalChildren : Number = 0;
		
		public var NumberChildrenAtHome : Number = 0;
		
		public var Education : String = "";
		
		public var Occupation : String = "";
		
		public var HomeOwnerFlag : String = "";
		
		public var NumberCarsOwned : Number = 0;
		
		
	}
}



