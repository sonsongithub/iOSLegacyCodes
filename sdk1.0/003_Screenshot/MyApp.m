
#import "MyApp.h"

@implementation MyApp
- (void) saveScreenshot {
	CGRect 		bounds = [UIHardware fullScreenApplicationContentRect];
	CGImageRef	image = [window_ createSnapshotWithRect: bounds];
	char buff[512];
	
	// Make file name
	snprintf( buff, sizeof(buff), "/tmp/%d.png", (int)[[NSDate date] timeIntervalSince1970] );	
	CFStringRef	path = CFStringCreateWithCString( nil, buff, kCFStringEncodingASCII );
	CFURLRef	url = CFURLCreateWithFileSystemPath( nil, path, kCFURLPOSIXPathStyle, 0 );
	
	// Make kUTTypePNG -> public.png
	CFStringRef type = CFStringCreateWithCString( nil, "public.png", kCFStringEncodingASCII );
	size_t count = 1; 
	CFDictionaryRef options = NULL;
	
	// Writing
	CGImageDestinationRef dest = CGImageDestinationCreateWithURL(url, type, count, options);
	CGImageDestinationAddImage(dest, image, NULL);
	CGImageDestinationFinalize(dest);
	
	// Release
	CFRelease(dest);
	CGImageRelease( image );
	CFRelease( url );
	CFRelease( type );
}
- (void) navigationBar:(UINavigationBar*)navbar buttonClicked:(int)button {
	// Take screen shot
	[self saveScreenshot];
	// Set Message
	[textView_ setText:@"Took a screenshot!"];
}	
- (void) applicationDidFinishLaunching: (id) unused {
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	
	// Create window
	window_ = [[UIWindow alloc] initWithContentRect:screenRect];
	
	// Make size
	CGRect sizeTextView = CGRectMake(0, 48, 320, 480);
	CGRect sizeNavigationBar = CGRectMake(0, 0, 320, 48);
	
	// Set content view
	textView_ = [[UITextView alloc] initWithFrame:sizeTextView];
	[textView_ setText:@"Hello World?"];
	[window_ setContentView:textView_];
	
	// Make navigation var
	UINavigationBar*bar = [[UINavigationBar alloc] initWithFrame:sizeNavigationBar];
	[bar showButtonsWithLeftTitle:@"Take" rightTitle:@"Take" leftBack:NO];
	[bar setBarStyle:5];
	[bar setDelegate:self];
	[window_ addSubview:bar];
	
	// Show window_
	[window_ orderFront:self];
	[window_ makeKey:self];
	[window_ _setHidden:NO];
}

@end