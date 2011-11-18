package jp.iixx.mrhdms.util
{
	
	/**
	 * ...
	 * @author Hidemasa Mori
	 * @date created 2011/11/19
	 */
	public class ARGB 
	{
		private var _a:int = 0;
		private var _r:int = 0;
		private var _g:int = 0;
		private var _b:int = 0;
		
		/**
		 * ピクセルの色をARGBに分割する
		 * @param	pixel ピクセルの色のuint
		 */
		public function setPixel(pixel:uint):void
		{
			a = pixel >> 24 & 0xFF;
			r = pixel >> 16 & 0xFF;
			g = pixel >>  8 & 0xFF;
			b = pixel       & 0xFF;
		}
		
		/**
		 * ARGBをuintに結合する
		 * @return	ピクセルの色のuint
		 */
		public function getPixel():uint
		{
			return a << 24 | r << 16 | g << 8 | b;
		}
		
		/**
		 * アルファ値を取得
		 * @return	アルファ値のint
		 */
		public function get a():int 
		{
			return _a;
		}
		
		/**
		 * アルファ値を設定
		 * 0~255の範囲外は丸めます。
		 * @param	value アルファのint
		 */
		public function set a(value:int):void 
		{
			if (value > 255) 
			{
				_a = 255;
			} else if (value < 0) {
				_a = 0;
			} else {
				_a = value;
			}
		}
		
		/**
		 * Red値を取得
		 * @return	Redのint
		 */
		public function get r():int 
		{
			return _r;
		}
		
		/**
		 * Red値を設定
		 * 0~255の範囲外は丸めます。
		 * @param	value Redのint
		 */
		public function set r(value:int):void 
		{
			_r = value;
		}
		
		/**
		 * Green値を取得
		 * @return	Greenのint
		 */
		public function get g():int 
		{
			return _g;
		}
		
		/**
		 * Green値を設定
		 * 0~255の範囲外は丸めます。
		 * @param	value Greenのint
		 */
		public function set g(value:int):void 
		{
			_g = value;
		}
		
		/**
		 * Blue値を取得
		 * @return	Blueのint
		 */
		public function get b():int 
		{
			return _b;
		}
		
		/**
		 * Blue値を設定
		 * 0~255の範囲外は丸めます。
		 * @param	value Blueのint
		 */
		public function set b(value:int):void 
		{
			_b = value;
		}
	}
	
}