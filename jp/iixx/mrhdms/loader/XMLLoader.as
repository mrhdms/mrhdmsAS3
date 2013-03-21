package jp.iixx.mrhdms.loader 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import jp.iixx.mrhdms.event.XMLLoaderEvent;
	/**
	 * xmlロードするやつ
	 * @author Hidemasa Mori
	 * @date created 2013/03/15
	 */
	
	 /**
	  * なにかしらエラーがあったら送出, propは空
	  */
	[Event(name = "error", type = "XMLLoaderEvent")]
	
	/**
	  * 読込中に送出
	  */
	[Event(name = "progress", type = "flash.events.ProgressEvent")]
	
	/**
	 * XMLの読み込み完了で送出, prop に XMLが入っています。
	 */
	[Event(name="complete", type="XMLLoaderEvent")]
	public class XMLLoader extends EventDispatcher
	{
		
		public function XMLLoader(url:String, isCacheBreak:Boolean = false) 
		{
			var rand:String = isCacheBreak ? "?rnd=" + (Math.random() * 10000) : "";
			var loader:URLLoader = new URLLoader(new URLRequest(url + rand));
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.addEventListener(Event.COMPLETE, onComplete);
		}
		
		private function onComplete(e:Event):void 
		{
			dispatchEvent(new XMLLoaderEvent(XMLLoaderEvent.COMPLETE, XML(e.target.data)));
		}
		
		private function onProgress(e:ProgressEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function onError(e:Event):void 
		{
			trace(e.type, "in jp.iixx.mrhdms.XMLLoaderEvent");
			dispatchEvent(new XMLLoaderEvent(XMLLoaderEvent.ERROR, null));
		}
		
	}

}