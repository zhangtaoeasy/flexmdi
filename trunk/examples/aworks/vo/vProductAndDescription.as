
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class vProductAndDescription extends ValueObject
	{
		
		public function vProductAndDescription(args:*=null):void
		{
			super(args);
		}

		
		public var ProductID : Number = 0;
		
		public var Name : String = "";
		
		public var ProductModel : String = "";
		
		public var CultureID : String = "";
		
		public var Description : String = "";
		
		
	}
}



