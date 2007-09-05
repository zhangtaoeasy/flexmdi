
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ProductReview extends ValueObject
	{
		
		public function ProductReview(args:*=null):void
		{
			super(args);
		}

		
		public var ProductReviewID : Number = 0;
		
		public var ProductID : Number = 0;
		
		public var ReviewerName : String = "";
		
		public var ReviewDate : Date;
		
		public var EmailAddress : String = "";
		
		public var Rating : Number = 0;
		
		public var Comments : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



