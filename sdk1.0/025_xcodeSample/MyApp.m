
#import "MyApp.h"
#import "global.h"

@implementation MyApp
- (void) applicationDidFinishLaunching: (id) unused {
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	
	// Create window
	UIWindow*   window;
	window = [[UIWindow alloc] initWithContentRect:screenRect];
	
	// Create main view
	id mainView = [[UITextView alloc] initWithFrame:[window bounds]];
	[mainView setText:@"Hello world"];
	[window setContentView:mainView];

	// Show window
	[window orderFront:self];
	[window makeKey:self];
	[window _setHidden:NO];
}

@end