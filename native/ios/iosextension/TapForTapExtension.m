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
 
#import "FlashRuntimeExtensions.h"
#import "TapForTap.h"

int32_t errorCode = 0;
NSOperationQueue* opQ = nil;
TapForTapAdView* adView = nil;
UIView* applicationView = nil;

FREObject TFT_create( FREContext ctx, void* funcData, uint32_t argc, FREObject argv[] )
{
 	FREObject retVal;
	FRENewObjectFromBool( NO, &retVal );  
    
	if ( adView == nil )
	{
		int32_t i = 0;
		
		const int32_t HAS_RECT = 0x01;
		const int32_t HAS_COLOR = 0x02;
		const int32_t HAS_GENDER = 0x10;
		const int32_t HAS_AGE = 0x20;
		const int32_t HAS_LOCATION = 0x40;
		
        applicationView = [[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController].view;
		
		int32_t flags;
		
		@try
		{
			FREGetObjectAsInt32( argv[i++], &flags );
			
			uint8_t* appId; uint32_t length;
			FREGetObjectAsUTF8( argv[i++], &length, (const uint8_t**)&appId );
			
			[TapForTap setDefaultAppId: [[NSString alloc] initWithUTF8String: (const char*)appId]];
			[TapForTap checkIn];
		}
		@catch ( NSException* e )
		{
			errorCode = 0x02;
			
			return nil;
		}
		
		int32_t x = 0;
		int32_t y = 0;
		int32_t width = 300;
		int32_t height = 50;
		
		@try
		{
			if ( (flags & HAS_RECT) != 0 )
			{
				FREGetObjectAsInt32( argv[i++], &x );
				FREGetObjectAsInt32( argv[i++], &y );
				FREGetObjectAsInt32( argv[i++], &width );
				FREGetObjectAsInt32( argv[i++], &height );
			}
		}
		@catch ( NSException* e )
		{
			errorCode = 0x03;
			
			return nil;
		}
		
		@try
		{
			adView = [[TapForTapAdView alloc] initWithFrame: CGRectMake(x, y, width, height)];
			
			if ( (flags & HAS_COLOR) != 0 )
			{
				int32_t color;
				FREGetObjectAsInt32( argv[i++], &color );
                
                float alpha = (color & 0xff000000) >> 24;
                float red = (color & 0x00ff0000) >> 16;
                float green = (color & 0x0000ff00) >> 8;
                float blue = (color & 0x000000ff);
                const float f = 1.0 / 255.0;
                
                adView.backgroundColor = [UIColor colorWithRed:red*f green:green*f blue:blue*f alpha:alpha*f];
			}
			
			if ( (flags & HAS_GENDER) != 0 )
			{
				uint8_t* gender; uint32_t length;
				FREGetObjectAsUTF8( argv[i++], &length, (const uint8_t**)&gender );
				
				if ( length >= 6 && strcmp( (const char*)gender, "female" ) == 0 )
					adView.gender = FEMALE;
				else if ( length >= 4 && strcmp( (const char*)gender, "male" ) == 0 )
					adView.gender = MALE;
				else
					adView.gender = NONE;
			}
			
			if ( (flags & HAS_AGE) != 0 )
			{
				int32_t age;
				FREGetObjectAsInt32( argv[i++], &age );
				adView.age = age;
			}
			
			if ( (flags & HAS_LOCATION) != 0 )
			{
				double latitude;
				FREGetObjectAsDouble( argv[i++], &latitude );
				double longitude;
				FREGetObjectAsDouble( argv[i++], &longitude );
				double altitude;
				FREGetObjectAsDouble( argv[i++], &altitude );
				double time;
				FREGetObjectAsDouble( argv[i++], &time );
				
                CLLocationCoordinate2D coordinate;
                coordinate.latitude = latitude;
                coordinate.longitude = longitude;
                
                NSTimeInterval timeInterval = time / 1000;
                
                CLLocation *location = [[CLLocation init] initWithCoordinate:coordinate altitude:altitude horizontalAccuracy:100 verticalAccuracy:100 timestamp:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
				
				adView.location = location;
			}
		}
		@catch ( NSException* e )
		{
			errorCode = 0x04;
			
			return nil;
		}
		
		@try
		{
			[applicationView addSubview: adView];
		}
		@catch ( NSException* e )
		{
			errorCode = 0x05;
			
			return nil;
		}
		
		@try
		{
			[adView loadAds];
			
			FRENewObjectFromBool( YES, &retVal );  
		}
		@catch ( NSException* e )
		{
			errorCode = 0x06;
			
			return nil;
		}
 	}
	else
	{
		errorCode = 0x01;
	}
    
	return retVal;
}

FREObject TFT_destroy( FREContext ctx, void* funcData, uint32_t argc, FREObject argv[] )
{
	FREObject retVal;
	FRENewObjectFromBool( NO, &retVal );  
	
	if ( adView != nil )
	{
		@try
		{
			[adView removeFromSuperview];
			adView = nil;
			
			FRENewObjectFromBool( YES, &retVal );  
		}
		@catch ( NSException* e )
		{
			errorCode = 0x12;
			
			return nil;
		}
 	}
	else
	{
		errorCode = 0x11;
	}
    
	return retVal; 
}

FREObject TFT_check( FREContext ctx, void* funcData, uint32_t argc, FREObject argv[] )
{
	FREObject retVal;
	FRENewObjectFromBool( YES, &retVal );  
	
	return retVal; 
}

FREObject TFT_error( FREContext ctx, void* funcData, uint32_t argc, FREObject argv[] )
{
	FREObject retVal;
	FRENewObjectFromInt32( errorCode, &retVal );  
	
	return retVal;
}

void TFT_ContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet )
{
	*numFunctionsToTest = 4;
	FRENamedFunction* func = (FRENamedFunction*)malloc( sizeof(FRENamedFunction) * 4 );
    
	func[0].name = (const uint8_t*)"tftCreate";
	func[0].functionData = NULL;
	func[0].function = &TFT_create;

	func[1].name = (const uint8_t*)"tftDestroy";
	func[1].functionData = NULL;
	func[1].function = &TFT_destroy;

	func[2].name = (const uint8_t*)"tftCheck";
	func[2].functionData = NULL;
	func[2].function = &TFT_check;
	
	func[3].name = (const uint8_t*)"tftError";
	func[3].functionData = NULL;
	func[3].function = &TFT_error;
	
	*functionsToSet = func; 
	
	opQ = [[NSOperationQueue currentQueue] retain];  
}

void TFT_ContextFinalizer( FREContext ctx )
{ 
	[opQ release];
	opQ = nil;
}

void TFTExtInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet )
{
	*extDataToSet = NULL;
	*ctxInitializerToSet = &TFT_ContextInitializer; 
	*ctxFinalizerToSet = &TFT_ContextFinalizer;
}  

void TFTExtFinalizer( void* extData )
{
	return;
}
