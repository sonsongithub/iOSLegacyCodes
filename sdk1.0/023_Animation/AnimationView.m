
#import "AnimationView.h"

@implementation AnimationView

- (id) initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	CGRect sizeTableView = CGRectMake(0, 0, 320, 460);
	// create table
	UITableColumn*  tableColumn;
	tableColumn = [[[UITableColumn alloc] initWithTitle:@"title" identifier:@"title" width:320] autorelease];
	table_ = [[UITable alloc] initWithFrame:sizeTableView];
	[table_ addTableColumn:tableColumn];
	[table_ setDataSource:self];
	[table_ setDelegate:self];
	[table_ setSeparatorStyle:1];
	[self addSubview:table_];
	
	animationNames_ = [[NSArray arrayWithObjects:
				@"pageCurl",
				@"pageUnCurl",
				@"suckEffect",
				@"spewEffect",
				@"genieEffect",
				@"unGenieEffect",
				@"twist",
				@"tubey",
				@"swirl",
				@"rippleEffect",
				@"cameraIris",
				@"cameraIrisHollow",
				@"cameraIrisHollowOpen",
				@"cameraIrisHollowClose",
				@"charminUltra",
				@"reflection",
				@"zoomyIn",
				@"zoomyOut",
				@"oglApplicationSuspend",
				@"oglFlip",
				nil] retain];
	[table_ reloadData];
	
	return self;
}

// UITable's delegate method

/*
- (float) table:(UITable *)table heightForRow:(int)row {
	return 0;
}
*/

- (BOOL)table:(UITable *)aTable canSelectRow:(int)row {
	return YES;
}

- (int)numberOfRowsInTable:(UITable*)table {
	return [animationNames_ count];
}

- (UITableCell*)table:(UITable*)table cellForRow:(int)row column:(int)col {
	id cell = [[[UIImageAndTextTableCell alloc] init] autorelease];
	[cell setTitle:[animationNames_ objectAtIndex:row]];
	return cell;
}

- (void)tableRowSelected:(NSNotification*)notification {
	NSLog( [animationNames_ objectAtIndex:[table_ selectedRow]] );
	[self doAnimation:[animationNames_ objectAtIndex:[table_ selectedRow]]];
}

- (void) doAnimation:(NSString*)animationName {
	id myAnim = [LKTransition animation];
	[myAnim setType:animationName];
	[myAnim setSubtype:@"fromTop"];
	[myAnim setDelegate:self];
	[myAnim setTimingFunction:[LKTimingFunction functionWithName:@"easeOut"]];
	[myAnim setFillMode:@"backward"];
	[myAnim setTransitionFlags:3];
	[myAnim setDuration:2.0];
	[myAnim setSpeed:0.5];
	[[self _layer] addAnimation: myAnim forKey: 0];
}

@end
