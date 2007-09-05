
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class WorkOrder extends ValueObject
	{
		
		public function WorkOrder(args:*=null):void
		{
			super(args);
		}

		
		public var WorkOrderID : Number = 0;
		
		public var ProductID : Number = 0;
		
		public var OrderQty : Number = 0;
		
		public var StockedQty : Number = 0;
		
		public var ScrappedQty : String = "";
		
		public var StartDate : Date;
		
		public var EndDate : Date;
		
		public var DueDate : Date;
		
		public var ScrapReasonID : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



