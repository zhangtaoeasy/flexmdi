package aworks.core
{
	import mx.collections.ArrayCollection;
	import mx.messaging.Channel;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.Operation;
	import mx.rpc.remoting.mxml.RemoteObject;
	import mx.utils.UIDUtil;
	
	public class DataTable
	{
		[Bindable]
		public var rows : ArrayCollection = new ArrayCollection();
	
		public var method : String;
		
		public var token : AsyncToken;

		public var args : Object = new Object();
		
		public var itemType : Class;
		
		public function DataTable(method:String=null,itemType:Class=null):void
		{
			
			if(method != null)
				this.method = method;
			
			if(itemType != null)
				this.itemType = itemType;	
				
			
		}
		
		public function invoke(args:*=null):void
		{
			var url : String = "http://www.mxmvc.com/flex2gateway/?uid=" + UIDUtil.createUID();
		
			//var url : String = this.uri + "weborb.aspx";
		
	    	var channel:Channel = new AMFChannel(null, url); 

	    		
	    	var channelSet:ChannelSet = new ChannelSet();
	        	channelSet.addChannel(channel);
			
			var ro : RemoteObject = new RemoteObject("ColdFusion");
				ro.source = "demos.aworks.api";
				ro.channelSet = channelSet;
				
			var op : Operation = ro[this.method] as Operation;
				op.addEventListener(ResultEvent.RESULT, this.OnResult);
				op.addEventListener(FaultEvent.FAULT,this.OnFault);

				if(args == null)
				{
					this.token = op.send();
				}	
				else
				{
					
					this.token = op.send(args);
				}	
				
		}
		

		private function OnResult(event:ResultEvent):void
		{
			if(itemType != null)
			{	
				var array : Array = new Array();
				
				
				for each(var item:Object in event.result)
				{
					var vo : ValueObject = new itemType(item);
					array.push(vo);
					
				}
         		
         		this.rows = new ArrayCollection(array);
				
			}
			else
			{
				this.rows = event.result as ArrayCollection;
			}
		}
		
		private function OnFault(event:FaultEvent):void
		{
			trace("DataTable OnFault");
		}
		
		
	}
}