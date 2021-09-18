
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import "PreferenceView.h"

#define		UIApp						(MyApp*)UIApp					// 

@interface MyApp : UIApplication {
	PreferenceView*		preferenceView_;
	float				threadIndexSize_;
	float				threadSize_;
	int					daysToMaintain_;
	BOOL				offlineMode_;
}
- (void) readPreferenceData;
- (NSDictionary*) readPlist;
- (NSDictionary*) makeDefaultDictionary;
- (float) threadIndexSize;
- (float) threadSize;
- (int) daysToMaintain;
- (BOOL) isOfflineMode;
@end
