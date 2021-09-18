
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
	UITextView* textView = [[UITextView alloc] initWithFrame:[window bounds]];
	[textView setText:@"Hello World?"];
	
	// Set content view
	[window setContentView:textView];
	
	// Show window
	[window orderFront:self];
	[window makeKey:self];
	[window _setHidden:NO];
}
@end