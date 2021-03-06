
#import "SwipeTable.h"
#import <GraphicsServices/GraphicsServices.h>

@implementation SwipeTable
- (int) swipe:(int)direction withEvent:(struct __GSEvent *)event {
	if ((direction == kSwipeDirectionRight) || (direction == kSwipeDirectionLeft) ){
		CGRect rect = GSEventGetLocationInWindow(event);
		CGPoint point = CGPointMake(rect.origin.x, rect.origin.y); // if you have a titleNavBar then you need to subtract the titleNavBar height from rect.origin.y

		CGPoint offset = _startOffset; 
		point.x += offset.x;
		point.y += offset.y;
		
		int row = [self rowAtPoint:point];
		
	
		[[self visibleCellForRow:row column:0] _showDeleteOrInsertion:YES withDisclosure:NO animated:YES isDelete:YES andRemoveConfirmation:YES];
	}
	return [super swipe:direction withEvent:event];
}

- (BOOL) respondsToSelector:(SEL)aSelector {
	NSLog(@"UITable: respondsToSelector: selector = %@", NSStringFromSelector(aSelector));
	return [super respondsToSelector:aSelector];
}

@end
