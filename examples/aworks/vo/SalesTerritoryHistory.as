
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class SalesTerritoryHistory extends ValueObject
	{
		
		public function SalesTerritoryHistory(args:*=null):void
		{
			super(args);
		}

		
		public var SalesPersonID : Number = 0;
		
		public var TerritoryID : Number = 0;
		
		public var StartDate : Date;
		
		public var EndDate : Date;
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



