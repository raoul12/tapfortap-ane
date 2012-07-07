package
{
	import com.adobe.nativeExtensions.Gyroscope;
	import com.adobe.nativeExtensions.GyroscopeEvent;
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class Demo extends Sprite
	{
		private var t1:TextField = null;
		private var t2:TextField = null;
		private var t3:TextField = null;
		
		private var g1:Gyroscope = null;
		private var g2:Gyroscope = null;
		private var g3:Gyroscope = null;
		
		private var c:int = 1;
		
		private var tmr:Timer = new Timer(5000);
		
		public function Demo()
		{
			trace("I am here...");
			
			if(Gyroscope.isSupported)
			{
				t1 = new TextField();
				t1.x = 20;
				t1.y = 20;
				
				g1 = new Gyroscope();
				g1.addEventListener(GyroscopeEvent.UPDATE,onChange1);
				
				t2 = new TextField();
				t2.x = 20;
				t2.y = 50;
				
				g2 = new Gyroscope();
				g2.setRequestedUpdateInterval(1000);
				g2.addEventListener(GyroscopeEvent.UPDATE,onChange2);
				
				t3 = new TextField();
				t3.x = 20;
				t3.y = 80;
				
				g3 = new Gyroscope();
				g3.setRequestedUpdateInterval(2000);
				g3.addEventListener(GyroscopeEvent.UPDATE,onChange3);
				
				tmr.addEventListener(TimerEvent.TIMER,work);
				tmr.start();
				
				addChild(t1);
				addChild(t2);
				addChild(t3);
			}else{
				trace("no gyro"); 
			} 
		}
		
		private function work(t:TimerEvent):void{
			if(c == 1){
				g1.removeEventListener(GyroscopeEvent.UPDATE,onChange1);
				g1.dispose();
				g1 = null;
			}else if(c == 2){
				g2.removeEventListener(GyroscopeEvent.UPDATE,onChange2);
				g2.dispose();
				g2 = null;
			}else if(c == 3){
				g3.removeEventListener(GyroscopeEvent.UPDATE,onChange3);
				g3.dispose();
				g3 = null;
			}
			c++; 
		}
		private function onChange1(e:GyroscopeEvent):void{
			trace("From g1: " + e.x + " " + e.y + " " + " " + e.z);
			t1.text = e.x + " " + e.y + " " + " " + e.z; 
		} 
		
		private function onChange2(e:GyroscopeEvent):void{
			trace("From g2: " + e.x + " " + e.y + " " + " " + e.z);
			t2.text = e.x + " " + e.y + " " + " " + e.z;
		}
		
		private function onChange3(e:GyroscopeEvent):void{
			trace("From g3: " + e.x + " " + e.y + " " + " " + e.z);
			t3.text = e.x + " " + e.y + " " + " " + e.z;
		}
	}
}