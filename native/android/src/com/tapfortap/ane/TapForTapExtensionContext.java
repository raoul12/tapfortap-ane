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

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.tapfortap.AdView;

public class TapForTapExtensionContext extends FREContext
{
    public AdView adView;
	
	@Override
	public void dispose()
	{
	}

	@Override
	public Map<String, FREFunction> getFunctions()
	{
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();

		functionMap.put( "tftError", new TapForTapErrorFunction() );
		functionMap.put( "tftCreate", new TapForTapCreateFunction() );
		functionMap.put( "tftCheck", new TapForTapCheckFunction() );

		return functionMap;
	}
}