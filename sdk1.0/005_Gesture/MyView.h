#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>

@interface MyView : UIView {
	UITextView* text_;
	UIImageView* imgView1_;
	UIImageView* imgView2_;
	int x_;
	int y_;
	int startCount_;
	int flag_;
	UIImage *img1;
	UIImage *img2;
}
@end
