package jp.iixx.mrhdms.ui 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.alumican.as3.ui.justputplay.scrollbars.JPPScrollbar;
	import net.alumican.as3.ui.justputplay.events.JPPScrollbarEvent;
	/**
	 * JPPscrollBar をサクっと使うクラス。ターゲットとマスクの大きさを渡してスクロールさせる。
	 * 
	 * @author Hidemasa Mori
	 */
	public class ScrollBarKit extends Sprite
	{
		private var _scrollbar:JPPScrollbar;
		private var _body:DisplayObject;
		private var _mask:DisplayObject;
		private var _slider:DisplayObject;
		private var _sliderBase:DisplayObject;
		private var _wheelArea:InteractiveObject;
		private var _isuseSWFWheel:Boolean;
		
		/**
		 * コンストラクタ。引数にもろもろ必要なパラメータを指定してやるとサクっとスクロールができあがります。
		 * @param	target			スクロールの対象となる表示オブジェクト
		 * @param	maskWidth		マスクの幅
		 * @param	maskHeight		マスクの高さ
		 * @param	slider			スライダーパーツとなる表示オブジェクト
		 * @param	sliderBase		スライダーの可動域に下敷きになる表示オブジェクト
		 * @param	wheelArea		マウスホイールのイベントを拾う範囲. InteractiveObjectのサブクラスで指定。
		 * @param	isuseSWFWheel	SWFWheelを使用するかどうかのブール値。初期はtrue.
		 */
		public function ScrollBarKit(target:DisplayObject,maskWidth:Number,maskHeight:Number,slider:DisplayObject,sliderBase:DisplayObject,wheelArea:InteractiveObject,isuseSWFWheel:Boolean = true):void 
		{
			_isuseSWFWheel = isuseSWFWheel;
			addEventListener(Event.ADDED_TO_STAGE, _initialize);
			_body = target;
			_mask = createMask(maskWidth, maskHeight);
			_sliderBase = sliderBase;
			_slider = slider;
			_wheelArea = wheelArea;
		}
		
		/**
		 * 初期化
		 * @param	e
		 */
		public function _initialize(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, _initialize);
			
			addChild(_body);
			addChild(_mask);
			
			_body.mask = _mask;
			
			//スクロールボックス配置
			var scrollBox:MovieClip = new MovieClip();
			scrollBox.x = _mask.width + 2;
			scrollBox.addChild(_sliderBase);
			scrollBox.addChild(_slider);
			addChild(scrollBox);
			
			
			//コンテンツの上限、下限
			var upperBound:Number = _body.y;
			var lowerBound:Number = _body.y - (_body.height - _mask.height);
			var target:Object = _body;
			var key:String = "y";
			
			//スクロールバーインスタンスの生成
			_scrollbar = new JPPScrollbar(stage,_isuseSWFWheel);
			
			
			//パーツのバインド
			//_scrollbar.up     = arrowUp;   //上向きアローボタンとしてバインドするインスタンスを設定します.
			//_scrollbar.down   = arrowDown; //下向きアローボタンとしてバインドするインスタンスを設定します.
			_scrollbar.base   = _sliderBase as Sprite;      //スクロールエリアとしてバインドするインスタンスを設定します.
			_scrollbar.slider = _slider as Sprite;    //スライダとしてバインドするインスタンスを設定します.
			_scrollbar.mouseWheelArea = _wheelArea;
			
			//======================================================================
			//スクロールバーの初期化
			_scrollbar.setup(
				target,      //スクロール対象となるオブジェクトです．
				key,         //スクロール対象コンテンツが保持している, スクロールによって実際に変化させたいプロパティ名を表します.
				_body.height, //スクロール対象コンテンツの総計サイズを設定します.
				_mask.height, //スクロール対象コンテンツの表示部分のサイズを設定します.
				upperBound,  //スライダーが上限に達したときの変化対象プロパティの値を設定します.
				lowerBound   //スライダーが下限に達したときの変化対象プロパティの値を設定します.
			);
			
			//後から値を変更できます．
			//	_scrollbar.upperBound;  //スライダーが上限に達したときの変化対象プロパティの値を設定します.
			//	_scrollbar.lowerBound;  //スライダーが下限に達したときの変化対象プロパティの値を設定します.
			//	_scrollbar.contentSize; //スクロール対象コンテンツの総計サイズを設定します.
									//このプロパティは伸縮スライドバーを使用する場合のスライドバーのサイズ計算に用いられます．
			//	_scrollbar.maskSize;    //スクロール対象コンテンツの表示部分のサイズを設定します.
			                        //このプロパティは伸縮スライドバーを使用する場合のスライドバーのサイズ計算に用いられます.
			
			
			
			
			
			//======================================================================
			//コンテンツサイズがマスクサイズに満たない場合の処理
			if (_scrollbar.isUnderFlow) {
				//_scrollbar.up.visible     = false;
				//_scrollbar.down.visible   = false;
				_scrollbar.slider.visible = false;
				_scrollbar.base.visible   = false;
				_scrollbar.baseEnabled    = false;
				_scrollbar.useMouseWheel  = false;//スクロールさせない
			}
			
			
			
			
			
			//======================================================================
			//各種オプション一覧
			
			//----------------------------------------------------------------------
			//スクロールの基本動作
			
			//減速スクロールを使用するかどうかを設定します.
			//使用する場合にはtrueを設定します.
			//_scrollbar.useSmoothScroll = false;
			
			//減速スクロールを使用する場合の, 減速の緩やかさを設定します.
			//1以上の数値を設定し, 数値が大きくなるほど緩やかに戻るようになります.
			//	_scrollbar.smoothScrollEasing = 6;
			
			
			
			//----------------------------------------------------------------------
			//スライダー
			
			//コンテンツ量に応じて伸縮するスライダーを使用するかどうかを設定します.
			//	_scrollbar.useFlexibleSlider = false;
			
			//コンテンツ量に応じて伸縮するスライダーを使用する場合, スライダーの最小サイズをピクセル値で設定します.
			//	_scrollbar.minSliderHeight = 10;
			
			//スライダーの高さを常に0として扱うかどうかを設定します.
			//	_scrollbar.useIgnoreSliderHeight = true;
			
			
			
			//----------------------------------------------------------------------
			//スライダーおよび対象プロパティの吸着
			
			//スクロール完了時にスライダーをピクセルに吸着させるかどうかを設定します. 
			//	_scrollbar.usePixelFittingSlider = true;
			
			//スクロール完了時に対象プロパティを整数値に吸着させるかどうかを設定します.
			//	_scrollbar.usePixelFittingContent = true;
			
			
			
			//----------------------------------------------------------------------
			//スクロールバーの有効化/無効化
			
			//各パーツの有効/無効を切り替えます.
			//ボタンを有効化させる場合はtrueを設定します. 
			//mouseChildrenプロパティは変更されません. 
			//このプロパティは書き込み専用です. 
			//初期設定時にtrueが設定されます. 
			
			//	_scrollbar.buttonEnabled = true; //アローボタン, スライダー, ベースボタンの有効/無効を一括して切り替えます.
			//	_scrollbar.upEnabled     = true; //上方向アローボタン
			//	_scrollbar.downEnabled   = true; //下方向アローボタン
			//	_scrollbar.sliderEnabled = true; //スライダー
			//	_scrollbar.baseEnabled   = true; //スクロールエリア
			
			
			
			//----------------------------------------------------------------------
			//マウスホイールの使用/不使用
			
			//	_scrollbar.useMouseWheel = false;
			
			
			
			//----------------------------------------------------------------------
			//アローボタンのスクロール
			
			//アローボタンを1回クリックしたときのスクロール量を設定します.
			//scrollUp(), scrollDown()メソッドを呼び出した際のスクロール量もこの値に従います.
			//	_scrollbar.arrowScrollAmount = 200;
			
			//continuousArrowScrollAmountおよびarrowScrollAmountに使用するスクロール単位を切り替えます. 
			//trueの場合はスクロール量をコンテンツ全体に対する割合で設定します(0より大きく1以下の数値). 
			//falseの場合はスクロール量をピクセル数で設定します(0以上の数値). 
			//	_scrollbar.useArrowScrollUsingRatio = true;
			
			//アローボタンを押し続けた場合に, 連続スクロールを発生させるかどうかを切り替えます.
			//	_scrollbar.useContinuousArrowScroll = false;
			
			//アローボタンを押し続けた場合に発生する連続スクロールを使用する場合, 連続スクロールが始まるまでの時間(ミリ秒)を設定します．
			//	_scrollbar.continuousArrowScrollInterval = 300;
			
			//アローボタンを押し続けた場合に発生する連続スクロールを使用する場合, 毎フレームのスクロール量を設定します. 
			//	_scrollbar.continuousArrowScrollAmount = 10;
			
			
			
			//----------------------------------------------------------------------
			//オーバーシュート演出
			
			//オーバーシュート(iPhoneのように, 端まで行くとちょっと行き過ぎて戻る演出)を加えるかどうかを切り替えます.
			//	_scrollbar.useOvershoot = true;
			
			//オーバーシュートを使用する場合, オーバーシュートの最大行き過ぎ量をピクセル数で設定します.
			//	_scrollbar.overshootPixels = 100;
			
			//オーバーシュートを使用する場合, オーバーシュートから本来のスクロール座標へ戻る際の緩やかさを設定します. 
			//1以上の数値を設定し, 数値が大きくなるほど緩やかに戻るようになります.
			//	_scrollbar.overshootEasing = 6;
			
			//オーバーシュートを使用する場合, オーバーシュート時にスクロールバーが縮む演出を加えるかどうかを切り替えます.
			//	_scrollbar.useOvershootDeformationSlider = false;
			
			
			
			//----------------------------------------------------------------------
			//オートスクロール
			
			//オートスクロールの強制力を切り替えます.
			//trueの場合は, 何らかのユーザーアクションによるスクロールが発生した時点でオートスクロールを終了します. 
			//falseの場合は, ユーザーアクションによるスクロールが優先されますが, ユーザーアクションが終了するとオートスクロールは再開します.
			//	_scrollbar.useAutoScrollCancelable = false;
			
			//オートスクロールに使用するスクロール単位を切り替えます. 
			//trueの場合はスクロール量をコンテンツ全体に対する割合で設定します(0より大きく1以下の数値). 
			//falseの場合はスクロール量をピクセル数で設定します(0以上の数値). 
			//	_scrollbar.useAutoScrollUsingRatio = true;
			
			//オートスクロールの毎フレームのスクロール量を設定します. 
			//	_scrollbar.autoScrollAmount = 10;
			
			
			
			
			
			//======================================================================
			//メソッド一覧
			
			//arrowScrollAmountプロパティに設定された量だけコンテンツをスクロールさせる関数です. スライダーは上方向へと移動します. 
			//	_scrollbar.scrollUp();
			
			//arrowScrollAmountプロパティに設定された量だけコンテンツをスクロールさせる関数です. スライダーは下方向へと移動します. 
			//	_scrollbar.scrollDown();
			
			//スクロール位置を指定しスクロールを実行する関数です. 
			//	_scrollbar.scrollByRelativeRatio(); //相対位置にスクロール．スクロール値の指定には割合を指定します. 第2引数で現在値からの相対位置と最終到達位置からの相対位置を切り替えられます．
			//	_scrollbar.scrollByAbsoluteRatio(); //絶対位置にスクロール．スクロール値の指定には割合を指定します. 
			//	_scrollbar.scrollByRelativePixel(); //相対位置にスクロール．スクロール値の指定にはピクセルを指定します. 第2引数で現在値からの相対位置と最終到達位置からの相対位置を切り替えられます．
			//	_scrollbar.scrollByAbsolutePixel(); //絶対位置にスクロール．スクロール値の指定にはピクセルを指定します. 
			
			//オートスクロールを開始します. 第2引数でスクロール方向を指定します．
			//	_scrollbar.startAutoScroll();
			
			//オートスクロールを停止します. 
			//	_scrollbar.stopAutoScroll();
			
			
			
			
			
			//======================================================================
			//読み取り専用プロパティ一覧
			
			//	_scrollbar.isUpPressed;         //上方向アローボタンが現在押下されているかどうかを取得します．
			//	_scrollbar.isDownPressed;       //下方向アローボタンが現在押下されているかどうかを取得します・
			//	_scrollbar.isBasePressed;       //スクロールエリアが現在押下されているかどうかを取得します．
			//	_scrollbar.isSliderPressed;     //スライダーが現在押下されているかどうかを取得します．
			//	_scrollbar.isOverFlow;          //contentSizeがmaskSizeよりも大きい場合にtrueを返します.
			//	_scrollbar.isUnderFlow;         //contentSizeがmaskSize以下の場合にtrueを返します.
			//	_scrollbar.isScrolling;         //減速スクロールを使用する場合, 現在スクロールが進行中であるかどうかを取得します.
			//	_scrollbar.targetScroll;        //減速スクロールを使用する場合, スクロール完了時に対象プロパティが到達する目標値を表します.
			//	_scrollbar.sliderHeight;        //useOvershootDeformationSlider=true時のオーバーシュート演出によって変形していないときのスライダーの高さを取得します.
			//	_scrollbar.isOvershooting;      //現在オーバーシュートをしている場合はtrueを返します.
			//	_scrollbar.isAutoScrolling;     //現在オートスクロールを実行中である場合はtrueを返します.
			//	_scrollbar.autoScrollDirection; //実行中のオートスクロールの方向を取得します. trueの場合は下方向, falseの場合は上方向へスクロールしています.
			
			
			
			
			
			//======================================================================
			//イベント一覧
			
			//スクロール開始時に呼び出されます．
			//	_scrollbar.addEventListener(JPPScrollbarEvent.SCROLL_START   , function(e:JPPScrollbarEvent):void { trace("scroll start");    } );
			
			//スクロール進捗時に呼び出されます．
			//	_scrollbar.addEventListener(JPPScrollbarEvent.SCROLL_PROGRESS, function(e:JPPScrollbarEvent):void { trace("scroll progress"); } );
			
			//スクロール完了時に呼び出されます．
			//	_scrollbar.addEventListener(JPPScrollbarEvent.SCROLL_COMPLETE, function(e:JPPScrollbarEvent):void { trace("scroll complete"); } );
		}
		
		/**
		 * マスクを生成する
		 * @param	width
		 * @param	height
		 * @return
		 */
		private function createMask(width:Number, height:Number = 0):Sprite
		{
			height ||= width;//heightがnullならwidthを代入
			
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0x000000);
			sp.graphics.drawRect(0, 0, width, height);
			sp.graphics.endFill();
			return sp;
		}
		
	}

}