#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import "UIGLView.h"

@interface MyApp : UIApplication {
	UIWindow*	window_;
	UIGLView*	glView_;
	NSTimer*	drawTimer_;
}
@end
