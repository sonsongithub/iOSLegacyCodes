
#import "MainView.h"
#import "flipView.h"

@implementation MainView

- (void) dealloc {
	[childViews_ release];
	[super dealloc];
}

- (id) initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	// set background color
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	float black[4] = {0, 0, 0, 1};
	[self setBackgroundColor: CGColorCreate( colorSpace, black)];

	// add flip child view
	int i = 0;
	childViews_ = [[NSMutableArray array] retain];
	for( i = 0; i < 40; i++ ) {
		id view = [[flipView alloc] initWithFrame:CGRectMake( 0, 0, 320, 460 )];
		[childViews_ addObject:view];
	}
	return self;
}

- (void) updateObjectsWithX:(float) x andY:(float) y {
	int count = [childViews_ count];
	int i;
	float depth_offset = -40;
	float depth_front = 80;
	float y_offset = 50;
	float animation_boundary = 35;
	float ratio_depth = 0.31;
	
	float margin = 70;
	int center = (int) - ( y  ) / margin;
	int draw_margin = 3;

	int start = center - draw_margin;
	int end = center + draw_margin;
	
	if( start < 0 )
		start = 0;
	if( end > count )
		end = count;
		
	for( i = 0; i < count; i++ ) {
		id view = [childViews_ objectAtIndex:i];
		[view removeFromSuperview];
	}
	
	float deg = 1.20;

	for( i = start; i < end; i++ ) {
		id view = [childViews_ objectAtIndex:i];
		int mode = CENTER_POLYGON;
		LKTransform m;
		if( i == center ) {
			m = LKTransformIdentity;
			m.m42 = 0;
			m.m43 = depth_front;
		}
		else if( i > center ) {
			m = LKTransformMakeRotation( deg, 1, 0, 0);
			m.m42 = i * ( margin ) + y + y_offset;
			m.m43 = depth_offset - ratio_depth * abs( i - center );
		}
		else if( i < center ) {
			m = LKTransformMakeRotation(-deg, 1, 0, 0);
			m.m42 = i * ( margin ) + y - y_offset;
			m.m43 = depth_offset - ratio_depth * abs( i - center );
		}
		if( m.m42 > animation_boundary || m.m42 < -animation_boundary )
			mode = LEFT_POLYGON;
		[self addSubview:view];
		[view setMatrix:m withMode:mode];
	}
}

- (void) mouseDown:(GSEvent *)event {
	CGRect ps =  GSEventGetLocationInWindow( event );
	float x = (float)ps.origin.x;
	float y = (float)ps.origin.y;

	prevMouseX_ = x;
	bufX_ = distanceX_;
	prevMouseY_ = y;
	bufY_ = distanceY_;
	
}

- (void)mouseDragged:(struct __GSEvent *)event {
	CGRect ps =  GSEventGetLocationInWindow( event );
	float x = (float)ps.origin.x;
	float y = (float)ps.origin.y;

	float diffX = (float)(x - prevMouseX_);
	float diffY = (float)(prevMouseY_ - y);
	
	distanceX_ = bufX_ + diffX;
	distanceY_ = bufY_ + diffY;
	[self updateObjectsWithX:distanceX_ andY:distanceY_];
}

@end

