
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class Document extends ValueObject
	{
		
		public function Document(args:*=null):void
		{
			super(args);
		}

		
		public var DocumentID : Number = 0;
		
		public var Title : String = "";
		
		public var FileName : String = "";
		
		public var FileExtension : String = "";
		
		public var Revision : String = "";
		
		public var ChangeNumber : Number = 0;
		
		public var Status : String = "";
		
		public var DocumentSummary : String = "";
		
		public var Document : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



