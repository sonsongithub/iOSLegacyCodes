#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import <GraphicsServices/GraphicsServices.h>

@interface MyApp : UIApplication {
	UIWindow*   window_;
	UITextView* textView_;
	NSMutableArray* titles_;
}
@end
