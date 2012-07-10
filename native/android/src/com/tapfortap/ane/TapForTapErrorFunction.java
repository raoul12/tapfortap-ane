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

package com.tapfortap.ane;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

public class TapForTapErrorFunction implements FREFunction
{
	public static int errorCode = 0;
	
    @Override
	public FREObject call( FREContext ctx, FREObject[] args )
    {
		FREObject retVal = null;
		
        try
        {
			retVal = FREObject.newObject( errorCode );
			
			errorCode = 0;
		}
        catch ( FREWrongThreadException e )
        {
			return null;
		}
        catch ( IllegalStateException e )
		{
			return null;
		}
        
		return retVal;
	}
}