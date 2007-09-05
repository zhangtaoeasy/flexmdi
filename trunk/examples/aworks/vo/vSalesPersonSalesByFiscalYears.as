
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class vSalesPersonSalesByFiscalYears extends ValueObject
	{
		
		public function vSalesPersonSalesByFiscalYears(args:*=null):void
		{
			super(args);
		}

		
		public var SalesPersonID : Number = 0;
		
		public var FullName : String = "";
		
		public var Title : String = "";
		
		public var SalesTerritory : String = "";
		
		public var 2002 : String = "";
		
		public var 2003 : String = "";
		
		public var 2004 : String = "";
		
		
	}
}



