
#import "flipView.h"

@implementation flipView

- (id) initWithFrame:(CGRect)frame {
	CGRect rect = CGRectMake( 60, 130, 200, 200 );
	self = [super initWithFrame:rect];	
	
	// set color
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	float black[4] = {1, 1, 1, 1};
	[self setBackgroundColor: CGColorCreate( colorSpace, black)];
	
	currentMode_ = -1;
	isAnimatedSlow_ = NO;
	
	// set content
	UIImage *img = [UIImage imageAtPath:
		 [[NSBundle mainBundle]
			 pathForResource:@"icon"
			 ofType:@"png" 
			 inDirectory:@"/"]];
	[[self _layer] setContents:(id)[img imageRef]];
	
	return self;
}

- (void) setMatrix:(LKTransform) m {
	// set perspective
    LKTransform sublayerTransform = LKTransformIdentity;
    sublayerTransform.m34 = 1.0 / -420.0;
    [[[self superview] _layer] setSublayerTransform:sublayerTransform];
	[[self _layer] setTransform:m];
}

- (void) setMatrix:(LKTransform) m withMode:(int)mode{
	isAnimatedSlow_ = NO;
	if( mode == CENTER_POLYGON ) {
		isAnimatedSlow_ = YES;
	}
	else if( currentMode_ == CENTER_POLYGON ) {
		isAnimatedSlow_ = YES;
	}
	currentMode_ = mode;
	[self setMatrix:m];
}

- (id)actionForLayer:(LKLayer *)layer forKey:(NSString *)key {
	if ([key isEqualToString:@"transform"]) {
		LKBasicAnimation *flipAnimation = [LKBasicAnimation animationWithKeyPath:key];
		[flipAnimation setTimingFunction:[LKTimingFunction functionWithName:@"easeInEaseOut"]];

		if( isAnimatedSlow_ ) {
			[flipAnimation setDuration:200.0]; // take yr time there, partner
			[flipAnimation setSpeed:1.5]; // take yr time there, partner
		}
		else {
			[flipAnimation setDuration:0.0]; // take yr time there, partner
			[flipAnimation setSpeed:20.0]; // take yr time there, partner
		}
		return flipAnimation;
	}
	return [super actionForLayer:layer forKey:key];
}
@end
