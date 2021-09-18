
#import "MyApp.h"

@implementation MyView
//////////////////////////////////////////////////////////////////////////////////////////
//
// Gesture Event
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void)gestureStarted:(struct __GSEvent *)event {
	CGPoint left;
	CGPoint right;
	
	[imgView1_ setImage:img1];
	[imgView2_ setImage:img2];
	
	left	= GSEventGetInnerMostPathPosition(event);

	int x1 = (int)left.x - 10;
	int y1 = (int)left.y - 10;
	[imgView1_ setOrigin:CGPointMake( x1, y1 )];
	
	right = GSEventGetOuterMostPathPosition(event);
	int x2 = (int)right.x - 10;
	int y2 = (int)right.y - 10;
	[imgView2_ setOrigin:CGPointMake( x2, y2 )];
	
	NSString *str = [NSString stringWithFormat:@"Start_d(%d,%d) (%d,%d)\n", x1, y1, x2, y2 ];
	[text_ setText:str];

}
- (void)gestureEnded:(struct __GSEvent *)event {
	CGPoint left;
	CGPoint right;
	
	left	= GSEventGetInnerMostPathPosition(event);
	int x1 = (int)left.x - 10;
	int y1 = (int)left.y - 10;
	[imgView1_ setOrigin:CGPointMake( x1, y1 )];
	
	right = GSEventGetOuterMostPathPosition(event);
	int x2 = (int)right.x - 10;
	int y2 = (int)right.y - 10;
	[imgView2_ setOrigin:CGPointMake( x2, y2 )];
	
	NSString *str = [NSString stringWithFormat:@"End _d(%d,%d) (%d,%d)\n", x1, y1, x2, y2 ];
	[text_ setText:str];
}
- (void)gestureChanged:(GSEvent *)event {
	CGPoint left;
	CGPoint right;
	
	left	= GSEventGetInnerMostPathPosition(event);
	int x1 = (int)left.x - 10;
	int y1 = (int)left.y - 10;
	[imgView1_ setOrigin:CGPointMake( x1, y1 )];
	
	right = GSEventGetOuterMostPathPosition(event);
	int x2 = (int)right.x - 10;
	int y2 = (int)right.y - 10;
	[imgView2_ setOrigin:CGPointMake( x2, y2 )];
	
	NSString *str = [NSString stringWithFormat:@"Drag_d(%d,%d) (%d,%d)\n", x1, y1, x2, y2 ];
	[text_ setText:str];
}
//////////////////////////////////////////////////////////////////////////////////////////
//
// Mouse Event
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) mouseDown:(GSEvent *)event {
	CGRect ps =  GSEventGetLocationInWindow( event );
	int x = (int)ps.origin.x - 10;
	int y = (int)ps.origin.y - 10;
	
	NSString *str = [NSString stringWithFormat:@"Down  (%d,%d)\n", x, y ];
	[text_ setText:str];
	[imgView1_ setOrigin:CGPointMake( x, y )];
	[imgView1_ setImage:img1];
	[imgView2_ setImage:img1];
}
- (void)mouseDragged:(struct __GSEvent *)event {
	CGRect ps =  GSEventGetLocationInWindow( event );
	int x = (int)ps.origin.x - 10;
	int y = (int)ps.origin.y - 10;
	
	NSString *str = [NSString stringWithFormat:@"Drag  (%d,%d)\n", x, y ];
	[text_ setText:str];
	[imgView1_ setOrigin:CGPointMake( x, y )];
}
- (void)mouseUp:(struct __GSEvent *)event {
	CGRect ps =  GSEventGetLocationInWindow( event );
	int x = (int)ps.origin.x - 10;
	int y = (int)ps.origin.y - 10;
	
	NSString *str = [NSString stringWithFormat:@"Up   (%d,%d)\n", x, y ];
	[text_ setText:str];
	[imgView1_ setOrigin:CGPointMake( x, y )];
}
- (BOOL)canHandleGestures {
	return YES;					// for Gesture
}
- (BOOL)cancelMouseTracking {
	return NO;					// for Single touch
}
- (void) setImage {
	// Set Enable Gesture heard from Doom dev wiki.
//	[self setEnabledGestures: 2];
//	[self setValue: [NSNumber numberWithBool: NO ] forGestureAttribute: 7];
//	[self setValue: [NSNumber numberWithBool: NO ] forGestureAttribute: 4];
//	[self setValue: [NSNumber numberWithBool: YES] forGestureAttribute: 5];
	
	// Set Message View
	text_ = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
	[self addSubview:text_];
	
	// Make Cross Hair Cursor
	img1 = [[UIImage imageAtPath:
		 [[NSBundle mainBundle] 
			 pathForResource:@"crossHair01"
			 ofType:@"png" 
			 inDirectory:@"/"]] retain];
	img2 = [[UIImage imageAtPath:
		 [[NSBundle mainBundle] 
			 pathForResource:@"crossHair02"
			 ofType:@"png" 
			 inDirectory:@"/"]] retain];
	imgView1_ = [[UIImageView alloc] initWithFrame:
		  CGRectMake(0.0, 0.0, 64.0, 64.0)];	
	imgView2_ = [[UIImageView alloc] initWithFrame:
		  CGRectMake(0.0, 0.0, 64.0, 64.0)];	
	[imgView1_ setImage:img1];
	[imgView2_ setImage:img2];
	[self addSubview:imgView1_];
	[self addSubview:imgView2_];
}
@end