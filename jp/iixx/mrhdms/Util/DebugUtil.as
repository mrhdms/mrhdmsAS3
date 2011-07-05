package jp.iixx.mrhdms.util
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
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
		public function traceDisplayList(container:DisplayObjectContainer, indentString:String = ""):void 
		{
			var child:DisplayObject; 
			for (var i:uint=0; i < container.numChildren; i++) 
			{
			child = container.getChildAt(i); 
			trace(indentString, child, child.name);  
			if (container.getChildAt(i) is DisplayObjectContainer) 
				{ 
				traceDisplayList(DisplayObjectContainer(child), indentString + "    ") 
				} 
			} 
		}
	}
	
}