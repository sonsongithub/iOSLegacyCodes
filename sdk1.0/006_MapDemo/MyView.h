#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>

@interface MyControllerView : UIView {
	UITextView* text_;
	CGPoint			position_;
	CGPoint			moveOrigin_;
	UIImageView*	mapView_;
	id				target_;
	BOOL			dragged_;
	
	CGPoint			startLeft_;
	CGPoint			startRight_;
	CGRect startTargetRect_;
}
@end
