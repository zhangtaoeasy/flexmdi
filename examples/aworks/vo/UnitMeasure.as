
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class UnitMeasure extends ValueObject
	{
		
		public function UnitMeasure(args:*=null):void
		{
			super(args);
		}

		
		public var UnitMeasureCode : String = "";
		
		public var Name : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



