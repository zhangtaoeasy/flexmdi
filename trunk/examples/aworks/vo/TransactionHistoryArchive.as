
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class TransactionHistoryArchive extends ValueObject
	{
		
		public function TransactionHistoryArchive(args:*=null):void
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



