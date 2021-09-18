
#import "AnimationView.h"
#import "MyApp.h"

@implementation MyApp
- (void) applicationDidFinishLaunching: (id) unused {
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	
	// Create window
	UIWindow*   window;
	window = [[UIWindow alloc] initWithContentRect:screenRect];
	
	// Create text view
	id view = [[AnimationView alloc] initWithFrame:[window bounds]];
	
	// Set content view
	[window setContentView:view];
	
	// Show window
	[window orderFront:self];
	[window makeKey:self];
	[window _setHidden:NO];
}
@end