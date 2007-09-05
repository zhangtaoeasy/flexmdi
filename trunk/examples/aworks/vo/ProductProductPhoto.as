
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ProductProductPhoto extends ValueObject
	{
		
		public function ProductProductPhoto(args:*=null):void
		{
			super(args);
		}

		
		public var ProductID : Number = 0;
		
		public var ProductPhotoID : Number = 0;
		
		public var Primary : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



