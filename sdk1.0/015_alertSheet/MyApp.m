
#import "MyApp.h"

@implementation MyApp
- (void) applicationDidFinishLaunching: (id) unused {
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	
	// Create window
	UIWindow*   window;
	window = [[UIWindow alloc] initWithContentRect:screenRect];
	CGRect frame = CGRectMake(0.0f, 0.0f, screenRect.size.width, screenRect.size.height);
	// Create text view

	UITextView* textView = [[UITextView alloc] initWithFrame:frame];
	[textView setText:@"Hello World?"];
	
	// Set content view
	[window setContentView:textView];
	
	// Show window
	[window orderFront:self];
	[window makeKey:self];
	[window _setHidden:NO];
	
	// make alert sheet
	UIAlertSheet *alert = [[UIAlertSheet alloc] initWithFrame:CGRectMake(0, 240, 320, 240)];
	[alert setTitle:@"Serious Warning"];
	[alert setBodyText:@"This is an alert."];
	[alert addButtonWithTitle:@"OK" ];
	[alert addButtonWithTitle:@"Cancel" ];
	[alert setRunsModal:NO];
	[alert setAlertSheetStyle:0];
	[ alert setDelegate: self ];
	[alert presentSheetInView: textView ];
	
	/* key methods
	- (void)presentSheetFromBehindView:(id)fp8;
	- (void)presentSheetFromAboveView:(id)fp8;
	- (void)presentSheetInView:(id)fp8;
	- (void)presentSheetToAboveView:(id)fp8;
	*/
}

- (void)alertSheet:(UIAlertSheet*)sheet buttonClicked:(int)button {
	if ( button == 1 ){
		NSLog(@"change");
		[sheet dismiss];
	}
	else if ( button == 2 ) {
		NSLog(@"Cancel");
		[sheet dismiss];
	}
}

@end