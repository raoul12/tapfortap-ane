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
		private static const APP_ID : String = "7ad61330-aa87-012f-f0dd-4040d804a637";
		
		private var log : TextField = null;
		private var ad : TapForTapAd = null;
		
		public function Demo()
		{
			log = new TextField();
			log.x = 20;
			log.y = 20;
			log.width = 600;
			log.height = 400;
			log.text = "Tap for Tap ANE (Air Native Extension) Demo\n";
			
			addChild( log );
			
			if ( TapForTapAd.isSupported )
			{
				log.appendText( "isSupported: true\n" );
				log.appendText( "Click to create or destroy an ad.\n" );
				
				addEventListener( MouseEvent.CLICK, onClick );
			}
			else
			{
				log.appendText( "isSupported: false\n" );
			}
		}
		
		private function onClick( e : MouseEvent ) : void
		{
			if ( ad )
			{
				ad.dispose();
				ad = null;
				
				log.appendText( "Ad destroyed.\n" );
			}
			else
			{
				try
				{
					ad = new TapForTapAd( APP_ID, {align: "top", color: 0xFF00FF00, age: 24} );
					
					log.appendText( "Ad created.\n" );
				}
				catch ( e : Error )
				{
					log.appendText( "errCode: " + TapForTapAd.errCode + "\n" );
				}
			}
		} 
	}
}