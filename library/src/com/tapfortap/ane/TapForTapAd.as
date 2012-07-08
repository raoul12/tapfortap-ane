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
	import flash.events.EventDispatcher;
	import flash.external.ExtensionContext;

    public class TapForTapAd extends EventDispatcher {  
	
		private static var extCtx:ExtensionContext = null;
        
        private static var isInstantiated:Boolean = false;
        
		private static var checkedIfSupported:Boolean = false;
        
		private static var supported:Boolean = false;
        
        
		
        public function TapForTapAd(){
			if (!isInstantiated){
				extCtx = ExtensionContext.createExtensionContext("com.tapfortap.ane", null);
				
				isInstantiated = true;
			}
		}
	
        public static function get isSupported():Boolean {
			var ctx:ExtensionContext = null;
			
			if (checkedIfSupported == false) {
				// This time is the first time that isSupported() is called. 
				checkedIfSupported = true;
				
				ctx = ExtensionContext.createExtensionContext("com.tapfortap.ane",null);
				
				if (ctx != null) {
					
					ctx.call("init"); 
					
					supported = ctx.call("tapfortapSupport") as Boolean;
					
					trace("tapfortapSupport Returned : " + supported); 
								
					ctx.dispose();
					ctx = null;
					return supported;
				} else {
					return false; 
				} 
			} else {
				// Already checked if supported, so the value of supported is already set.
				return supported; 
			}
		}
		
		
		
		public function getLogBuffer():String {
			return String(extCtx.call("tapfortapLog"));
		}
		
		
		
		public function start():void {
			if (!extCtx.call("tapfortapStart")) {  
				throw new Error("Error while creating the Tap for Tap Ad"); 
			} 
		}
	}
}