
#import "MyApp.h"

@implementation MyApp
- (void) applicationDidFinishLaunching: (id) unused {


	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	
	// Create window
	window_ = [[UIWindow alloc] initWithContentRect:screenRect];

	// Create text view
	CGRect  frame;
	frame.origin = CGPointZero;
	frame.size = screenRect.size;
	
	myView_ = [[MyView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[myView_ setImage];
	
	// Set content view
	[window_ setContentView:myView_];
/*
	// Make navigation var
	UINavigationBar*bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.0f)];
	[bar showButtonsWithLeftTitle:@"Left" rightTitle:@"Right" leftBack:NO];
	[bar setBarStyle:5];
	[bar setDelegate:self];
	[window_ addSubview:bar];
*/
	// Show window_
	[window_ orderFront:self];
	[window_ makeKey:self];
	[window_ _setHidden:NO];
}

@end