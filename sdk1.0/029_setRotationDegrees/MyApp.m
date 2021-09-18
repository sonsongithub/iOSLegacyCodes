
#import "MyApp.h"
#import "global.h"

@implementation MyApp

- (void) applicationDidFinishLaunching: (id) unused {
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	
	// Create window
	window_ = [[UIWindow alloc] initWithContentRect:CGRectMake( 0, 0, 320, 480 )];
	
	// Create main view
	mainView_ = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, 320, 480 )];
	[window_ setContentView:mainView_];
	
	[self makeView1];
	[self makeView2];
	
	int orientation = [UIHardware deviceOrientation:YES];
	
	// Show window
	[window_ orderFront:self];
	[window_ makeKey:self];
	[window_ _setHidden:NO];
}

- (void)deviceOrientationChanged:(GSEvent *)event {
	double deg;
	int orientation = [UIHardware deviceOrientation:YES];
	switch( orientation ) {
		case UIAppOrientLeft:
			deg = 90;
			[UIApp setStatusBarMode:1 orientation:deg duration:0.5 fenceID:0 animation:0];
			[view2_ setRotationDegrees:deg duration:0.5];
			//[view_ setRotation:90];
			break;
		case UIAppOrientRight:
			deg = -90;
			[UIApp setStatusBarMode:1 orientation:deg duration:0.5 fenceID:0 animation:0];
			[view2_ setRotationDegrees:deg duration:0.5];
			//[view_ setRotation:-90];
			break;
		case UIAppOrientNormal:
			deg = 0;
			[UIApp setStatusBarMode:1 orientation:deg duration:0.5 fenceID:0 animation:0];
			[view2_ setRotationDegrees:deg duration:0.5];
			//[view_ setRotation:0];
			break;
		case UIAppOrientUpsideDown:
		case UIAppOrientScreenUp:
		case UIAppOrientUnknown:
		case UIAppOrientProne:
		default:
			break;
	}
}

- (void) makeView1 {
	view1_ = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, 320, 480 )];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"320x480" ofType:@"png"];
	UIImage *img = [UIImage imageAtPath:path];
	[[view1_ _layer] setContents:(id)[img imageRef]];
	[mainView_ addSubview:view1_];
}


- (void) makeView2 {
	view2_ = [[UIView alloc] initWithFrame:CGRectMake( -80, 80, 480, 320 )];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"480x480" ofType:@"png"];
	UIImage *img = [UIImage imageAtPath:path];
	[[view2_ _layer] setContents:(id)[img imageRef]];
	[mainView_ addSubview:view2_];
}

@end