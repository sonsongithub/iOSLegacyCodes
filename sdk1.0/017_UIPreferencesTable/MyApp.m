
#import "MyApp.h"

@implementation MyApp
- (void) applicationDidFinishLaunching: (id) unused {
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	
	CGRect sizeTextView = CGRectMake(0, 0, 320, 480);
	
	// Create window
	UIWindow*   window;
	window = [[UIWindow alloc] initWithContentRect:screenRect];
	
	// Create text view
	preferenceView_ = [[PreferenceView alloc] initWithFrame:sizeTextView];
	

	
	// Set content view
	[window setContentView:preferenceView_];
	
	// Show window
	[window orderFront:self];
	[window makeKey:self];
	[window _setHidden:NO];
}
@end