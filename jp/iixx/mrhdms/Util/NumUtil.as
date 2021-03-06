package jp.iixx.mrhdms.util
{
	
	/**
	 * 数字計算系のユーティリティ
	 * @author Hidemasa Mori
	 * @date created 2010/09/17
	 */
	public class NumUtil 
	{
		/**
		 * 数字を3桁ずつカンマ入れて返す.
		 * 
		 * @param num Number 対象となる数値
		 */
		public static function commaSeparater(num:Number):String
		{
			var str:String = new String(num).replace(/([0-9]+?)(?=(?:[0-9]{3})+$)/g, '$1,');
			return str;
		}
		
		/**
		 * 数字を指定の桁数にあわせる。足りないときは頭に0を足す。足りてる時はそのまま。
		 * @param	num		対象となる数値
		 * @param	digits		桁数
		 * @return	桁数に合わされた文字列
		 */
		public static function formatNumber(num:Number,digits:uint):String
		{
			var str:String = num.toString();
			if (str.length < digits) 
			{
				var len:uint = digits - str.length;
				for (var i:int = 0; i < len; i++) 
				{
					str = "0" + str;
				}
			}
			
			return str;
		}
		
		/**
		 * 長辺にあわせて縮小率を返す
		 * トリミングなしで枠内に収める時とかに
		 * 
		 * @param w1 Number 元となるオブジェクトの幅
		 * @param h1 Number 元となるオブジェクトの高さ
		 * @param w2 Number 目標の幅
		 * @param h2 Number 目標の高さ
		 */
		public static function scaleRatioByLongSide(w1:Number, h1:Number, w2:Number, h2:Number):Number
		{
			return w2 / w1 > h2 / h1 ? h2 / h1 : w2 / w1;
		}
		
		/**
		 * 短辺にあわせて縮小率を返す
		 * トリミングして枠いっぱいに表示するときとかに
		 * 
		 * @param w1 Number 元となるオブジェクトの幅
		 * @param h1 Number 元となるオブジェクトの高さ
		 * @param w2 Number 目標の幅
		 * @param h2 Number 目標の高さ
		 */
		public static function scaleRatioByShortSide(w1:Number, h1:Number, w2:Number, h2:Number):Number
		{
			return w2 / w1 < h2 / h1 ? h2 / h1 : w2 / w1;
		}
	}
	
}