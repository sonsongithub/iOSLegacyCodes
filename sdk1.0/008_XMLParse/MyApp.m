
#import "MyApp.h"

@implementation MyApp
- (NSString*) readLog {
	NSData *data = [NSData dataWithContentsOfFile:@"/tmp/log_sonson.log"];
	return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
- (void) writeLogWithInt:(int)code {
	FILE *fp;
	fp = fopen( "/tmp/log_sonson.log", "aw" );
	fprintf( fp, "%d - ", code );
	fclose( fp );
}
- (void) writeLog:(NSString *)str {
	FILE *fp;
	fp = fopen( "/tmp/log_sonson.log", "aw" );
	fprintf( fp, "%s - ", [str UTF8String] );
	fclose( fp );
}
- (void) clearLog {
	FILE *fp;
	fp = fopen( "/tmp/log_sonson.log", "w" );
	fprintf( fp, "" );
	fclose( fp );
}
- (void)navigationBar:(UINavigationBar*)navbar buttonClicked:(int)button {
	//[self clearLog];
	//[textView_ setText:@"log file cleard."]; 
}
- (NSMutableArray*) pullBoardTitles:(NSString*)url {
	NSURLResponse *response = nil;
	NSError *error = nil;	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0];
	NSData *rssData = [NSURLConnection sendSynchronousRequest: theRequest returningResponse: &response error: &error];   
	NSString *decoded_strings = [[NSString alloc] initWithData:rssData encoding:NSShiftJISStringEncoding];
	//[textView_ setText:decoded_strings];
	return [self processXML: decoded_strings];
}
- (NSMutableArray*) processXML:(NSString*)data {
	NSError *err = nil;
	NSXMLDocument *xmlDoc = [[[NSClassFromString(@"NSXMLDocument") alloc]
			initWithXMLString:data 
			options:NSXMLDocumentTidyHTML
			error:&err] autorelease];
	titles_ = [[NSMutableArray array] retain];		// for titles
	
	NSXMLNode *rootNode = [xmlDoc rootElement];
	[self writeLog:[rootNode name]];
	
	if ( [[rootNode name] isEqualToString: @"html"] ) {
		NSXMLNode *nodesInHTML = [[rootNode children] objectEnumerator];
		NSXMLNode *nodeInHTML = nil;
		while( nodeInHTML = [nodesInHTML nextObject] ) {
			if( [[nodeInHTML name] isEqualToString:@"body"] ) {
				NSXMLNode *nodesInBody = [[nodeInHTML children] objectEnumerator];
				NSXMLNode *nodeInBody = nil;
				while( nodeInBody = [nodesInBody nextObject] ) {
					if( [[nodeInBody name] isEqualToString:@"b"] ) {
						NSString *title = [NSString stringWithCString:[[nodeInBody stringValue] UTF8String] encoding:NSUTF8StringEncoding];
						[titles_ addObject:title];
					}
				}
			}
		}
	}
}
- (void) applicationDidFinishLaunching: (id) unused {
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	
	// Create window
	window_ = [[UIWindow alloc] initWithContentRect:screenRect];
	
	// Make size
	CGRect sizeTextView = CGRectMake(0, 48, 320, 480 - 64);
	CGRect sizeNavigationBar = CGRectMake(0, 0, 320, 48);
	
	// Set content view
	//textView_ = [[UITextView alloc] initWithFrame:sizeTextView];
	//[textView_ setTextSize:10.0f];
	//[textView_ setText:@"aa"];
	
	[self pullBoardTitles:@"http://menu.2ch.net/bbsmenu.html"];
	//NSString *str = [NSString stringWithFormat:@"%d", [test count] ];
	
	UITableColumn*  tableColumn;
	tableColumn = [[UITableColumn alloc] initWithTitle:@"title"
			identifier:@"title" width:320];
	
	UITable*	table;
	table = [[UITable alloc] initWithFrame:sizeTextView];
	[table addTableColumn:tableColumn];
	[table setDataSource:self];
	[table setDelegate:self];
	[table setSeparatorStyle:1];
//	[table setRowHeight:12.0f];
	[window_ addSubview:table];
	
	// Make navigation var
	UINavigationBar*bar = [[UINavigationBar alloc] initWithFrame:sizeNavigationBar];
	[bar showButtonsWithLeftTitle:@"clear" rightTitle:@"clear" leftBack:NO];
	[bar setBarStyle:5];
	[bar setDelegate:self];
	[window_ addSubview:bar];
	
	// Show window_
	[window_ orderFront:self];
	[window_ makeKey:self];
	[window_ _setHidden:NO];
	//
		
	[table reloadData];
}
- (void)dealloc {
	//[titles_ release];
	[super dealloc];
}
- (BOOL)table:(UITable *)aTable canSelectRow:(int)row {
	return YES;
}
- (int)numberOfRowsInTable:(UITable*)table {
	return [titles_ count];
}
- (UITableCell*)table:(UITable*)table cellForRow:(int)row column:(int)col {
	UIImageAndTextTableCell*	cell;
	cell = [[UIImageAndTextTableCell alloc] init];
	[cell setTitle:[titles_ objectAtIndex:row]];
	//[cell setTitle:[NSString stringWithFormat:@"row %d", row]];
	[cell setDisclosureStyle:2];
	[cell setShowDisclosure:YES];
	
	return cell; 
}
@end