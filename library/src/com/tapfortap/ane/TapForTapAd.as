/****************************************************************************/
/** This file is part of the Tap for Tap ANE (Air Native Extension)        **/
/** Author: Pierre-Yves GATOUILLAT (contact [at] impulse12.com)            **/
/****************************************************************************/
/** This program is free software: you can redistribute it and/or modify   **/
/** it under the terms of the GNU General Public License as published by   **/
/** the Free Software Foundation, either version 3 of the License, or      **/
/** (at your option) any later version.                                    **/
/**                                                                        **/
/** This program is distributed in the hope that it will be useful,        **/
/** but WITHOUT ANY WARRANTY; without even the implied warranty of         **/
/** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          **/
/** GNU General Public License for more details.                           **/
/**                                                                        **/
/** You should have received a copy of the GNU General Public License      **/
/** along with this program.  If not, see <http://www.gnu.org/licenses/>.  **/
/****************************************************************************/

package com.tapfortap.ane
{
	import flash.external.ExtensionContext;
	
	/**
	 * TapForTapAd represents a Tap for Tap ad on stage.
	 * You should call TapForTapAd.isSupported before instanciating, just to
	 * be sure the ANE is supported on your platform.
	 * Once you instanciate it, the ad should be visible on screen. If not,
	 * then check if the errCode property is set. Also check if the values in
	 * your optional properties are valid. Maybe try without any property.
	 * To remove the ad, just call dispose and get rid of that instance.
	 * There can be only one Tap for Tap ad on stage.
	 */
    public class TapForTapAd
	{  
		private static var _context : ExtensionContext = null;
		
		private static function get isContextAvailable() : Boolean
		{
			if ( !_context )
				_context = ExtensionContext.createExtensionContext( "com.tapfortap.ane", null );
			
			return _context != null;
		}
		
		/**
		 * Returns true if the execution environment is iOS or Android.
		 * TapForTap is not (yet) supported on desktop and browsers.
		 */ 
		public static function get isSupported() : Boolean
		{
			if ( isContextAvailable )
				return _context.call( "tftCheck" ) as Boolean;
			else
				return false; 
		}
		
		/**
		 * Retrieves the latest error code. This code is set if an exception was
		 * thrown when calling TapForTapAd or dispose.<br/><br/>
		 * Here is the list of known error codes:<br/>
		 * <li>0x00: No error.</li>
		 * <li>0x01: Unable to put another ad on the stage, there is already one.</li>
		 * <li>0x02: An unknown error occurred when calling setDefaultAppId or checkIn on TapForTap.</li>
		 * <li>0x03: Error while trying to set the layout params, the given rect may be invalid.</li>
		 * <li>0x04: An error occurred during the initialization of TapForTapAdView, this can be either internal to the TapForTap SDK or one of the given properties is invalid.</li>
		 * <li>0x05: Unable to add the ad view to the stage.</li>
		 * <li>0x06: An unknown error occurred when calling loadAds on TapForTapAdView instance.</li>
		 * <li>0x07: Cannot receive the ad content, this is certainly related to a connection problem.</li>
		 * <li>0x11: Unable to remove that ad from the stage, it has already been removed.</li>
		 * <li>0x12: An internal error occurred when trying to remove that ad from the stage.</li>
		 */
		public static function get errCode() : int
		{
			if ( isContextAvailable )
				return _context.call( "tftError" ) as int;
			else
				return -1;
		}
		
		/**
		 * Creates and initializes a new ad with the given appId and optional properties.<br/><br/>
		 * Here is the list of supported properties:<br/>
		 * <li>rect: Object defining the absolute position (in pixels) of the ad on stage, must contain the following properties:<br/>
		 * - x: Number<br/>
		 * - y: Number<br/>
		 * - width: Number<br/>
		 * - height: Number</li>
		 * <li>color: uint specifying a background color for the ad, in 0xAARRGGBB format.</li>
		 * <li>gender: String which can be either "female", "male", or "none".</li>
		 * <li>age: int defining the approximative age of your user.</li>
		 * <li>location: Object defining the location of the user, must contain the following properties:<br/>
		 * - latitude: Number<br/>
		 * - longitude: Number<br/>
		 * - altitude: Number</li>
		 * - time: Number</li><br/>
		 * Check the Tap For Tap documentation online for more informations about gender, age, and location properties.
		 */
        public function TapForTapAd( appId : String, props : Object = null )
		{
			if ( isContextAvailable )
				init( appId, props );
			else
				throw new Error( "Error while creating the Tap for Tap Ad." ); 
		}
		
		private function init( appId : String, props : Object = null ) : void
		{
			const HAS_RECT : int = 0x01;
			const HAS_COLOR : int = 0x02;
			const HAS_GENDER : int = 0x10;
			const HAS_AGE : int = 0x20;
			const HAS_LOCATION : int = 0x40;
			
			var flags : int = 0;
			var args : Array = [];
			
			var i : int = 0;
			
			args[i++] = "tftCreate";
			args[i++] = 0;
			args[i++] = appId;
			
			if ( props )
			{
				if ( props.hasOwnProperty("rect") )
				{
					flags |= HAS_RECT;
					args[i++] = int(props.rect.x);
					args[i++] = int(props.rect.y);
					args[i++] = int(props.rect.width);
					args[i++] = int(props.rect.height);
				}
				
				if ( props.hasOwnProperty("color") )
				{
					flags |= HAS_COLOR;
					args[i++] = int(props.color);
				}
				
				if ( props.hasOwnProperty("gender") )
				{
					flags |= HAS_GENDER;
					args[i++] = String(props.gender);
				}
				
				if ( props.hasOwnProperty("age") )
				{
					flags |= HAS_AGE;
					args[i++] = int(props.age);
				}
				
				if ( props.hasOwnProperty("location") )
				{
					flags |= HAS_LOCATION;
					args[i++] = Number(props.location.latitude);
					args[i++] = Number(props.location.longitude);
					args[i++] = Number(props.location.altitude);
					args[i++] = Number(props.location.time);
				}
			}
			
			args[1] = flags;
			
			if ( !_context.call.apply( this, args ) )
				throw new Error( "Error while creating the Tap for Tap Ad." ); 
		}
		
		/**
		 * Removes that ad from the stage. This can be done only once.
		 */
		public function dispose() : void
		{
			if ( isContextAvailable )
				_context.call( "tftDestroy" );
		}
	}
}