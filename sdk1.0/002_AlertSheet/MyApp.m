
#import "MyApp.h"

@implementation MyApp
- (void)alertSheet:(UIAlertSheet*)sheet buttonClicked:(int)button {
	if ( button == 1 )
		[textView_ setText:@"You clicked OK."]; 
	else if ( button == 2 )
		[textView_ setText:@"You clicked Cancel."]; 
	[sheet dismiss];
}
- (void)navigationBar:(UINavigationBar*)navbar buttonClicked:(int)button {
	NSArray *buttons = nil;
	UIAlertSheet *alertSheet = nil;
	switch (button) {
		case 0:
			// Allert sheet displayed at centre of screen.
			buttons = [NSArray arrayWithObjects:@"OK", @"Cancel", nil];
			alertSheet = [[UIAlertSheet alloc] initWithTitle:@"An Alert" buttons:buttons defaultButtonIndex:1 delegate:self context:self];
			[alertSheet setBodyText:@"You pushed Left."];
			[alertSheet popupAlertAnimated:YES];
			break;
		case 1:
			buttons = [NSArray arrayWithObjects:@"OK", @"Cancel", nil];
			alertSheet = [[UIAlertSheet alloc] initWithTitle:@"An Alert" buttons:buttons defaultButtonIndex:1 delegate:self context:self];
			[alertSheet setBodyText:@"You pushed Right."];
			[alertSheet popupAlertAnimated:YES];
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
	[window_ addSubview:bar];
	
	// Show window_
	[window_ orderFront:self];
	[window_ makeKey:self];
	[window_ _setHidden:NO];
}

@end