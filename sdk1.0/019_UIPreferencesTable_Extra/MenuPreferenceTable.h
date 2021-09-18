
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIPreferencesTable.h>
#import <UIKit/UIPreferencesTableCell.h>
#import <UIKit/UIPreferencesTextTableCell.h>
#import <UIKit/UISwitchControl.h>
#import <GraphicsServices/GraphicsServices.h>


@interface MenuPreferenceTable : UIPreferencesTable {
	int						items_;			// count of items
	id						delegate_;		// delegate to the text label
	NSMutableArray*			ary_;
	UIPreferencesTableCell* titleCell_;
}

// over ride
- (void) dealloc;
- (id) initWithFrame:(CGRect)frame withTitles:(NSArray*)titles withDelegate:(id)fp;

// original
- (void) setDataDelegate:(id)fp;

// delegate method
- (int) numberOfGroupsInPreferencesTable:(UIPreferencesTable*)aTable;
- (int) preferencesTable:(UIPreferencesTable*)aTable numberOfRowsInGroup:(int)group;
- (float) preferencesTable:(UIPreferencesTable*)aTable heightForRow:(int)row inGroup:(int)group withProposedHeight:(float)proposed;
- (BOOL) preferencesTable:(UIPreferencesTable*)aTable isLabelGroup:(int)group;
- (UIPreferencesTableCell*) preferencesTable:(UIPreferencesTable*)aTable cellForGroup:(int)group;
- (UIPreferencesTableCell*) preferencesTable:(UIPreferencesTable*)aTable cellForRow:(int)row inGroup:(int)group;
- (void) tableRowSelected:(NSNotification*)notification;
- (void) alertSheet:(UIAlertSheet*)sheet buttonClicked:(int)button;

@end
