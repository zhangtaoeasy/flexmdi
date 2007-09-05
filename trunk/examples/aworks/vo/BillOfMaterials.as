
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class BillOfMaterials extends ValueObject
	{
		
		public function BillOfMaterials(args:*=null):void
		{
			super(args);
		}

		
		public var BillOfMaterialsID : Number = 0;
		
		public var ProductAssemblyID : Number = 0;
		
		public var ComponentID : Number = 0;
		
		public var StartDate : Date;
		
		public var EndDate : Date;
		
		public var UnitMeasureCode : String = "";
		
		public var BOMLevel : String = "";
		
		public var PerAssemblyQty : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



