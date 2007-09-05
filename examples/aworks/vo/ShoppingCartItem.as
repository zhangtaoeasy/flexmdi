
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ShoppingCartItem extends ValueObject
	{
		
		public function ShoppingCartItem(args:*=null):void
		{
			super(args);
		}

		
		public var ShoppingCartItemID : Number = 0;
		
		public var ShoppingCartID : String = "";
		
		public var Quantity : Number = 0;
		
		public var ProductID : Number = 0;
		
		public var DateCreated : Date;
		
		public var ModifiedDate : Date;
		
		
	}
}



