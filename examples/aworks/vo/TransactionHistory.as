
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class TransactionHistory extends ValueObject
	{
		
		public function TransactionHistory(args:*=null):void
		{
			super(args);
		}

		
		public var TransactionID : Number = 0;
		
		public var ProductID : Number = 0;
		
		public var ReferenceOrderID : Number = 0;
		
		public var ReferenceOrderLineID : Number = 0;
		
		public var TransactionDate : Date;
		
		public var TransactionType : String = "";
		
		public var Quantity : Number = 0;
		
		public var ActualCost : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



