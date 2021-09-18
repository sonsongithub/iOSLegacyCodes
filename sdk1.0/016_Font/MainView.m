
#import "MainView.h"
#import <GraphicsServices/GraphicsServices.h>

@implementation MainView

- (id) initWithFrame: (CGRect) frame {
	self = [super initWithFrame: frame];
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	float transparentomponents[4] = {1, 1, 1, 0};
	float white[4] = {1, 1, 1, 1};
	CGRect sizeTableView = CGRectMake(0, 200, 200, 480 - 216);
	CGRect sizeTraitTable = CGRectMake(200, 200, 60, 480 - 216);
	CGRect sizeSizeTable = CGRectMake(260, 200, 60, 480 - 216);

	// make title label
	label_ = [[[UITextLabel alloc] initWithFrame:CGRectMake( 5, 5, 0, 0)] autorelease];
	GSFontRef infoFont = [UIImageAndTextTableCell defaultTitleFont];
	[label_ setFont:infoFont];
	[label_ setWrapsText:YES];
	[label_ sizeToFit];
	[label_ setBackgroundColor: CGColorCreate( colorSpace, transparentomponents)];
	[self addSubview:label_];
	
	[self setBackgroundColor: CGColorCreate( colorSpace, white)];

	sizeArray_ = [[NSMutableArray array] retain];
	[sizeArray_ addObject:@"9"];
	[sizeArray_ addObject:@"10"];
	[sizeArray_ addObject:@"11"];
	[sizeArray_ addObject:@"12"];
	[sizeArray_ addObject:@"13"];
	[sizeArray_ addObject:@"14"];
	[sizeArray_ addObject:@"18"];
	[sizeArray_ addObject:@"24"];
	[sizeArray_ addObject:@"36"];
	[sizeArray_ addObject:@"48"];
	[sizeArray_ addObject:@"64"];
	[sizeArray_ addObject:@"96"];
	[sizeArray_ addObject:@"144"];
	[sizeArray_ addObject:@"288"];
	
	traitArray_ = [[NSMutableArray array] retain];
	[traitArray_ addObject:@"normal"];
	[traitArray_ addObject:@"bold"];
	[traitArray_ addObject:@"italic"];
	[traitArray_ addObject:@"b&i"];
	
	fontArray_ = [[NSMutableArray array] retain];
	[fontArray_ addObject:@"american typewriter"];
	[fontArray_ addObject:@"applegothic"];
	[fontArray_ addObject:@"arial"];
	[fontArray_ addObject:@"arial rounded mt bold"];
	[fontArray_ addObject:@"arial unicode ms"];
	[fontArray_ addObject:@"courier"];
	[fontArray_ addObject:@"courier new"];
	[fontArray_ addObject:@"db lcd temp"];
	[fontArray_ addObject:@"georgia"];
	[fontArray_ addObject:@"helvetica"];
	[fontArray_ addObject:@"helvetica neue"];
	[fontArray_ addObject:@"hiragino kaku gothic pron"];
	[fontArray_ addObject:@"lock clock"];
	[fontArray_ addObject:@"marker felt"];
	[fontArray_ addObject:@"phonepadtwo"];
	[fontArray_ addObject:@"stheiti"];
	[fontArray_ addObject:@"times new roman"];
	[fontArray_ addObject:@"trebuchet ms"];
	[fontArray_ addObject:@"verdana"];
	[fontArray_ addObject:@"zapinfo"];
	
	// create table
	UITableColumn*  tableColumn = [[[UITableColumn alloc] initWithTitle:@"font" identifier:@"font" width:200] autorelease];
	fontTable_ = [[UITable alloc] initWithFrame:sizeTableView];
	[fontTable_ addTableColumn:tableColumn];
	[fontTable_ setDataSource:self];
	[fontTable_ setDelegate:self];
	[fontTable_ setSeparatorStyle:1];
	[fontTable_ reloadData];
	[fontTable_ _userSelectRow:0];
	[self addSubview:fontTable_];
	
	
	// create table
	tableColumn = [[[UITableColumn alloc] initWithTitle:@"trait" identifier:@"trait" width:60] autorelease];
	traitTable_ = [[UITable alloc] initWithFrame:sizeTraitTable];
	[traitTable_ addTableColumn:tableColumn];
	[traitTable_ setDataSource:self];
	[traitTable_ setDelegate:self];
	[traitTable_ setSeparatorStyle:1];
	[traitTable_ reloadData];
	[traitTable_ _userSelectRow:0];
	[self addSubview:traitTable_];

	// create table
	tableColumn = [[[UITableColumn alloc] initWithTitle:@"trait" identifier:@"trait" width:60] autorelease];
	sizeTable_ = [[UITable alloc] initWithFrame:sizeSizeTable];
	[sizeTable_ addTableColumn:tableColumn];
	[sizeTable_ setDataSource:self];
	[sizeTable_ setDelegate:self];
	[sizeTable_ setSeparatorStyle:1];
	[sizeTable_ _userSelectRow:0];
	[self addSubview:sizeTable_];
	
	[sizeTable_ reloadData];
	
	return self;
}

- (void) updateFontWithFontName:(NSString*)fontName withTrait:(int)trait withSize:(float)size {
	GSFontRef font = GSFontCreateWithName((char *)[fontName UTF8String], trait, size);
	[label_ setFont:font];
	[label_ setText:@"ABC"];
	[label_ sizeToFit];
	CGRect rect_body = [body_label bounds];
	CFRelease( font );
}

// UITable's delegate

- (BOOL)table:(UITable *)aTable canSelectRow:(int)row {
	return YES;
}

- (int)numberOfRowsInTable:(UITable*)table {
	if( table == fontTable_ ) {
		return [fontArray_ count];
	}
	else if( table == traitTable_ ) {
		return [traitArray_ count];
	}
	else if( table == sizeTable_ ) {
		return [sizeArray_ count];
	}
	else
		return 0;
}

- (UITableCell*)table:(UITable*)table cellForRow:(int)row column:(int)col {
	UIImageAndTextTableCell *cell = [[[UIImageAndTextTableCell alloc] init] autorelease];
	
	if( table == fontTable_ ) {
		[cell setTitle:[fontArray_ objectAtIndex:row]];
	}
	else if( table == traitTable_ ) {
		[cell setTitle:[traitArray_ objectAtIndex:row]];
	}
	else if( table == sizeTable_ ) {
		[cell setTitle:[sizeArray_ objectAtIndex:row]];
	}
	else
		return nil;
	return cell;
}

- (void)tableRowSelected:(NSNotification*)notification {
	NSString *fontname = [fontArray_ objectAtIndex:[fontTable_ selectedRow]];
	float size = [[sizeArray_ objectAtIndex:[sizeTable_ selectedRow]] floatValue];
	int trait = [traitTable_ selectedRow];
	[self updateFontWithFontName:fontname withTrait:trait withSize:size];
}

@end
