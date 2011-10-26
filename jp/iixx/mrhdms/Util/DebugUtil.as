package jp.iixx.mrhdms.util
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * デバッグ系便利クラス
	 * @author Hidemasa Mori
	 * @date created 2011/04/22
	 */
	public class DebugUtil
	{
		/**
		 * ディスプレイオブジェクトの子をトレースする
		 * @param	container	トレースしたい親ディスプレイオブジェクト
		 * @param	indentString	インデント文字列(,とか/とか)
		 */
		public static function traceDisplayList(container:DisplayObjectContainer, indentString:String = ""):void
		{
			var child:DisplayObject;
			for (var i:uint = 0; i < container.numChildren; i++)
			{
				child = container.getChildAt(i);
				trace(indentString, child, child.name);
				if (container.getChildAt(i) is DisplayObjectContainer)
				{
					traceDisplayList(DisplayObjectContainer(child), indentString + "    ")
				}
			}
		}
		
		/**
		 * オブジェクトの中身をトレースする
		 * @param	obj	トレースしたいObject
		 * @param	level	再起のための引数 指定は必要なし
		 */
		public static function deepTrace(obj:*, level:int = 0):void
		{
			var tabs:String = "";
			for (var i:int = 0; i < level; i++)
			{
				tabs += "\t";
			}
			
			for (var prop:String in obj)
			{
				trace(tabs + "[" + prop + "] -> " + obj[prop]);
				if (getQualifiedClassName(obj[prop]) == "Object" || getQualifiedClassName(obj[prop]) == "Array") 
				{
					deepTrace(obj[prop], level + 1);
				}
			}
		}
	}

}