
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import <GraphicsServices/GraphicsServices.h>

@interface MainView : UIView {
	float	prevMouseX_;
	float	distanceX_;
	float	bufX_;
	float	prevMouseY_;
	float	distanceY_;
	float	bufY_;
	//
	NSMutableArray *childViews_;
}
- (void) dealloc;
- (id) initWithFrame:(CGRect)frame;
- (void) updateObjectsWithX:(float) x andY:(float) y;
- (void) mouseDown:(GSEvent *)event;
- (void) mouseDragged:(GSEvent *)event;
@end