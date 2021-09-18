
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import <GraphicsServices/GraphicsServices.h>

@interface flipView : UIView {	
}
- (id) initWithFrame:(CGRect)frame;
- (id) actionForLayer:(LKLayer *)layer forKey:(NSString *)key;
- (void) mouseDown:(GSEvent *)event;
- (void) setTransform;
@end
