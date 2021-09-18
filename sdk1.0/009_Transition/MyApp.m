
#import "MyApp.h"

#define TRANSITION_NOTHING			0	// エフェクトなし
#define TRANSITION_BOTH_TO_LEFT		1	// 次のビューと今のビューが左へ移動
#define TRANSITION_BOTH_TO_RIGHT	2	// 次のビューと今のビューが右へ移動
#define TRANSITION_BOTH_UP			3	// 次のビューと今のビューが上へ移動
#define TRANSITION_4				4	// エラー
#define TRANSITION_CURRENT_DOWN_NO	5	// 今のビューが下移動し，次のビューがエフェクトなし
#define TRANSITION_6				6	// エラー
#define TRANSITION_BOTH_DOWN		7	// 次のビューと今のビューが下へ移動
#define TRANSITION_NEXT_UP			8	// 今のviewは，そのままで，次のviewが下から上へ移動
#define TRANSITION_CURRENT_DOWN		9	// 今のviewは，そのままで，次のviewが上から下へ移動

#define DESCRIPTION_TRANSITION_NOTHING			@"No effect"
#define DESCRIPTION_TRANSITION_BOTH_TO_LEFT		@"Both views move to left"
#define DESCRIPTION_TRANSITION_BOTH_TO_RIGHT	@"Both views move to right"
#define DESCRIPTION_TRANSITION_BOTH_UP			@"Both views move up"
#define DESCRIPTION_TRANSITION_4				@"Error"
#define DESCRIPTION_TRANSITION_CURRENT_DOWN_NO	@"Current view moves down and no next's effect"
#define DESCRIPTION_TRANSITION_6				@"Error"
#define DESCRIPTION_TRANSITION_BOTH_DOWN		@"Both views move down"
#define DESCRIPTION_TRANSITION_NEXT_UP			@"Next view moves up"
#define DESCRIPTION_TRANSITION_CURRENT_DOWN		@"Current view moves down"

@implementation CategoryView
- (BOOL)table:(UITable *)aTable canSelectRow:(int)row {
	return YES;
}
- (int)numberOfRowsInTable:(UITable*)table {
	return [titleAry_ count];
}
- (UITableCell*)table:(UITable*)table cellForRow:(int)row column:(int)col {
	UIImageAndTextTableCell*	cell;
	cell = [[UIImageAndTextTableCell alloc] init];
	[cell setTitle:[titleAry_ objectAtIndex:row]];
	[cell setDisclosureStyle:2];
	[cell setShowDisclosure:YES];
	return cell; 
}
- (id)initWithFrame:(CGRect)frame withAppInstance:(id)appInstance{
	appInstance_ = appInstance;
	self = [super initWithFrame:frame];
	
	CGRect sizeTableView = CGRectMake(0, 48, 320, 480);
	CGRect sizeNavigationBar = CGRectMake(0, 0, 320, 48);
	
	// navigation bar
	UINavigationBar*bar = [[UINavigationBar alloc] initWithFrame:sizeNavigationBar];
	[bar showButtonsWithLeftTitle:nil rightTitle:nil leftBack:NO];
	[bar setBarStyle:5];
	[bar setDelegate:self];
	UINavigationItem *title = [[UINavigationItem alloc] initWithTitle: @"1"];
	[bar pushNavigationItem: title];
	[self addSubview:bar];
	
	titleAry_ = [[NSMutableArray array] retain];
	transAry_ = [[NSMutableArray array] retain];
	[titleAry_ addObject:DESCRIPTION_TRANSITION_NOTHING];
	[titleAry_ addObject:DESCRIPTION_TRANSITION_BOTH_TO_LEFT];
	[titleAry_ addObject:DESCRIPTION_TRANSITION_BOTH_TO_RIGHT];
	[titleAry_ addObject:DESCRIPTION_TRANSITION_BOTH_UP];
	[titleAry_ addObject:DESCRIPTION_TRANSITION_CURRENT_DOWN_NO];
	[titleAry_ addObject:DESCRIPTION_TRANSITION_BOTH_DOWN];
	[titleAry_ addObject:DESCRIPTION_TRANSITION_NEXT_UP];
	[titleAry_ addObject:DESCRIPTION_TRANSITION_CURRENT_DOWN];
	
	[transAry_ addObject:[NSNumber numberWithInt:TRANSITION_NOTHING]];
	[transAry_ addObject:[NSNumber numberWithInt:TRANSITION_BOTH_TO_LEFT]];
	[transAry_ addObject:[NSNumber numberWithInt:TRANSITION_BOTH_TO_RIGHT]];
	[transAry_ addObject:[NSNumber numberWithInt:TRANSITION_BOTH_UP]];
	[transAry_ addObject:[NSNumber numberWithInt:TRANSITION_CURRENT_DOWN_NO]];
	[transAry_ addObject:[NSNumber numberWithInt:TRANSITION_BOTH_DOWN]];
	[transAry_ addObject:[NSNumber numberWithInt:TRANSITION_NEXT_UP]];
	[transAry_ addObject:[NSNumber numberWithInt:TRANSITION_CURRENT_DOWN]];
	
	// create table
	UITableColumn*  tableColumn;
	tableColumn = [[UITableColumn alloc] initWithTitle:@"title"
			identifier:@"title" width:320];
	table_ = [[UITable alloc] initWithFrame:sizeTableView];
	[table_ addTableColumn:tableColumn];
	[table_ setDataSource:self];
	[table_ setDelegate:self];
	[table_ setSeparatorStyle:1];
	[table_ reloadData];
	[self addSubview:table_];
	return self;
}
- (void)tableRowSelected:(NSNotification*)notification {
	[appInstance_ showBoardViewWithTransition:
		[ [transAry_ objectAtIndex:[table_ selectedRow]] intValue]
	];
	return YES;
}
- (void)dealloc {
	[transAry_ release];
	[titleAry_ release];
	[super dealloc];
}
@end

@implementation BoardView
- (void)navigationBar:(UINavigationBar*)navbar buttonClicked:(int)button {
	[appInstance_ showCategoryViewWithTransition:2];
}
- (id)initWithFrame:(CGRect)frame withAppInstance:(id)appInstance{
	appInstance_ = appInstance;
	self = [super initWithFrame:frame];
	
	CGRect sizeTableView = CGRectMake(0, 48, 320, 480);
	CGRect sizeNavigationBar = CGRectMake(0, 0, 320, 48);
	
	//
	titleAry_ = [[NSMutableArray array] retain];
	transAry_ = [[NSMutableArray array] retain];
	[titleAry_ addObject:DESCRIPTION_TRANSITION_NOTHING];
	[titleAry_ addObject:DESCRIPTION_TRANSITION_BOTH_TO_LEFT];
	[titleAry_ addObject:DESCRIPTION_TRANSITION_BOTH_TO_RIGHT];
	[titleAry_ addObject:DESCRIPTION_TRANSITION_BOTH_UP];
	[titleAry_ addObject:DESCRIPTION_TRANSITION_CURRENT_DOWN_NO];
	[titleAry_ addObject:DESCRIPTION_TRANSITION_BOTH_DOWN];
	[titleAry_ addObject:DESCRIPTION_TRANSITION_NEXT_UP];
	[titleAry_ addObject:DESCRIPTION_TRANSITION_CURRENT_DOWN];
	
	[transAry_ addObject:[NSNumber numberWithInt:TRANSITION_NOTHING]];
	[transAry_ addObject:[NSNumber numberWithInt:TRANSITION_BOTH_TO_LEFT]];
	[transAry_ addObject:[NSNumber numberWithInt:TRANSITION_BOTH_TO_RIGHT]];
	[transAry_ addObject:[NSNumber numberWithInt:TRANSITION_BOTH_UP]];
	[transAry_ addObject:[NSNumber numberWithInt:TRANSITION_CURRENT_DOWN_NO]];
	[transAry_ addObject:[NSNumber numberWithInt:TRANSITION_BOTH_DOWN]];
	[transAry_ addObject:[NSNumber numberWithInt:TRANSITION_NEXT_UP]];
	[transAry_ addObject:[NSNumber numberWithInt:TRANSITION_CURRENT_DOWN]];
	
	// navigation bar
	UINavigationBar*bar = [[UINavigationBar alloc] initWithFrame:sizeNavigationBar];
	[bar showButtonsWithLeftTitle:@"Back" rightTitle:nil leftBack:YES];
	[bar setBarStyle:5];
	[bar setDelegate:self];
	UINavigationItem *title = [[UINavigationItem alloc] initWithTitle: @"2"];
	[bar pushNavigationItem: title];
	[self addSubview:bar];
	
	// create table
	UITableColumn*  tableColumn;
	tableColumn = [[UITableColumn alloc] initWithTitle:@"title"
			identifier:@"title" width:320];
	table_ = [[UITable alloc] initWithFrame:sizeTableView];
	[table_ addTableColumn:tableColumn];
	[table_ setDataSource:self];
	[table_ setDelegate:self];
	[table_ setSeparatorStyle:1];
	[table_ reloadData];
	[self addSubview:table_];
	return self;
}
- (BOOL)table:(UITable *)aTable canSelectRow:(int)row {
	return YES;
}
- (int)numberOfRowsInTable:(UITable*)table {
	return [titleAry_ count];
}
- (UITableCell*)table:(UITable*)table cellForRow:(int)row column:(int)col {
	UIImageAndTextTableCell*	cell;
	cell = [[UIImageAndTextTableCell alloc] init];
	[cell setTitle:[titleAry_ objectAtIndex:row]];
	[cell setDisclosureStyle:2];
	[cell setShowDisclosure:YES];
	return cell; 
}
- (void)tableRowSelected:(NSNotification*)notification {
	[appInstance_ showCategoryViewWithTransition:
		[ [transAry_ objectAtIndex:[table_ selectedRow]] intValue]
	];
	return YES;
}
- (void)dealloc {
	[transAry_ release];
	[titleAry_ release];
	[super dealloc];
}
@end

@implementation MyApp
- (void) writeLog:(NSString *)str {
	FILE *fp;
	fp = fopen( "/tmp/log_sonson.log", "aw" );
	fprintf( fp, "%s - ", [str UTF8String] );
	fclose( fp );
}
- (void) applicationDidFinishLaunching: (id) unused {
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	screenRect.origin.x = screenRect.origin.y = 0.0f;
	
	// Create window & view
	window_ = [[UIWindow alloc] initWithContentRect:screenRect];
	transitionView_ = [[UITransitionView alloc] initWithFrame:screenRect];
	mainView_ = [[UIView alloc] initWithFrame:screenRect];
	
	// Set content view
	[mainView_ addSubview:transitionView_];
	[window_ setContentView:mainView_];
	
	// Show window
	[window_ orderFront:self];
	[window_ makeKey:self];
	[window_ _setHidden:NO];
	
	[self showCategoryViewWithTransition:1];
}
- (void) showCategoryViewWithTransition:(int)trans {
	if (!categoryView_) {
		CGRect rect = [UIHardware fullScreenApplicationContentRect];
		rect.origin.x = rect.origin.y = 0.0f;
		categoryView_ = [[CategoryView alloc] initWithFrame:rect withAppInstance:self];
		[self writeLog:@"bb"];
	}
	[transitionView_ transition:trans toView:categoryView_];
}
- (void) showBoardViewWithTransition:(int)trans {
	if (!boardView_) {
		CGRect rect = [UIHardware fullScreenApplicationContentRect];
		rect.origin.x = rect.origin.y = 0.0f;
		boardView_ = [[BoardView alloc] initWithFrame:rect withAppInstance:self];
		[self writeLog:@"aa"];
	}
	[transitionView_ transition:trans toView:boardView_];
}
@end