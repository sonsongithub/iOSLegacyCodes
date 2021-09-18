#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>


#define		UIAppOrientScreenUp		0
#define		UIAppOrientNormal		1
#define		UIAppOrientUpsideDown	2
#define		UIAppOrientLeft			3
#define		UIAppOrientRight		4
#define		UIAppOrientUnknown		5
#define		UIAppOrientProne		6

@interface MyApp : UIApplication {
	id		window_;
	id		view;
}
@end
