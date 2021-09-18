
#import "MyApp.h"
#import "MainView.h"
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
	id mainView = [[MainView alloc] initWithFrame:[window bounds]];
	[window setContentView:mainView];

	// Show window
	[window orderFront:self];
	[window makeKey:self];
	[window _setHidden:NO];
}

@end