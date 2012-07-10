package
{
	import com.tapfortap.ane.TapForTapAd;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class Demo extends Sprite
	{
		private var l:TextField = null;
		private var g:TapForTapAd = null;
		private var t:Timer = null;
		
		public function Demo()
		{
			if(TapForTapAd.isSupported)
			{
				l = new TextField();
				l.x = 20;
				l.y = 20;
				l.width = 600;
				l.height = 400;
				l.text = "Hello!";
				
				g = new TapForTapAd(  );
				
				t = new Timer(500);
				t.addEventListener(TimerEvent.TIMER, onTimer);
				t.start();
				
				addChild(l);
				addEventListener(MouseEvent.CLICK,onClick);
				
				trace("success"); 
			}
			else
			{
				trace("fail"); 
			}
		}
		
		private function onClick(e:MouseEvent):void{
			trace("onClick");
			try {
				g.start();
			} catch(e:*) {
				trace(e);
			}
		} 
		
		private function onTimer(e:TimerEvent):void{
			l.text = g.getLogBuffer();
			trace("onTimer: " + l.text);
		} 
	}
}