
#import "MyApp.h"

@implementation MyApp
- (void)navigationBar:(UINavigationBar*)navbar buttonClicked:(int)button {
	switch (button) {
		case 0:
			[textView_ setText:@"Right"]; 
			break;
		case 1:
			[textView_ setText:@"Left"]; 
			break;
	}
}	
- (void) applicationDidFinishLaunching: (id) unused {
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	
	// Create window
	window_ = [[UIWindow alloc] initWithContentRect:screenRect];
	
	// Make size
	CGRect sizeTextView = CGRectMake(0, 48, 320, 480);
	CGRect sizeNavigationBar = CGRectMake(0, 0, 320, 48);
	
	// Set content view
	textView_ = [[UITextView alloc] initWithFrame:sizeTextView];
	[textView_ setText:@"Hello World?"];
	[window_ setContentView:textView_];
	
	// Make navigation var
	UINavigationBar*bar = [[UINavigationBar alloc] initWithFrame:sizeNavigationBar];
	[bar showButtonsWithLeftTitle:@"Left" rightTitle:@"Right" leftBack:NO];
	[bar setBarStyle:5];
	[bar setDelegate:self];
	UINavigationItem *title = [[UINavigationItem alloc] initWithTitle: @"NaviBar"];
	[bar pushNavigationItem: title];
	[window_ addSubview:bar];
	
	// Show window_
	[window_ orderFront:self];
	[window_ makeKey:self];
	[window_ _setHidden:NO];
}

@end