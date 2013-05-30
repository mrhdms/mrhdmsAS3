package jp.iixx.mrhdms.event 
{
	import flash.events.Event;
	
	/**
	 * 
	 * @author Hidemasa Mori
	 * @date created 2013/03/15
	 */
	public class XMLLoaderEvent extends Event 
	{
		public static const ERROR:String = "error";
		public static const COMPLETE:String = "complete";
		
		private var _xml:XML;
		
		public function XMLLoaderEvent(type:String, xml:XML, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_xml = xml;
		} 
		
		public override function clone():Event 
		{ 
			return new XMLLoaderEvent(type, xml, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("XMLLoaderEvent", "type", "bubbles", "cancelable", "eventPhase", "xml"); 
		}
		
		public function get xml():XML 
		{
			return _xml;
		}
		
		public function set xml(value:XML):void 
		{
			_xml = value;
		}
		
	}
	
}