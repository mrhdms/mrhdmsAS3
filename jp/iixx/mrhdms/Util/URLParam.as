package jp.iixx.mrhdms.Util 
{
	/**
	 * ...
	 * @author Hidemasa Mori
	 * @date created 2013/03/20
	 */
	public class URLParam
	{
		
		public static function paramToObj(str:String):Object
		{
			var obj:Object = { };
			var ary:Array = str.split("&");
			var len:uint = ary.length;
			for (var i:int = 0; i < len; i++) 
			{
				var ary2:Array = ary[i].split("=");
				obj[ary2[0]] = ary2[1];
			}
			
			return obj;
		}
		
		public static function objToParamString(obj:Object):String
		{
			var str:String = "";
			for (var name:String in obj) 
			{
				if (str != "") 
				{
					str += "&";
				}
				
				str += name;
				str += "=";
				str += String(obj[name]);
			}
			
			return str;
		}
		
	}

}