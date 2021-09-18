
#import "MyApp.h"
#import "SwipeCell.h"

@implementation MyApp

- (void) applicationDidFinishLaunching: (id) unused {
	// Get screen rect
	CGRect screenRect = [UIHardware fullScreenApplicationContentRect];
	
	// Create window_
	window_ = [[UIWindow alloc] initWithContentRect:screenRect];
	//
	[self makeCells];
	[self setupTable];
	[self setupButtonBar];
	
	// Show window_
	[window_ orderFront:self];
	[window_ makeKey:self];
	[window_ _setHidden:NO];
}

- (void) setupTable {
	// create table
	CGRect screenRect = [UIHardware fullScreenApplicationContentRect];
	screenRect.origin.y = 0;
	UITableColumn*  tableColumn = [[[UITableColumn alloc] initWithTitle:@"title" identifier:@"title" width:screenRect.size.width] autorelease];
	table_ = [[[SwipeTable alloc] initWithFrame:screenRect] autorelease];
	[table_ addTableColumn:tableColumn];
	[table_ setDataSource:self];
	[table_ setDelegate:self];
	[table_ setRowHeight:50];
	[table_ setSeparatorStyle:1];
	[table_ enableRowDeletion: YES animated: YES];
	[table_ setAllowsReordering:YES];
	[table_ reloadData];
	// Set content view
	[window_ setContentView:table_];
}

- (void) setupButtonBar {
	// Create button bar
	CGRect screenRect = [UIHardware fullScreenApplicationContentRect];
	screenRect.origin.y = 0;
    CGRect frame = CGRectMake( 0, screenRect.size.height - [UIButtonBar defaultHeight], screenRect.size.width, [UIButtonBar defaultHeight] );
    UIButtonBar *buttonBar = [[[UIButtonBar alloc] initWithFrame:frame] autorelease];
	[buttonBar setBarStyle:2];
	
	UIPushButton* pushButton = [[[UIPushButton alloc] initWithTitle:@"Add" autosizesToFit:YES] autorelease];
	[pushButton setFrame: CGRectMake(60.0, 0.0, 200.0, 40.0)];
	[pushButton setDrawsShadow: YES];
	[pushButton setEnabled:YES];  //may not be needed
	[pushButton setStretchBackground:YES];
	[buttonBar addSubview:pushButton];
	[pushButton addTarget:self action:@selector(pushAdd) forEvents:(1<<6)];
	
	[window_ addSubview:buttonBar];
}

- (void) pushAdd {
	int row = [ary_ count];
	
	SwipeCell *cell = [[[SwipeCell alloc] initWithDelegate:self] autorelease];
	[cell setTitle:[NSString stringWithFormat:@"cell %d",row]];
	
	int selected = [table_ selectedRow];
	if( selected < 0 || selected >= row)
		selected = 0;
	
	[ary_ insertObject:cell atIndex:selected];
	[table_ reloadDataForInsertionOfRows:NSMakeRange(selected, 1) animated:YES];
	
	[table_ _userSelectRow:0];
	[[table_ cellAtRow:[table_ selectedRow] column:0] setSelected:NO];
}


- (void) makeCells {
	ary_ = [[NSMutableArray array] retain];
	int i;
	for( i = 0; i < 3; i++ ) {
		SwipeCell *cell = [[[SwipeCell alloc] initWithDelegate:self] autorelease];
		[cell setTitle:[NSString stringWithFormat:@"cell %d",i]];
		[ary_ addObject:cell];
	}
}

- (void) delete:(id)cell {
	[ary_ removeObjectAtIndex:[ table_ _rowForTableCell:cell]];
}

- (BOOL)table:(UITable *)aTable canSelectRow:(int)row {
	return YES;
}

- (int)numberOfRowsInTable:(UITable*)table {
	return [ary_ count];
}

- (UITableCell*)table:(UITable*)table cellForRow:(int)row column:(int)col {
	return [ary_ objectAtIndex:row];
}

- (void)tableRowSelected:(NSNotification*)notification {

}

// this is called when table is load
- (BOOL)table:(UITable*)table canDeleteRow:( int)row {
	NSLog(@"canDeleteRow: %d",row);
	return NO;
}


- (BOOL)table:(UITable*)table canInsertAtRow:(int)row{
	NSLog(@"canInsertAtRow %i", row);
	return YES;
}

- (BOOL)table:(UITable*)table canMoveRow:(int)row{
	NSLog(@"canMoveRow %i", row);
	return YES;
}

-(int)table:(UITable*)table moveDestinationForRow:(int)row withSuggestedDestination:(int)dest{
	NSLog(@"moveDestinationForRow %i, %i", row, dest);
	return dest;
}

@end