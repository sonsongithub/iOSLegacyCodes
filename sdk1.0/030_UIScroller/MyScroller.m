
#import "MyScroller.h"
#import "global.h"

@implementation MyScroller

- (void)scrollerDidEndSmoothScrolling:(UIScroller*)scroller {
	NSLog( @"scrollerDidEndSmoothScrolling - now (%f,%f)", [self offset].x, [self offset].y );
}

- (void)scrollerWillStartSmoothScrolling:(UIScroller*)scroller {
	NSLog( @"scrollerWillStartSmoothScrolling - now (%f,%f)", [self offset].x, [self offset].y );
	float x = [self offset].x + _velocity.width / ( 1 - _scrollDecelerationFactor );
	float y = [self offset].y + _velocity.height / ( 1 - _scrollDecelerationFactor );
	NSLog( @"predict stop position - now (%f,%f)", x, y );
}

@end
