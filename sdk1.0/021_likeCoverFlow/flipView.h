
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import <GraphicsServices/GraphicsServices.h>

#define	CENTER_POLYGON	0
#define	RIGHT_POLYGON	1
#define	LEFT_POLYGON	2

@interface flipView : UIView {	
	int		currentMode_;
	BOOL	isAnimatedSlow_;
}
- (id) initWithFrame:(CGRect)frame;
- (id) actionForLayer:(LKLayer *)layer forKey:(NSString *)key;
- (void) setX:(float)x andY:(float)y;
- (void) setTransform;
@end
