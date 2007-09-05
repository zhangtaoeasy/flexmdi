
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class vProductModelCatalogDescription extends ValueObject
	{
		
		public function vProductModelCatalogDescription(args:*=null):void
		{
			super(args);
		}

		
		public var ProductModelID : Number = 0;
		
		public var Name : String = "";
		
		public var Summary : String = "";
		
		public var Manufacturer : String = "";
		
		public var Copyright : String = "";
		
		public var ProductURL : String = "";
		
		public var WarrantyPeriod : String = "";
		
		public var WarrantyDescription : String = "";
		
		public var NoOfYears : String = "";
		
		public var MaintenanceDescription : String = "";
		
		public var Wheel : String = "";
		
		public var Saddle : String = "";
		
		public var Pedal : String = "";
		
		public var BikeFrame : String = "";
		
		public var Crankset : String = "";
		
		public var PictureAngle : String = "";
		
		public var PictureSize : String = "";
		
		public var ProductPhotoID : String = "";
		
		public var Material : String = "";
		
		public var Color : String = "";
		
		public var ProductLine : String = "";
		
		public var Style : String = "";
		
		public var RiderExperience : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



