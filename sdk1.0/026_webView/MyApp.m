
#import "MyApp.h"
#import "MyWebView.h"
#import <GraphicsServices/GraphicsServices.h>
#import "global.h"

@implementation MyApp
- (void) applicationDidFinishLaunching:(id)unused {
	// Get screen rect
	CGRect screenRect = [UIHardware fullScreenApplicationContentRect];
	
	// Create window
	UIWindow* window = [[UIWindow alloc] initWithContentRect:screenRect];
	
	// Create main view
	id mainView = [[MyWebView alloc] initWithFrame:CGRectMake( 0, 0, 320, 460)];
	[window setContentView:mainView];

	// Show window
	[window orderFront:self];
	[window makeKey:self];
	[window _setHidden:NO];
}

@end