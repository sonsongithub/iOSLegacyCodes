
#import "SwipeCell.h"

#import <GraphicsServices/GraphicsServices.h>

@implementation SwipeCell

- (id) initWithDelegate:(id)delegate {
	self = [super init];
	
	delegate_ = delegate;
	
	return self;
}

- (void) removeControlWillHideRemoveConfirmation:(id)fp8 {
	[ self _showDeleteOrInsertion:NO
		  withDisclosure:NO
		  animated:YES
		  isDelete:YES
		  andRemoveConfirmation:YES
	];
}

- (void)_willBeDeleted {
	NSLog( @"wilBeDeleted" );
	[delegate_ delete:self];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
	NSLog(@"UITableCell: respondsToSelector: selector = %@", NSStringFromSelector(aSelector));
	return [super respondsToSelector:aSelector];
}
@end
