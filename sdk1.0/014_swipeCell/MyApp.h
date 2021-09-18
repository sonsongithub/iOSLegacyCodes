#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>

#import "SwipeTable.h"

@interface MyApp : UIApplication {
	SwipeTable		*table_;
	NSMutableArray	*ary_;
	id				window_;
}
- (void) setupTable;
- (void) setupButtonBar;
- (void) makeCells;
@end
