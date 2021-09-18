
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>

@interface TransitionView : UITransitionView {
	id view1_;
	id view2_;
	
	id now_view_;
	
	int orientation_;
}

@end
