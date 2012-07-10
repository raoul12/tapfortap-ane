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

    public class TapForTapAd
	{  
		private static var _context : ExtensionContext = null;
		
		private static function get isContextAvailable() : Boolean
		{
			if ( !_context )
				_context = ExtensionContext.createExtensionContext( "com.tapfortap.ane", null );
			
			return _context != null;
		}
		
		public static function get isSupported() : Boolean
		{
			if ( isContextAvailable )
				return _context.call( "tftCheck" ) as Boolean;
			else
				return false; 
		}
		
		public static function get errCode() : int
		{
			if ( isContextAvailable )
				return _context.call( "tftError" ) as int;
			else
				return -1;
		}
		
        public function TapForTapAd( appId : String, props : Object = null )
		{
			if ( isContextAvailable )
				init( appId, props );
			else
				throw new Error( "Error while creating the Tap for Tap Ad." ); 
		}
		
		private function init( appId : String, props : Object = null ) : void
		{
			const HAS_ALIGN : int = 0x01;
			const HAS_COLOR : int = 0x02;
			const HAS_GENDER : int = 0x10;
			const HAS_AGE : int = 0x20;
			const HAS_LOCATION : int = 0x40;
			
			var flags : int = 0;
			var args : Array = [];
			
			var i : int = 0;
			
			args[i++] = appId;
			args[i++] = 0;
			
			if ( props.hasOwnProperty("align") )
			{
				flags |= HAS_ALIGN;
				args[i++] = props.align;
			}
			
			if ( props.hasOwnProperty("color") )
			{
				flags |= HAS_COLOR;
				args[i++] = props.color;
			}
			
			if ( props.hasOwnProperty("gender") )
			{
				flags |= HAS_GENDER;
				args[i++] = props.gender;
			}
			
			if ( props.hasOwnProperty("age") )
			{
				flags |= HAS_AGE;
				args[i++] = props.age;
			}
			
			if ( props.hasOwnProperty("location") )
			{
				flags |= HAS_LOCATION;
				args[i++] = props.location;
			}
			
			if ( !_context.call( "tftCreate", args ) )
				throw new Error( "Error while creating the Tap for Tap Ad." ); 
		}
		
		public function dispose() : void
		{
			if ( isContextAvailable )
				_context.call( "tftDestroy" );
		}
	}
}