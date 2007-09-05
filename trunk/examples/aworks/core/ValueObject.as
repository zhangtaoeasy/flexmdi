package aworks.core
{
	[Bindable]
	dynamic public class ValueObject
	{
		public function ValueObject(args:Object=null):void
		{
			setVO(args);
		}

		public function setVO(args:Object=null):void
		{
			if (args is XML)
			{	
				var attribs : XMLList = (args as XML).attributes();
				for (var i:int = 0; i < attribs.length(); i++)
					{ this[ String(attribs[i].name()) ] =  attribs[i]; }
				
				var children : XMLList = (args as XML).children();	
				for (var j:int = 0; j < children.length(); j++)
					{ this[ String(children[j].name()) ] =  children[j]; }

			}
			else 
			{
				for (var key:String in args)
				{
					if (key != "mx_internal_uid")
						this[key] = args[key]; 
				} 
			} 
			
		}
	
	
	
	
	
	
	
	}
}