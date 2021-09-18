
#import "flipView.h"

@implementation flipView

- (id) initWithFrame:(CGRect)frame {
	CGRect rect = CGRectMake( 60, 130, 200, 200 );
	self = [super initWithFrame:rect];	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	float black[4] = {1, 0, 0, 1};
	[self setBackgroundColor: CGColorCreate( colorSpace, black)];
	return self;
}

- (void) mouseDown:(GSEvent *)event {
	[self setTransform];
}

- (void) setTransform {
    LKTransform sublayerTransform = LKTransformIdentity;		// perspective
    sublayerTransform.m34 = 1.0 / -420.0;
    [[[self superview] _layer] setSublayerTransform:sublayerTransform];
	LKTransform m;
/*	transform matrix for column vector
	m.m11 = 1.0f;		m.m21 = 0.0f;		m.m31 = 0.0f;		m.m41 = 0.0f;
	m.m12 = 0.0f;		m.m22 = 1.0f;		m.m32 = 0.0f;		m.m42 = 0.0f;
	m.m13 = 0.0f;		m.m23 = 0.0f;		m.m33 = 1.0f;		m.m43 = 0.0f;
	m.m14 = 0.0f;		m.m24 = 0.0f;		m.m34 = 0.0f;		m.m44 = 1.0f;
*/	
	m = LKTransformMakeRotation( M_PI, 1, 0, 0);		// make rotation matrix
	[[self _layer] setTransform:m];
}

- (id)actionForLayer:(LKLayer *)layer forKey:(NSString *)key {
	if ([key isEqualToString:@"transform"]) {
		LKBasicAnimation *flipAnimation = [LKBasicAnimation animationWithKeyPath:key];
		[flipAnimation setTimingFunction:[LKTimingFunction functionWithName:@"easeInEaseOut"]];
		[flipAnimation setDuration:10.0]; // take yr time there, partner
		return flipAnimation;
	}
	else
		return [super actionForLayer:layer forKey:key];
}
@end
