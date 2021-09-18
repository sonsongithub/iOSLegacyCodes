
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIPreferencesTable.h>
#import <UIKit/UIPreferencesTableCell.h>
#import <UIKit/UIPreferencesTextTableCell.h>

#import <UIKit/UISwitchControl.h>

@interface PreferenceView : UIView {
	UIPreferencesTable*		table_;
	// title
	UIPreferencesTableCell* titleCell_;
	UIPreferencesTableCell* threadIndexCell_;
	UIPreferencesTableCell* threadCell_;
	
	UIPreferencesTableCell* titleCacheCell_;
	UIPreferencesTableCell* cacheDaysToDeleteCell_;
	UIPreferencesTableCell* offlineCell_;
	UIPreferencesTableCell* cacheResetCell_;
	UIPreferencesTableCell* cacheDeleteCell_;
	UIPreferencesTableCell* versionInfoCell_;
}

@end
