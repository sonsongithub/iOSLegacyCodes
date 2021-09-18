
#import "MyApp.h"
#import "flipView.h"

@implementation MyApp
- (void) applicationDidFinishLaunching: (id) unused {
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	
	// Create window
	UIWindow*   window;
	window = [[UIWindow alloc] initWithContentRect:screenRect];
	
	// Create main view
	id mainView = [[UIView alloc] initWithFrame:[window bounds]];
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	float white[4] = {1, 1, 1, 1};
	[mainView setBackgroundColor: CGColorCreate( colorSpace, white)];
	[window setContentView:mainView];
	
	// add flip view
	id view = [[flipView alloc] initWithFrame:CGRectMake( 0, 0, 320, 460 )];
	[mainView addSubview:view];
	
	// Show window
	[window orderFront:self];
	[window makeKey:self];
	[window _setHidden:NO];
}

@end