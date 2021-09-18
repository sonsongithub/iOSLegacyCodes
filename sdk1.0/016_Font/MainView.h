#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>

@interface MainView : UIView {
	UITable*		fontTable_;
	UITable*		traitTable_;
	UITable*		sizeTable_;
	
	NSMutableArray*	fontArray_;
	NSMutableArray*	traitArray_;
	NSMutableArray*	sizeArray_;
	
	UITextLabel*	label_;
}

@end
