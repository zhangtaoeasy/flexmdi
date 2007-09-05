
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class WorkOrderRouting extends ValueObject
	{
		
		public function WorkOrderRouting(args:*=null):void
		{
			super(args);
		}

		
		public var WorkOrderID : Number = 0;
		
		public var ProductID : Number = 0;
		
		public var OperationSequence : String = "";
		
		public var LocationID : String = "";
		
		public var ScheduledStartDate : Date;
		
		public var ScheduledEndDate : Date;
		
		public var ActualStartDate : Date;
		
		public var ActualEndDate : Date;
		
		public var ActualResourceHrs : String = "";
		
		public var PlannedCost : String = "";
		
		public var ActualCost : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



