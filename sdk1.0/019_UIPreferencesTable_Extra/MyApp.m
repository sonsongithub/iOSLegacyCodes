
#import "MyApp.h"

@implementation MyApp
- (void) applicationDidFinishLaunching: (id) unused {
	//
	[self readPreferenceData];
	
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	
	CGRect sizeTextView = CGRectMake(0, 0, 320, 480);
	
	// Create window
	UIWindow*   window;
	window = [[UIWindow alloc] initWithContentRect:screenRect];
	
	// Create text view
	preferenceView_ = [[PreferenceView alloc] initWithFrame:sizeTextView];

	// Set content view
	[window setContentView:preferenceView_];
	
	// Show window
	[window orderFront:self];
	[window makeKey:self];
	[window _setHidden:NO];
}

- (void) applicationWillTerminate {
}

- (void) readPreferenceData {
	NSDictionary *dict = [UIApp readPlist];
	NSArray *font = [NSArray arrayWithObjects:
							[NSString stringWithUTF8String:"Small"],
							[NSString stringWithUTF8String:"Medium"],
							[NSString stringWithUTF8String:"Large"],
							[NSString stringWithUTF8String:"Extra Large"],
							[NSString stringWithUTF8String:"Giant"],
							nil];
	NSArray *day = [NSArray arrayWithObjects:
							[NSString stringWithUTF8String:"5"],
							[NSString stringWithUTF8String:"10"],
							[NSString stringWithUTF8String:"15"],
							[NSString stringWithUTF8String:"20"],
							[NSString stringWithUTF8String:"25"],
							nil];
	NSArray	*bin = [NSArray arrayWithObjects:
							[NSString stringWithUTF8String:"false"],
							[NSString stringWithUTF8String:"true"],
							nil];
	id theadIndex = [dict objectForKey:@"threadIndexSize"];
	id thread = [dict objectForKey:@"threadSize"];
	id days = [dict objectForKey:@"daysToMaintain"];
	id offline_flag = [dict objectForKey:@"offlineMode"];
	
	threadIndexSize_ = 10.0f + 2.0f * [font indexOfObject:theadIndex];
	threadSize_ = 10.0f + 2.0f * [font indexOfObject:thread];
	daysToMaintain_ = 5 * ( [day indexOfObject:days] + 1 );
	offlineMode_ = [bin indexOfObject:offline_flag];

	NSLog( @"%lf, %lf, %d, %d", threadIndexSize_, threadSize_, daysToMaintain_, offlineMode_ );
}

- (NSDictionary*) readPlist {
	NSDictionary *dict = nil;
	NSData *data = [NSData dataWithContentsOfFile:@"/private/var/root/Library/Preferences/com.sonson.2tch/preference.plist"];
	NSString *dataStr = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	if( [dataStr length] ) {
		dict = [dataStr propertyList];
		return dict;
	}
	if( !dict ) {
		dict = [UIApp makeDefaultDictionary];
		NSString *str = [dict description];
		[str writeToFile:@"/private/var/root/Library/Preferences/com.sonson.2tch/preference.plist" atomically:NO encoding:NSUTF8StringEncoding error:nil];
	}
	return dict;
}

- (NSDictionary*) makeDefaultDictionary {
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
			@"Medium",		@"threadIndexSize",
			@"Medium",		@"threadSize",
			@"15",			@"daysToMaintain",
			@"true",		@"offlineMode",
			nil];
	return dict;
}

- (float) threadIndexSize {
	return threadIndexSize_;
}

- (float) threadSize {
	return threadSize_;
}

- (int) daysToMaintain {
	return daysToMaintain_;
}

- (BOOL) isOfflineMode {
	return offlineMode_;
}

@end