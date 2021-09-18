
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>

@interface SwipeCell : UIImageAndTextTableCell {
	id	delegate_;
}
- (id) initWithDelegate:(id)delegate;
@end
