
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
	

	// Make Map Image
	UIImage *img = [[UIImage imageAtPath:
		 [[NSBundle mainBundle] 
			 pathForResource:@"map"
			 ofType:@"png" 
			 inDirectory:@"/"]] retain];
	mapView_ = [[UIImageView alloc] initWithFrame:
	CGRectMake(0.0, 0.0, 320.0, 480.0)];
	[mapView_ setImage:img];
	[window_ setContentView:mapView_];
	//

	myView_ = [[MyControllerView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];

	// Only create the color space once.

	[myView_ setImage:mapView_];
	// Set content view
	[window_ addSubview:myView_];
	//[window_ setContentView:myView_];
	
	// Show window_
	[window_ orderFront:self];
	[window_ makeKey:self];
	[window_ _setHidden:NO];
}

@end