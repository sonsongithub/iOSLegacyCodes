
#import "PreferenceView.h"
#import "MenuPreferenceTable.h"
#import "MyApp.h"

@implementation PreferenceView

- (void) dealloc {
	[titleCell_ release];
	[threadIndexCell_ release];
	[threadCell_ release];
	[cacheDaysToDeleteCell_ release];
	[offlineCell_ release];
	[cacheDeleteCell_ release];
	[versionInfoCell_ release];
	[table_ release];
	[super dealloc];
}

- (BOOL) savePlist {
	NSString *offlineMode;
	long x = [ offlineSwitch_ value ];
	if( x )
		offlineMode = @"true";
	else
		offlineMode = @"false";
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
			[threadIndex_label_ text],		@"threadIndexSize",
			[thread_label_ text],			@"threadSize",
			[daysToDelete_label_ text],		@"daysToMaintain",
			offlineMode,					@"offlineMode",
			nil];
	NSString *str = [dict description];
	return [str writeToFile:@"/private/var/root/Library/Preferences/com.sonson.2tch/preference.plist" atomically:NO encoding:NSUTF8StringEncoding error:nil];
}

- (BOOL) setDataToControl:(NSDictionary*)dict {
	//
	[thread_label_ setText:[dict objectForKey:@"threadSize"]];
	[threadIndex_label_ setText:[dict objectForKey:@"threadIndexSize"]];
	[daysToDelete_label_ setText:[dict objectForKey:@"daysToMaintain"]];
	
	//
	[self adjustTextLabel:threadIndex_label_];
	[self adjustTextLabel:thread_label_];
	[self adjustTextLabel:daysToDelete_label_];
	
	//
	NSString* offlineMode =[dict objectForKey:@"offlineMode"];
	if( [offlineMode isEqualToString:@"true"] )
		[offlineSwitch_ setValue:1];
	else
		[offlineSwitch_ setValue:0];
}


- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	CGRect sizeNavigationBar = CGRectMake(0, 0, 320, 48);
	CGRect view = CGRectMake(0, 48, 320, 432);
	CGRect tableRect = CGRectMake(0, 0, 320, 432);
	// table

	table_ = [[UIPreferencesTable alloc] initWithFrame:tableRect];
	[table_ setDataSource: self];
	[table_ setDelegate: self];
	
	//
	currentTable_ = nil;
	transitionView_ = [[[UITransitionView alloc] initWithFrame:view] autorelease];
	[self addSubview:transitionView_];
	[transitionView_ setDelegate:self];
	[transitionView_ transition:1 fromView:currentTable_ toView:table_ ];
	
	//
	[self setupGroup];
	NSDictionary *dict = [UIApp readPlist];
	[self setDataToControl:dict];
	
	// Make navigation var
	bar_ = [[[UINavigationBar alloc] initWithFrame:sizeNavigationBar] autorelease];
	[bar_ showButtonsWithLeftTitle:nil rightTitle:nil leftBack:NO];
	[bar_ setBarStyle:5];
	[bar_ setDelegate:self];
	[bar_ enableAnimation];
	barTitle_ = [[[UINavigationItem alloc] initWithTitle:[NSString stringWithUTF8String:"環境設定"]] autorelease];
	[bar_ pushNavigationItem: barTitle_];
	[self addSubview:bar_];
	[table_ reloadData];
	return self;
}


- (void)transitionViewDidComplete:(UITransitionView*)view fromView:(UIView*)from toView:(UIView*)to {
	currentTable_ = to;
}

- (BOOL) setupGroup {
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	float blue[4] = {0.15, 0.24, 0.41, 1.0};
	
	CGRect switchRect = CGRectMake( 320 - 114.0f, 9.0f, 296.0f - 200.0f, 32.0f);

	GSFontRef bodyFont = GSFontCreateWithName("applegothic", 1, 19.0f);
	
	// title
	titleCell_ = [[UIPreferencesTableCell alloc] init];
	
	// thread index size
	threadIndexCell_ = [[UIPreferencesTableCell alloc] init];
	[threadIndexCell_ setTitle:[NSString stringWithUTF8String:"スレッド一覧フォント"]];
	[threadIndexCell_ setDisclosureStyle:2];
	[threadIndexCell_ setShowDisclosure:YES];
	threadIndex_label_ = [[[UITextLabel alloc] initWithFrame:CGRectMake( 320 - 50, 11, 20, 13)] autorelease];
	[threadIndex_label_ setText:@"10"];
	[threadIndexCell_ addSubview:threadIndex_label_];
	[threadIndexCell_ sizeToFit];
	[threadIndex_label_ setColor:CGColorCreate( colorSpace, blue)];
	[threadIndex_label_ setFont:bodyFont];
	
	// thread size
	threadCell_ = [[UIPreferencesTableCell alloc] init];
	[threadCell_ setTitle:[NSString stringWithUTF8String:"スレッドフォント"]];
	[threadCell_ setDisclosureStyle:2];
	[threadCell_ setShowDisclosure:YES];
	thread_label_ = [[[UITextLabel alloc] initWithFrame:CGRectMake( 320 - 50, 11, 20, 13)] autorelease];
	[thread_label_ setText:@"10"];
	[threadCell_ addSubview:thread_label_];
	[threadCell_ sizeToFit];
	[thread_label_ setColor:CGColorCreate( colorSpace, blue)];
	[thread_label_ setFont:bodyFont];

	// title
	cacheDaysToDeleteCell_ = [[UIPreferencesTableCell alloc] init];
	[cacheDaysToDeleteCell_ setTitle:[NSString stringWithUTF8String:"キャッシュ保管日数"]];
	[cacheDaysToDeleteCell_ setDisclosureStyle:2];
	[cacheDaysToDeleteCell_ setShowDisclosure:YES];
	daysToDelete_label_ = [[[UITextLabel alloc] initWithFrame:CGRectMake( 320 - 50, 11, 20, 13)] autorelease];
	[daysToDelete_label_ setText:@"10"];
	[cacheDaysToDeleteCell_ addSubview:daysToDelete_label_];
	[cacheDaysToDeleteCell_ sizeToFit];
	[daysToDelete_label_ setColor:CGColorCreate( colorSpace, blue)];
	[daysToDelete_label_ setFont:bodyFont];
	
	// thread size
	offlineCell_ = [[UIPreferencesTableCell alloc] init];
	[offlineCell_ setTitle:[NSString stringWithUTF8String:"オフラインモード"]];
	offlineSwitch_ = [[[UISwitchControl alloc] initWithFrame: switchRect] autorelease];
	[offlineCell_ addSubview:offlineSwitch_];
	
	cacheDeleteCell_ = [[UIPreferencesTableCell alloc] init];
	[cacheDeleteCell_ setTitle:[NSString stringWithUTF8String:"キャッシュをすべて削除"]];
	
	versionInfoCell_ = [[UIPreferencesTableCell alloc] init];
	[versionInfoCell_ setTitle:@"2tch version 1.0.0 build20071124"];
}

- (void) adjustTextLabel:(UITextLabel*)fp {
	[fp sizeToFit];
	CGRect rect = [fp frame];
	// 285 right edget
	float margin = rect.origin.x + rect.size.width - 285 - 5;
	rect.origin.x -= margin;
	[fp setFrame:rect];
}

- (BOOL) changeNaviBar:(int)mode {
	[self adjustTextLabel:threadIndex_label_];
	[self adjustTextLabel:thread_label_];
	[self adjustTextLabel:daysToDelete_label_];
	
	switch( mode ) {
		case 0:
			[barTitle_ setTitle:[NSString stringWithUTF8String:"スレッド一覧フォント"]];
			[bar_ showButtonsWithLeftTitle:[NSString stringWithUTF8String:"設定"] rightTitle:nil leftBack: YES];
			break;
		case 1:
			[barTitle_ setTitle:[NSString stringWithUTF8String:"スレッドフォント"]];
			[bar_ showButtonsWithLeftTitle:[NSString stringWithUTF8String:"設定"] rightTitle:nil leftBack: YES];
			break;
		case 2:
			[barTitle_ setTitle:[NSString stringWithUTF8String:"キャッシュ保管日数"]];
			[bar_ showButtonsWithLeftTitle:[NSString stringWithUTF8String:"設定"] rightTitle:nil leftBack: YES];
			break;
		case 3:
			[barTitle_ setTitle:[NSString stringWithUTF8String:"設定"]];
			[bar_ showButtonsWithLeftTitle:[NSString stringWithUTF8String:"2tch"] rightTitle:nil leftBack: YES];
			break;
	}
}


// UINavigationbar's delegate method

- (void)navigationBar:(UINavigationBar*)navbar buttonClicked:(int)button {
	switch (button) {
		case 0: // right
			break;
		case 1:	// left
			if( currentTable_ == table_ ) {
				[self savePlist];
				[UIApp readPreferenceData];
			}
			else {
				[transitionView_ transition:2 toView:table_];
				[self changeNaviBar:3];
			}
			break;
	}
}

// delegate

- (int)numberOfGroupsInPreferencesTable:(UIPreferencesTable*)aTable {
	return 4;
}

- (int)preferencesTable:(UIPreferencesTable*)aTable numberOfRowsInGroup:(int)group {
	switch( group ) {
		case 0:
			return 0;
		case 1:
			return 4;
		case 2:
			return 1;
		case 3:
			return 1;
	}
}

- (UIPreferencesTableCell*)preferencesTable:(UIPreferencesTable*)aTable cellForGroup:(int)group {
	switch(group) {
		case 0:
			return titleCell_;
		case 1:
			return titleCell_;
		case 2:
			return titleCell_;
		case 3:
			return versionInfoCell_;
	}
}

- (float)preferencesTable:(UIPreferencesTable*)aTable heightForRow:(int)row inGroup:(int)group withProposedHeight:(float)proposed {
	switch( group ) {
		case 0:
			return 5.0f;
		case 3:
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
			return NO;
		case 3:
			return YES;
	}
	return 0;
}

- (void)tableRowSelected:(NSNotification*)notification {
	CGRect tableRect = CGRectMake(0, 0, 320, 432);
	id cell = [table_ cellAtRow:[table_ selectedRow] column:0];
	if( cacheDeleteCell_ != cell ) {
		if( cell == threadIndexCell_ ) {
			NSArray *ary = [NSArray arrayWithObjects:
							[NSString stringWithUTF8String:"Small"],
							[NSString stringWithUTF8String:"Medium"],
							[NSString stringWithUTF8String:"Large"],
							[NSString stringWithUTF8String:"Extra Large"],
							[NSString stringWithUTF8String:"Giant"],
							nil ];
			MenuPreferenceTable* table = [[MenuPreferenceTable alloc] initWithFrame:tableRect withTitles:ary withDelegate:threadIndex_label_];
			[transitionView_ transition:1 toView:table];
			[self changeNaviBar:0];
		}
		else if( cell == threadCell_ ) {
			NSArray *ary = [NSArray arrayWithObjects:
							[NSString stringWithUTF8String:"Small"],
							[NSString stringWithUTF8String:"Medium"],
							[NSString stringWithUTF8String:"Large"],
							[NSString stringWithUTF8String:"Extra Large"],
							[NSString stringWithUTF8String:"Giant"],
							nil ];
			MenuPreferenceTable* table = [[MenuPreferenceTable alloc] initWithFrame:tableRect withTitles:ary withDelegate:thread_label_];
			[transitionView_ transition:1 toView:table];
			[self changeNaviBar:1];
		}
		else if( cell == cacheDaysToDeleteCell_ ) {
			NSArray *ary = [NSArray arrayWithObjects:
							[NSString stringWithUTF8String:"5"],
							[NSString stringWithUTF8String:"10"],
							[NSString stringWithUTF8String:"15"],
							[NSString stringWithUTF8String:"20"],
							[NSString stringWithUTF8String:"25"],
							nil ];
			MenuPreferenceTable* table = [[MenuPreferenceTable alloc] initWithFrame:tableRect withTitles:ary withDelegate:daysToDelete_label_];
			[transitionView_ transition:1 toView:table];
			[self changeNaviBar:2];
		}
		[cell setSelected:NO];
	}
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
		[alert setDelegate: self ];
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
				case 2:
					return cacheDaysToDeleteCell_;
				case 3:
					return offlineCell_;
			}
		case 2:
			return cacheDeleteCell_;
		case 3:
			return versionInfoCell_;
	}
}

@end
