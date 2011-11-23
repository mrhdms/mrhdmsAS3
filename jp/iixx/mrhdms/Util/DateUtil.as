package jp.iixx.mrhdms.util
{
	
	/**
	 * Date便利クラス
	 * @author Hidemasa Mori
	 * @date created 2011/11/22
	 */
	public class DateUtil
	{
		private static const dayAry:Array = ["日", "月", "火", "水", "木", "金", "土"];
		private static const dayAryEn:Array = ["SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"];
		private static const dayAryEnShort:Array = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
		
		/**
		 * 2つのDateの年の差を返します。
		 * @param	startDate		開始のDate型オブジェクト
		 * @param	endDate		終了のDate型オブジェクト
		 * @return	差分の年数を整数で返します。
		 */
		public static function diffYear(startDate:Date,endDate:Date):int
		{
			var diff:Number = endDate.getTime() - startDate.getTime();
			return int(diff / 1000 / 60 / 60 / 24 / 365);
		}
		
		/**
		 * 2つのDateの月の差を返します。
		 * 1年と2ヶ月なら14みたいな。
		 * @param	startDate		開始のDate型オブジェクト
		 * @param	endDate		終了のDate型オブジェクト
		 * @param	surplus		余剰の真偽値。trueにすると年を省いた月数1～11を返す。
		 * @return	差分の月数を整数で返します。
		 */
		public static function diffMonth(startDate:Date,endDate:Date,surplus:Boolean = false):int
		{
			var year:int = diffYear(startDate, endDate);
			var diff:int = 0;
			if (startDate.getTime() < endDate.getTime()) 
			{
				diff = int((12 - startDate.getMonth() + endDate.getMonth()) % 12);
			} else {
				diff = int(-(12 + startDate.getMonth() - endDate.getMonth()) % 12);
			}
			if (surplus) 
			{
				return diff;
			} else {
				return int(year * 12 + diff);
			}
		}
		
		/**
		 * 2つのDateの日の差を返します。
		 * @param	startDate		開始のDate型オブジェクト
		 * @param	endDate		終了のDate型オブジェクト
		 * @param	surplus		余剰の真偽値。trueにすると年を省いた日数1～364を返す。
		 * @return
		 */
		public static function diffDate(startDate:Date, endDate:Date, surplus:Boolean = false):int
		{
			var diff:Number = endDate.getTime() - startDate.getTime();
			if (surplus) 
			{
				return int(diff / 1000 / 60 / 60 / 24 % 365);
			} else {
				return int(diff / 1000 / 60 / 60 / 24);
			}
		}
		
		/**
		 * 曜日を日本語表記で返します（日、月、火・・）
		 * @param	date	対象のDateオブジェクト
		 * @return	曜日の文字列
		 */
		public static function getDayOfWeek(date:Date):String
		{
			return dayAry[date.getDay()];
		}
		
		/**
		 * 曜日を英語表記で返します（SUNDAY、MONDAY・・）
		 * @param	date	対象のDateオブジェクト
		 * @return	曜日の文字列
		 */
		public static function getDayOfWeekEn(date:Date):String
		{
			return dayAryEn[date.getDay()];
		}
		
		/**
		 * 曜日を英語の短縮表記で返します（SUN、MON・・）
		 * @param	date	対象のDateオブジェクト
		 * @return	曜日の文字列
		 */
		public static function getDayOfWeekEnShort(date:Date):String
		{
			return dayAryEnShort[date.getDay()];
		}
	}
	
}