package jp.iixx.mrhdms.util
{
	import flash.utils.ByteArray;
	
	/**
	 * オブジェクトのディープコピー
	 * @author Hidemasa Mori
	 * @date created 2010/09/16
	 */
	public class DeepCopy 
	{
		
		/**
		 * 配列、オブジェクト配列のディープコピーを行います.
		 * @param	arg	ArrayもしくはObject
		 * @return	ArrayもしくはObjectのディープコピーされたオブジェクト
		 */
		public static function cloneObj( arg:* ):*
		{
			var myBA:ByteArray = new ByteArray();
			myBA.writeObject(arg);
			myBA.position = 0;
			return( myBA.readObject() );
		}
	}
	
}