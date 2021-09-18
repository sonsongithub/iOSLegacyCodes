
#import "MyApp.h"

@implementation MyApp
- (void) applicationDidFinishLaunching: (id) unused {
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	
	// Create window
	UIWindow*   window;
	window = [[UIWindow alloc] initWithContentRect:screenRect];
	screenRect.origin.x = 0;
	screenRect.origin.y = 0;
	
	// create table
	UITableColumn*  tableColumn;
	tableColumn = [[UITableColumn alloc] initWithTitle:@"title"
			identifier:@"title" width:320];
	table_ = [[UITable alloc] initWithFrame:screenRect];
	[table_ addTableColumn:tableColumn];
	[table_ setDataSource:self];
	[table_ setDelegate:self];
	[table_ setSeparatorStyle:1];
	[table_ setRowHeight:60.0f];
	[table_ reloadData];
	//[self addSubview:table_];
	
	// Set content view
	[window setContentView:table_];
	
	// Show window
	[window orderFront:self];
	[window makeKey:self];
	[window _setHidden:NO];
}
- (BOOL)table:(UITable *)aTable canSelectRow:(int)row {
	return YES;
}
- (int)numberOfRowsInTable:(UITable*)table {
	return 30;
}
- (UITableCell*)table:(UITable*)table cellForRow:(int)row column:(int)col {
	UITableCell *cell = [[UIImageAndTextTableCell alloc] init];
	NSString *str1 = [NSString stringWithUTF8String:"【初音ミク騒動】 “真相は” 「なぜかＮＧワードに初音ミクが入った」可能性？…ヤフーとＧoogleは「意図的削除はしてない」と発表★３ "];

//	NSString *str2 = [NSString stringWithUTF8String:"sfdsfasdfafdasfasfadsfadsfadafa\nasfadsfadsfadfasdffdasfasdfadsfafsafスレ一覧"];

	GSFontRef titleFont;
	titleFont = GSFontCreateWithName("Helvetica", kGSFontTraitBold, 12.0f);
	id *label1 = [[UITextLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 59)];
	[label1 setFont:titleFont];
	[label1 setWrapsText:YES];
	CFRelease(titleFont);
/*
	titleFont = GSFontCreateWithName("Helvetica", kGSFontTraitBold, 10.0f);
	id *label2 = [[UITextLabel alloc] initWithFrame:CGRectMake(0, 20, 320, 40)];
	[label2 setFont:titleFont];
	[label2 setWrapsText:FALSE];
	CFRelease(titleFont);
*/
/*
	UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, 320, 40)];
	[textView setText:str1];
	[textView setTextSize:10.0f];
	[textView setDelegate:cell];
	[textView setDelegate:cell];
	[textView setEditable:NO];
*/
	[label1 setText:str1];
//	[label2 setText:str2];
	
//	float redComponents[4] = {1, 0, 0, 1};
//	float greenComponents[4] = {0, 1, 0, 1};
	float transparentomponents[4] = {1, 1, 1, 0};
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	[label1 setBackgroundColor: CGColorCreate( colorSpace, transparentomponents)];
//	[label2 setBackgroundColor: CGColorCreate( colorSpace, greenComponents)];
	
//	[textView setBackgroundColor: CGColorCreate( colorSpace, transparentomponents)];
	
	[cell addSubview:label1];
	//[cell addSubview:textView];
	//[cell addSubview:label2];
	[cell setDisclosureStyle:2];
	[cell setShowDisclosure:YES];

#ifdef _USE_UIImageAndTextTableCell
	UIImageAndTextTableCell*	cell;
	cell = [[UIImageAndTextTableCell alloc] init];
	NSString *str = [NSString stringWithFormat:@"dsafjasjdjsfkljasldjaldjljlsdfasdjfkadkahdhfjkahhd%d", row];
	[cell setTitle:str];
	[[cell titleTextLabel] drawContentsInRect:CGRectMake(0, 0, 320, 96)];
	[[cell titleTextLabel] setWrapsText:NO];
GSFontRef titleFont = GSFontCreateWithName("Helvetica", kGSFontTraitBold, 12.0f);
	[[cell titleTextLabel] setFont:titleFont];
CFRelease(titleFont);
	[cell setDisclosureStyle:2];
	[cell setShowDisclosure:YES];
#endif
	return cell; 
}
- (void)tableRowSelected:(NSNotification*)notification {
	return YES;
}
@end