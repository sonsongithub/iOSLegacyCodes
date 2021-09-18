
#import "TransitionView.h"

@implementation TransitionView

- (id) initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	frame.origin.x = 0;
	frame.origin.y = 0;
	CGRect view1_rect = CGRectMake( 0, 20, 320, 480 );
	CGRect view2_rect = CGRectMake(-80, 80, 480, 320 );
	view1_ = [[UITextView alloc] initWithFrame:view1_rect];
	view2_ = [[UITextView alloc] initWithFrame:view2_rect];

	[view1_ setText:@"This is view1.This is view1.This is view1.This is view1.This is view1.This is view1.This is view1.This is view1.This is view1.This is view1.This is view1."];
	[view2_ setText:@"This is view2.This is view2.This is view2.This is view2.This is view2."];
	
	return self;
}

- (void) transitToView1 {
	if( now_view_ != view1_ ) {
		[self transition:6 toView:view1_];
		now_view_ = view1_;
	}
}

- (void) transitToView2:(int)deg {
	if( now_view_ != view2_ ) {
		[self transition:6 toView:view2_];
		now_view_ = view2_;
		[view2_ setRotationDegrees:deg duration:0];
	}
	else
		[view2_ setRotationDegrees:deg duration:0.5];
}

@end
