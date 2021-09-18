#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import <GraphicsServices/GraphicsServices.h>

@interface CategoryView : UIView {
	id					appInstance_;
	UITable*			table_;
	NSMutableArray		*titleAry_;
	NSMutableArray		*transAry_;
}
@end

@interface BoardView : UIView {
	id					appInstance_;
	UITable*			table_;
	NSMutableArray		*titleAry_;
	NSMutableArray		*transAry_;
}
@end

@interface MyApp : UIApplication {
	UIWindow			*window_;
	UIView				*mainView_;
	UITransitionView	*transitionView_;
	
	//
	CategoryView		*categoryView_;
	BoardView			*boardView_;
}
@end
