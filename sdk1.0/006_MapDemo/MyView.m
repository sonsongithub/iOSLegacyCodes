
#import "MyApp.h"

@implementation MyControllerView
//////////////////////////////////////////////////////////////////////////////////////////
//
// Gesture Event
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void)gestureStarted:(struct __GSEvent *)event {
	CGPoint left = GSEventGetInnerMostPathPosition(event);
	CGPoint right = GSEventGetOuterMostPathPosition(event);
	dragged_ = NO;
	
	startTargetRect_ = [target_ bounds];
	
	startLeft_ = left;
	startRight_ = right;
}
- (void)gestureEnded:(struct __GSEvent *)event {
	startLeft_ = CGPointMake( 0, 0 );
	startRight_ = CGPointMake( 0, 0 );
	dragged_ = NO;
	
	position_ = [target_ origin];
}
- (void)gestureChanged:(GSEvent *)event {
	CGPoint left = GSEventGetInnerMostPathPosition(event);
	CGPoint right = GSEventGetOuterMostPathPosition(event);
	dragged_ = NO;
	
	CGRect nowRect = CGRectMake( left.x, left.y, right.x, right.y );
	
	CGPoint nowCenter = CGPointMake( ( left.x + right.x ) / 2, ( left.y + right.y ) / 2 );
	CGPoint startCenter = CGPointMake( ( startLeft_.x + startRight_.x ) / 2, ( startLeft_.y + startRight_.y ) / 2 );
	
	int startWidth = abs( startLeft_.x - startRight_.x );
	int startHeight = abs( startLeft_.y - startRight_.y );
	
	int nowWidth = abs( left.x - right.x );
	int nowHeight = abs( left.y - right.y );
	
	double ratio = (double)nowWidth / (double) startWidth;
	
	CGRect nowTargetRect = [target_ bounds];
	
	[target_ setBounds:CGRectMake( 0, 0, startTargetRect_.size.width*ratio, startTargetRect_.size.height*ratio) ];
		
	CGPoint temp_pos = CGPointMake( position_.x + nowCenter.x - startCenter.x , position_.y + nowCenter.y - startCenter.y );
	[target_ setOrigin:temp_pos];
}
//////////////////////////////////////////////////////////////////////////////////////////
//
// Mouse Event
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) mouseDown:(GSEvent *)event {
	CGRect ps =  GSEventGetLocationInWindow( event );
	moveOrigin_ = ps.origin;
	dragged_ = YES;
#ifdef _DEBUG
	NSString *str = [NSString stringWithFormat:@"Down (%d,%d)\n", ps.origin.x, ps.origin.y ];
	[text_ setText:str];
#endif
}
- (void)mouseDragged:(struct __GSEvent *)event {
	if( dragged_ == NO ) {
		[self mouseDown:event];
		return;
	}
	CGRect ps =  GSEventGetLocationInWindow( event );
	CGPoint temp_pos = CGPointMake( position_.x - moveOrigin_.x + ps.origin.x , position_.y - moveOrigin_.y + ps.origin.y );
	[target_ setOrigin:temp_pos];
#ifdef _DEBUG
	NSString *str = [NSString stringWithFormat:@"Drag (%d,%d)\n", ps.origin.x, ps.origin.y ];
	[text_ setText:str];
#endif
}
- (void)mouseUp:(struct __GSEvent *)event {
	CGRect ps =  GSEventGetLocationInWindow( event );
	position_ = CGPointMake( position_.x - moveOrigin_.x + ps.origin.x , position_.y - moveOrigin_.y + ps.origin.y );
	dragged_ = NO;
#ifdef _DEBUG
	NSString *str = [NSString stringWithFormat:@"Up   (%d,%d)\n", ps.origin.x, ps.origin.y ];
	[text_ setText:str];
#endif
}
- (BOOL)canHandleGestures {
	return YES;					// for Gesture
}
- (BOOL)cancelMouseTracking {
	return NO;					// for Single touch
}
- (void) setImage:(id) target {
	// Set Enable Gesture heard from Doom dev wiki.
	[self setEnabledGestures: 2];
	[self setValue: [NSNumber numberWithBool: NO ] forGestureAttribute: 7];
	[self setValue: [NSNumber numberWithBool: NO ] forGestureAttribute: 4];
	[self setValue: [NSNumber numberWithBool: YES] forGestureAttribute: 5];
	[self setAlpha: 0.1f];
	position_	= CGPointMake( 0, 0 );
	moveOrigin_	= CGPointMake( 0, 0 );	
	target_ = target;
	dragged_ = NO;
	// for Debug
#ifdef _DEBUG
	[self setAlpha: 0.1f];
	text_ = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
	[self addSubview:text_];
	[text_ setText:@"OK"];
#endif
}
@end