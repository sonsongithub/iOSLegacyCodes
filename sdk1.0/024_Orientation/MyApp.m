
#import "MyApp.h"
#import "TransitionView.h"
#import <GraphicsServices/GraphicsServices.h>

@implementation MyApp

- (void) applicationDidFinishLaunching: (id) unused {
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	
	// Create window
	window_ = [[UIWindow alloc] initWithContentRect:CGRectMake( 0, 0, 320, 480 )];
	view = [[TransitionView alloc] initWithFrame:CGRectMake( 0, 0, 320, 480 )];
	
	// Set content view
	[window_ setContentView:view];
	[view transitToView1];
	
	// detect orientation
	[UIHardware deviceOrientation:YES];
	
	// Show window
	[window_ orderFront:self];
	[window_ makeKey:self];
	[window_ _setHidden:NO];
}

- (void)deviceOrientationChanged:(GSEvent *)event {
	int orientation = [UIHardware deviceOrientation:YES];
	int anim = 0;
	CGRect rect;
	switch( orientation ) {
		case UIAppOrientLeft:
			[view transitToView2:90];
			[self setStatusBarMode:1 orientation:90 duration:0.5 fenceID:0 animation:anim];
			break;
		case UIAppOrientRight:
			[view transitToView2:-90];
			[self setStatusBarMode:1 orientation:-90 duration:0.5 fenceID:0 animation:anim];
			break;
		case UIAppOrientNormal:
			[view transitToView1];
			[self setStatusBarMode:0 orientation:0 duration:0.5 fenceID:0 animation:anim];
			break;
		case UIAppOrientUpsideDown:
		case UIAppOrientScreenUp:
		case UIAppOrientUnknown:
		case UIAppOrientProne:
		default:
			break;
	}
}

@end