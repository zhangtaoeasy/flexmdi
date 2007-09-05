
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class vStateProvinceCountryRegion extends ValueObject
	{
		
		public function vStateProvinceCountryRegion(args:*=null):void
		{
			super(args);
		}

		
		public var StateProvinceID : Number = 0;
		
		public var StateProvinceCode : String = "";
		
		public var IsOnlyStateProvinceFlag : String = "";
		
		public var StateProvinceName : String = "";
		
		public var TerritoryID : Number = 0;
		
		public var CountryRegionCode : String = "";
		
		public var CountryRegionName : String = "";
		
		
	}
}



