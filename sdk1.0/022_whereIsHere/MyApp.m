
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
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	float black[4] = {1, 1, 1, 1};
	float white[4] = {0.75, 0.75, 0.75, 1};
	[window setBackgroundColor: CGColorCreate( colorSpace, black)];
	
	// Create main view
	id mainView = [[UIView alloc] initWithFrame:CGRectMake( 20, 20, 300, 440 )];
	[mainView setBackgroundColor: CGColorCreate( colorSpace, white)];
	[window setContentView:mainView];
	
	id view1 = [[UIView alloc] initWithFrame:CGRectMake( 20, 20, 150, 180 )];
	[mainView addSubview:view1];
	float view_color1[4] = {0.5, 0.5, 0.5, 1};
	[view1 setBackgroundColor: CGColorCreate( colorSpace, view_color1)];
	[[view1 _layer] setZPosition:10];
	
	id view2 = [[UIView alloc] initWithFrame:CGRectMake( 40, 40, 150, 180 )];
	[mainView addSubview:view2];
	float view_color2[4] = {0.4, 0.4, 0.4, 1};
	[view2 setBackgroundColor: CGColorCreate( colorSpace, view_color2)];
	[[view2 _layer] setZPosition:-10];
	
	id view3 = [[flipView alloc] initWithFrame:CGRectMake( 60, 60, 200, 110 )];
	[mainView addSubview:view3];
	id view4 = [[flipView alloc] initWithFrame:CGRectMake( 60, 60, 200, 110 )];
	[mainView addSubview:view4];
	
	// Show window
	[window orderFront:self];
	[window makeKey:self];
	[window _setHidden:NO];
}

@end