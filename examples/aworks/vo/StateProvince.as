
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class StateProvince extends ValueObject
	{
		
		public function StateProvince(args:*=null):void
		{
			super(args);
		}

		
		public var StateProvinceID : Number = 0;
		
		public var StateProvinceCode : String = "";
		
		public var CountryRegionCode : String = "";
		
		public var IsOnlyStateProvinceFlag : String = "";
		
		public var Name : String = "";
		
		public var TerritoryID : Number = 0;
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



