
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ProductPhoto extends ValueObject
	{
		
		public function ProductPhoto(args:*=null):void
		{
			super(args);
		}

		
		public var ProductPhotoID : Number = 0;
		
		public var ThumbNailPhoto : String = "";
		
		public var ThumbnailPhotoFileName : String = "";
		
		public var LargePhoto : String = "";
		
		public var LargePhotoFileName : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



