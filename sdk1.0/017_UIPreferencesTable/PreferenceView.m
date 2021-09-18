
#import "PreferenceView.h"

@implementation PreferenceView

- (void) dealloc {
	[super dealloc];
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	CGRect sizeNavigationBar = CGRectMake(0, 0, 320, 48);
	CGRect view = CGRectMake(0, 48, 320, 432);
	// table
	table_ = [[UIPreferencesTable alloc] initWithFrame:view];
	[table_ setDataSource: self];
	[table_ setDelegate: self];
	[self addSubview:table_];
	//
	[self setupGroup];
	// Make navigation var
	UINavigationBar*bar = [[[UINavigationBar alloc] initWithFrame:sizeNavigationBar] autorelease];
	[bar showButtonsWithLeftTitle:nil rightTitle:nil leftBack:NO];
	[bar setBarStyle:5];
	[bar setDelegate:self];
	UINavigationItem *title = [[[UINavigationItem alloc] initWithTitle:[NSString stringWithUTF8String:"環境設定"]] autorelease];
	[bar pushNavigationItem: title];
	[self addSubview:bar];
	[table_ reloadData];
	return self;
}

- (BOOL) setupGroup {
	CGRect sliderRect = CGRectMake( 320 - 140.0f, 8.0f, 296.0f - 170.0f, 32.0f);//[_prefsTable rowHeight]);
	CGRect switchRect = CGRectMake( 320 - 114.0f, 9.0f, 296.0f - 200.0f, 32.0f);//[_prefsTable rowHeight]);
	// apperance title group
	// title
	titleCell_ = [[UIPreferencesTableCell alloc] init];
	//[titleCell_ setTitle:[NSString stringWithUTF8String:"フォントサイズ"]];
	// thread index size
	threadIndexCell_ = [[UIPreferencesTableCell alloc] init];
	[threadIndexCell_ setTitle:[NSString stringWithUTF8String:"スレッド一覧サイズ"]];
	UISliderControl* threadIndexSlider = [[[UISliderControl alloc] initWithFrame: sliderRect] autorelease];
	[threadIndexSlider setMinValue:10];
	[threadIndexSlider setMaxValue:120];
	[threadIndexSlider setShowValue:TRUE];
	[threadIndexCell_ addSubview:threadIndexSlider];
	// thread size
	threadCell_ = [[UIPreferencesTableCell alloc] init];
	[threadCell_ setTitle:[NSString stringWithUTF8String:"スレッドサイズ"]];
	UISliderControl* threadSlider = [[[UISliderControl alloc] initWithFrame: sliderRect] autorelease];
	[threadSlider setMinValue:10];
	[threadSlider setMaxValue:120];
	[threadSlider setShowValue:TRUE];
	[threadCell_ addSubview:threadSlider];
	
	// cache group
/*	
	UIPreferencesTableCell* titleCacheCell_;
	UIPreferencesTableCell* cacheDaysToDeleteCell_;
	UIPreferencesTableCell* offlineCell_;
	UIPreferencesTableCell* cacheResetCell_;
*/
	// title
	titleCacheCell_ = [[UIPreferencesTableCell alloc] init];
	//[titleCacheCell_ setTitle:[NSString stringWithUTF8String:"キャッシュ"]];
	// thread index size
	cacheDaysToDeleteCell_ = [[UIPreferencesTableCell alloc] init];
	[cacheDaysToDeleteCell_ setTitle:[NSString stringWithUTF8String:"キャッシュ保管日数"]];
	UISliderControl* deleteSlider = [[[UISliderControl alloc] initWithFrame: sliderRect] autorelease];
	[deleteSlider setMinValue:10];
	[deleteSlider setMaxValue:30];
	[deleteSlider setContinuous:NO];
	[deleteSlider setNumberOfTickMarks:1];
	[deleteSlider setShowValue:TRUE];
	[cacheDaysToDeleteCell_ addSubview:deleteSlider];
	// thread size
	offlineCell_ = [[UIPreferencesTableCell alloc] init];
	[offlineCell_ setTitle:[NSString stringWithUTF8String:"オフラインモード"]];
	UISwitchControl* offlineSwitch = [[[UISwitchControl alloc] initWithFrame: switchRect] autorelease];
	[offlineCell_ addSubview:offlineSwitch];
	
	cacheDeleteCell_ = [[UIPreferencesTableCell alloc] init];
	[cacheDeleteCell_ setTitle:[NSString stringWithUTF8String:"キャッシュをすべて削除"]];
	
	versionInfoCell_ = [[UIPreferencesTableCell alloc] init];
	[versionInfoCell_ setTitle:@"2tch version 1.0.0 build20071124"];
}

// delegate

- (int)numberOfGroupsInPreferencesTable:(UIPreferencesTable*)aTable {
	return 6;
}

- (int)preferencesTable:(UIPreferencesTable*)aTable numberOfRowsInGroup:(int)group {
	switch( group ) {
		case 0:
			return 0;
		case 1:
			return 2;
		case 2:
			return 0;
		case 3:
			return 2;
		case 4:
			return 1;
		case 5:
			return 0;
	}
}

- (UIPreferencesTableCell*)preferencesTable:(UIPreferencesTable*)aTable cellForGroup:(int)group {
	switch(group) {
		case 0:
			return titleCell_;
		case 1:
			return titleCell_;
		case 2:
			return titleCacheCell_;
		case 3:
			return titleCacheCell_;
		case 4:
			return titleCacheCell_;
		case 5:
			return versionInfoCell_;
	}
}

- (float)preferencesTable:(UIPreferencesTable*)aTable heightForRow:(int)row inGroup:(int)group withProposedHeight:(float)proposed {
	switch( group ) {
		case 0:
			return 5.0f;
		case 2:
			return 5.0f;
		case 5:
			return 40.0f;
		default:
			return proposed;
	}
}

- (BOOL)preferencesTable:(UIPreferencesTable*)aTable isLabelGroup:(int)group {
	switch(group) {
		case 0:
			return YES;
		case 1:
			return NO;
		case 2:
			return YES;
		case 3:
			return NO;
		case 4:
			return NO;
		case 5:
			return YES;
	}
	return 0;
}

- (void)tableRowSelected:(NSNotification*)notification {
	id cell = [table_ cellAtRow:[table_ selectedRow] column:0];
	if( cacheDeleteCell_ != cell )
		[cell setSelected:NO];
	else {
	[cacheDeleteCell_ setSelected:YES];
			// make alert sheet
			UIAlertSheet *alert = [[[UIAlertSheet alloc] initWithFrame:CGRectMake(0, 240, 320, 240)] autorelease];
			[alert setTitle:@"2tch"];
			[alert setBodyText:[NSString stringWithUTF8String:"キャッシュをすべて削除しますか？"]];
			[alert addButtonWithTitle:@"OK" ];
			[alert addButtonWithTitle:@"Cancel" ];
			[alert setRunsModal:NO];
			[alert setAlertSheetStyle:0];
			[ alert setDelegate: self ];
			[alert presentSheetInView: self ];
	}
}

- (void)alertSheet:(UIAlertSheet*)sheet buttonClicked:(int)button {
	[sheet dismiss];
	[cacheDeleteCell_ setSelected:NO];
}

- (UIPreferencesTableCell*)preferencesTable:(UIPreferencesTable*)aTable cellForRow:(int)row inGroup:(int)group {
	switch( group ) {
		case 0:
			return titleCell_;
		case 1:
			switch( row ) {
				case 0:
					return threadIndexCell_;
				case 1:
					return threadCell_;
			}
		case 2:
			return titleCacheCell_;
		case 3:
			switch( row ) {
				case 0:
					return cacheDaysToDeleteCell_;
				case 1:
					return offlineCell_;
			}
		case 4:
			return cacheDeleteCell_;
		case 5:
			return versionInfoCell_;
	}
}

@end
