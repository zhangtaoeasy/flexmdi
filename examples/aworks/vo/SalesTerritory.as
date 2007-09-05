
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class SalesTerritory extends ValueObject
	{
		
		public function SalesTerritory(args:*=null):void
		{
			super(args);
		}

		
		public var TerritoryID : Number = 0;
		
		public var Name : String = "";
		
		public var CountryRegionCode : String = "";
		
		public var Group : String = "";
		
		public var SalesYTD : String = "";
		
		public var SalesLastYear : String = "";
		
		public var CostYTD : String = "";
		
		public var CostLastYear : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



