
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class SalesPerson extends ValueObject
	{
		
		public function SalesPerson(args:*=null):void
		{
			super(args);
		}

		
		public var SalesPersonID : Number = 0;
		
		public var TerritoryID : Number = 0;
		
		public var SalesQuota : String = "";
		
		public var Bonus : String = "";
		
		public var CommissionPct : String = "";
		
		public var SalesYTD : String = "";
		
		public var SalesLastYear : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



