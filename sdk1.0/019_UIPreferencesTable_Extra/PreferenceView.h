
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIPreferencesTable.h>
#import <UIKit/UIPreferencesTableCell.h>
#import <UIKit/UIPreferencesTextTableCell.h>
#import <UIKit/UISwitchControl.h>
#import <GraphicsServices/GraphicsServices.h>

@interface PreferenceView : UIView {
	id						currentTable_;
	UINavigationBar			*bar_;
	UINavigationItem		*barTitle_;
	UITransitionView*		transitionView_;
	UIPreferencesTable*		table_;
	
	UIPreferencesTableCell* titleCell_;
	
	UIPreferencesTableCell* threadIndexCell_;
	UITextLabel*			threadIndex_label_;
	
	UIPreferencesTableCell* threadCell_;
	UITextLabel*			thread_label_;
	
	UIPreferencesTableCell* cacheDaysToDeleteCell_;
	UITextLabel*			daysToDelete_label_;
	
	UIPreferencesTableCell* offlineCell_;
	UISwitchControl* offlineSwitch_;
	
	UIPreferencesTableCell* cacheDeleteCell_;
	UIPreferencesTableCell* versionInfoCell_;
	
}
// over ride
- (void) dealloc;
- (id) initWithFrame:(CGRect)frame;

// original
//- (NSDictionary*) makeDefaultDictionary;
- (BOOL) savePlist;
- (BOOL) setDataToControl:(NSDictionary*)dict;
//- (BOOL) readPlist;
- (BOOL) setupGroup;
- (void) adjustTextLabel:(UITextLabel*)fp;
- (BOOL) changeNaviBar:(int)mode;

// UINavigationbar's delegate method
- (void)navigationBar:(UINavigationBar*)navbar buttonClicked:(int)button;

// delegate
- (int) numberOfGroupsInPreferencesTable:(UIPreferencesTable*)aTable;
- (int) preferencesTable:(UIPreferencesTable*)aTable numberOfRowsInGroup:(int)group;
- (float) preferencesTable:(UIPreferencesTable*)aTable heightForRow:(int)row inGroup:(int)group withProposedHeight:(float)proposed;
- (BOOL) preferencesTable:(UIPreferencesTable*)aTable isLabelGroup:(int)group;
- (UIPreferencesTableCell*) preferencesTable:(UIPreferencesTable*)aTable cellForGroup:(int)group;
- (UIPreferencesTableCell*) preferencesTable:(UIPreferencesTable*)aTable cellForRow:(int)row inGroup:(int)group;
- (void) tableRowSelected:(NSNotification*)notification;
- (void) alertSheet:(UIAlertSheet*)sheet buttonClicked:(int)button;
@end
