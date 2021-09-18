
#import "MyApp.h"

@implementation MyApp
- (void) applicationDidFinishLaunching: (id) unused {
	// Is this needed?
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	
	// Create window
	window_ = [[UIWindow alloc] initWithContentRect:screenRect];
	
	// Create GLView
	glView_ = [UIGLView alloc];
	[glView_ initWithFrame: screenRect];
	[window_ setContentView: glView_];
	
	// Show window_
	[window_ orderFront:self];
	[window_ makeKey:self];
	[window_ _setHidden:NO];
	
	// Set Timer
	drawTimer_ = [NSTimer 
		scheduledTimerWithTimeInterval:0.033
		target: self 
		selector: @selector(update) 
		userInfo: nil
		repeats: YES
	];
	
	// release pool
	[pool release];
}
- (void)applicationWillSuspend {
	[drawTimer_ invalidate];
}
- (void) didWake {
	// lockされていて，ボタンが押されたときにコールされる
}
- (void) applicationDidResumeFromUnderLock {
	// lockされていて，ボタンが押されて，スライドでunlockされたときにコールされる
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	drawTimer_ = [NSTimer 
		scheduledTimerWithTimeInterval:0.033
		target: self 
		selector: @selector(update) 
		userInfo: nil
		repeats: YES
	];
	[pool release];
}
- (void)applicationWillTerminate {
	[drawTimer_ invalidate];
	[glView_ release];
}
- (void) update {
    [glView_ setNeedsDisplay];
}
@end