package jp.iixx.mrhdms.util
{
	
	/**
	 * 配列操作のためのユーテリティクラス
	 * @author Hidemasa Mori
	 * @date created 2011/03/09
	 */
	public class ArrayUtil 
	{
		/**
		 * 配列をシャッフルして新たな配列を返す。.
		 * 元の配列には影響を与えません。
		 * @param	ary		元となる配列（この配列には影響ありません）
		 * @return	Array	渡された配列の中身をシャッフルした配列
		 */
		static public function shuffleArray(ary:Array):Array
		{
			var len:uint = ary.length;
			var ary2:Array = copyArray(ary);
			while (len) 
			{
				var n:uint = Math.floor(Math.random() * len);
				var obj:* = ary2[--len];
				ary2[len] = ary2[n];
				ary2[n] = obj;
			}
			return ary2;
		}
		
		/**
		 * 配列を複製して返す。.
		 * 元の配列には影響を与えません。
		 * @param	ary		コピー元の配列
		 * @return	Array	引数に与えた配列を複製した配列
		 */
		public static function copyArray(ary:Array):Array
		{
			var len:uint = ary.length;
			var ary2:Array = new Array();
			
			for (var i:int = 0; i < len; i++) 
			{
				ary2.push(ary[i]);
			}
			
			return ary2;
		}
		
		/**
		 * ary1からary2の内容と重複がない部分だけ新たな配列で返します。
		 * @param	ary1	元となる配列
		 * @param	ary2	重複チェック用配列
		 * @return	Array	ary2の内容を取り除いた新たな配列
		 */
		public static function diffArray(ary1:Array, ary2:Array):Array
		{
			var diffAry:Array = ary1.filter(
				function(item:*, index:int, ary:Array):Boolean
				{
					return ary2.indexOf(item) == -1;
				}	
			);
			
			return diffAry;
			
		}
	}
	
}