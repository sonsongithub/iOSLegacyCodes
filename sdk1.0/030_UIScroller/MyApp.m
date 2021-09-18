
#import "MyScroller.h"
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
	id mainView = [[MyScroller alloc] initWithFrame:[window bounds]];
	[mainView setContentSize:CGSizeMake( 320, 2000 )];
	[mainView setDelegate:mainView];
	[window setContentView:mainView];

	// Show window
	[window orderFront:self];
	[window makeKey:self];
	[window _setHidden:NO];
}

@end