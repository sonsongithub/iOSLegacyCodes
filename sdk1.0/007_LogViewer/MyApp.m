
#import "MyApp.h"

/*
enum {
   NSASCIIStringEncoding = 1,
   NSNEXTSTEPStringEncoding = 2,
   NSJapaneseEUCStringEncoding = 3,
   NSUTF8StringEncoding = 4,
   NSISOLatin1StringEncoding = 5,
   NSSymbolStringEncoding = 6,
   NSNonLossyASCIIStringEncoding = 7,
   NSShiftJISStringEncoding = 8,
   NSISOLatin2StringEncoding = 9,
   NSUnicodeStringEncoding = 10,
   NSWindowsCP1251StringEncoding = 11,
   NSWindowsCP1252StringEncoding = 12, 
   NSWindowsCP1253StringEncoding = 13, 
   NSWindowsCP1254StringEncoding = 14, 
   NSWindowsCP1250StringEncoding = 15,
   NSISO2022JPStringEncoding = 21,
   NSMacOSRomanStringEncoding = 30,
   NSProprietaryStringEncoding = 65536
};
*/

@implementation MyApp
- (NSString*) readLog {
	NSData *data = [NSData dataWithContentsOfFile:@"/tmp/log_sonson.log"];
	return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
- (void) writeLog:(NSString *)str {
	FILE *fp;
	fp = fopen( "/tmp/log_sonson.log", "aw" );
	fprintf( fp, "%s - ", [str UTF8String] );
	fclose( fp );
}
- (void) clearLog {
	FILE *fp;
	fp = fopen( "/tmp/log_sonson.log", "w" );
	fprintf( fp, "" );
	fclose( fp );
}
- (void)navigationBar:(UINavigationBar*)navbar buttonClicked:(int)button {
	[self clearLog];
	[textView_ setText:@"log file cleard."]; 
}
- (void) applicationDidFinishLaunching: (id) unused {
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	
	// Create window
	UIWindow*   window;
	window = [[UIWindow alloc] initWithContentRect:screenRect];
	
	// Create text view
	CGRect  textViewRect = CGRectMake(0, 48, 320, 480);
	CGRect  naviBarRect = CGRectMake(0, 0, 320, 48);
	
	textView_ = [[UITextView alloc] initWithFrame:textViewRect];
	[textView_ setTextSize:10.0f];
	[textView_ setText:@"Hello World?"];
	// Set content view
	[window setContentView:textView_];
	
	// Make navigation var
	UINavigationBar*bar = [[UINavigationBar alloc] initWithFrame:naviBarRect];
	[bar showButtonsWithLeftTitle:@"clear" rightTitle:@"clear" leftBack:NO];
	[bar setBarStyle:5];
	[bar setDelegate:self];
	[window addSubview:bar];
	
	[textView_ setText:[self readLog]];
	
	// Show window
	[window orderFront:self];
	[window makeKey:self];
	[window _setHidden:NO];
}

@end