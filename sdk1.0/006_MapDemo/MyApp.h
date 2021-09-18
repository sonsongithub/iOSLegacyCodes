#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import <GraphicsServices/GraphicsServices.h>
#import "MyView.h"

@interface MyApp : UIApplication {
	UIWindow*   window_;
	MyControllerView* myView_;
	UIImageView* imgView_;
	UIImageView*	mapView_;
}
@end
