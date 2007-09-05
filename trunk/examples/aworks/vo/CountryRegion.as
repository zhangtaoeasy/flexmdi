
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class CountryRegion extends ValueObject
	{
		
		public function CountryRegion(args:*=null):void
		{
			super(args);
		}

		
		public var CountryRegionCode : String = "";
		
		public var Name : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



