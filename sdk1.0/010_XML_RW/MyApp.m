
#import "MyApp.h"

#define BOARD_XML_PATH "/tmp/boards.xml"

@implementation MyApp
- (NSMutableArray*) pullBoardTitles:(NSString*)url {
	NSURLResponse *response = nil;
	NSError *error = nil;	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0];
	NSData *rssData = [NSURLConnection sendSynchronousRequest: theRequest returningResponse: &response error: &error];   
	NSString *decoded_strings = [[NSString alloc] initWithData:rssData encoding:NSShiftJISStringEncoding];
	return [self processXML: decoded_strings];
}
- (void) showBoardData {
	int i,j;
	for( i = 0; i < [boardData_ count]; i++ ) {
		NSMutableArray *temp = [boardData_ objectAtIndex:i];
		NSLog( [temp objectAtIndex:0] );
		for( j = 1; j < [temp count]; j++ ) {
			NSLog( @"-%@,(%@)", [[temp objectAtIndex:j] objectAtIndex:0],[[temp objectAtIndex:j] objectAtIndex:1] );
		}
	}
}
- (NSMutableArray*) processXML:(NSString*)data {
	NSError *err = nil;
	NSXMLDocument *xmlDoc = [[[NSClassFromString(@"NSXMLDocument") alloc]
			initWithXMLString:data 
			options:NSXMLDocumentTidyHTML
			error:&err] autorelease];
	NSXMLNode *rootNode = [xmlDoc rootElement];	
	boardData_ = [NSMutableArray array];
	if ( [[rootNode name] isEqualToString: @"html"] ) {
		NSXMLNode *nodesInHTML = [[rootNode children] objectEnumerator];
		NSXMLNode *nodeInHTML = nil;
		while( nodeInHTML = [nodesInHTML nextObject] ) {
			if( [[nodeInHTML name] isEqualToString:@"body"] ) {
				NSXMLNode *nodesInBody = [[nodeInHTML children] objectEnumerator];
				NSXMLNode *nodeInBody = nil;
				NSMutableArray *ary = nil;
				while( nodeInBody = [nodesInBody nextObject] ) {
					if( [[nodeInBody name] isEqualToString:@"b"] ) {
						if(ary) {
							[boardData_ addObject:ary];
							ary = nil;
						}
						NSString *title = [NSString stringWithCString:[[nodeInBody stringValue] UTF8String] encoding:NSUTF8StringEncoding];
						//NSString *title = [NSString stringWithCString:[[nodeInBody stringValue] UTF8String] encoding:NSASCIIStringEncoding];
						if( [title isEqualToString: @""] || !title)
							continue;
						ary = [NSMutableArray array];
						[ary addObject:title];
					}
					else if( [[nodeInBody name] isEqualToString:@"a"] && ary ) {
						NSString *title = [NSString stringWithCString:[[nodeInBody stringValue] UTF8String] encoding:NSUTF8StringEncoding];
						//NSString *title = [NSString stringWithCString:[[nodeInBody stringValue] UTF8String] encoding:NSASCIIStringEncoding];
						NSString *href = [NSString stringWithCString:[[[nodeInBody attributeForName:@"href"] stringValue] UTF8String] encoding:NSUTF8StringEncoding];
						//NSString *href = [NSString stringWithCString:[[[nodeInBody attributeForName:@"href"] stringValue] UTF8String] encoding:NSASCIIStringEncoding];
						
						if( [href isEqualToString: @"http://count.2ch.net/?bbsmenu"])
							continue;
							
						NSMutableArray *board_data = [NSMutableArray array];
						[board_data addObject:title];
						[board_data addObject:href];
						[ary addObject:board_data];
					}
				}
				if(ary) {
							[boardData_ addObject:ary];
							ary = nil;
						}
				break;
			}
		}
	}
}
- (BOOL) readXML {
	boardData_ = [NSMutableArray array];	
	NSData *dataToRead = [NSData dataWithContentsOfFile:@BOARD_XML_PATH];
	if( !dataToRead )
		return NO;
	//NSString *decoded_strings = [[NSString alloc] initWithData:dataToRead encoding:NSShiftJISStringEncoding];
	NSString *decoded_strings = [[NSString alloc] initWithData:dataToRead encoding:NSUTF8StringEncoding];
	id xmlDoc = [[[NSClassFromString(@"NSXMLDocument") alloc] initWithXMLString:decoded_strings options:NSXMLDocumentTidyXML error:nil] autorelease];	
	
	NSXMLElement*rootNode = [xmlDoc rootElement];
	
	if ( [[rootNode name] isEqualToString: @"XML"] ) {
		NSEnumerator *categoryNodeEnum = [[rootNode children] objectEnumerator];
		NSXMLElement*categoryNode;
		while (categoryNode = [categoryNodeEnum nextObject]) {
			if( [[categoryNode name] isEqualToString: @"Category"]){
			
				NSMutableArray *ary = [NSMutableArray array];
				//NSString *href = [NSString stringWithCString:[[[categoryNode attributeForName:@"name"] stringValue] UTF8String] encoding:NSASCIIStringEncoding];
				NSString *href = [NSString stringWithCString:[[[categoryNode attributeForName:@"name"] stringValue] UTF8String] encoding:NSUTF8StringEncoding];
				[ary addObject:href];
				
				NSEnumerator *boardNodeEnum = [[categoryNode children] objectEnumerator];
				NSXMLElement*boardNode;
				while (boardNode = [boardNodeEnum nextObject]) {
					if( [[boardNode name] isEqualToString: @"board"]) {
						//NSString *href = [NSString stringWithCString:[[boardNode stringValue] UTF8String] encoding:NSASCIIStringEncoding];
						NSString *href = [NSString stringWithCString:[[boardNode stringValue] UTF8String] encoding:NSUTF8StringEncoding];
						//NSString *title = [NSString stringWithCString:[[[boardNode attributeForName:@"name"] stringValue] UTF8String] encoding:NSASCIIStringEncoding];
						NSString *title = [NSString stringWithCString:[[[boardNode attributeForName:@"name"] stringValue] UTF8String] encoding:NSUTF8StringEncoding];
						NSMutableArray *board_data = [NSMutableArray array];
						[board_data addObject:title];
						[board_data addObject:href];
						[ary addObject:board_data];
					}
				}
				[boardData_ addObject:ary];
			}
		}
	}
	return YES;
}
- (BOOL) writeXML {
	[self pullBoardTitles:@"http://menu.2ch.net/bbsmenu.html"];
	NSXMLElement*rootElement = (NSXMLElement *)[NSClassFromString(@"NSXMLNode") elementWithName:@"XML"];
	int i,j;
	for( i = 0; i < [boardData_ count]; i++ ) {
		NSMutableArray *elements = [boardData_ objectAtIndex:i];
		NSString *category_name = [elements objectAtIndex:0];
		
		NSXMLElement *category = [NSClassFromString(@"NSXMLElement") elementWithName:@"Category"];
		NSXMLNode *attribute_category = [NSClassFromString(@"NSXMLNode") attributeWithName:@"name" stringValue:category_name];
		[category addAttribute:attribute_category];
		
		for( j = 1; j < [elements count]; j++ ) {
			NSString *board_name = [[elements objectAtIndex:j] objectAtIndex:0];
			NSString *board_url = [[elements objectAtIndex:j] objectAtIndex:1];
			
			NSXMLElement *href_node = [NSClassFromString(@"NSXMLElement") elementWithName:@"board" stringValue:board_url];
			NSXMLNode *href_name_attr = [NSClassFromString(@"NSXMLNode") attributeWithName:@"name" stringValue:board_name];
			[href_node addAttribute:href_name_attr];
			[category addChild:href_node];
		}
		[rootElement addChild:category];
	}
	id xmlDoc = [[NSClassFromString(@"NSXMLDocument") alloc] initWithRootElement:rootElement];
	NSData *dataToRead = [xmlDoc XMLData];
	[dataToRead writeToFile:@BOARD_XML_PATH atomically:YES];
	return YES;
}
- (id) getTables {
	return boardData_;
}
- (void)navigationBar:(UINavigationBar*)navbar buttonClicked:(int)button {
	[self writeXML];
}	
- (void) applicationDidFinishLaunching: (id) unused {
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	
	// Create window
	window_ = [[UIWindow alloc] initWithContentRect:screenRect];
	
	// Make size
	CGRect sizeTextView = CGRectMake(0, 48, 320, 480);
	CGRect sizeNavigationBar = CGRectMake(0, 0, 320, 48);
	
	// Set content view
	textView_ = [[UITextView alloc] initWithFrame:sizeTextView];
	[window_ setContentView:textView_];
	
	// Make navigation var
	UINavigationBar*bar = [[UINavigationBar alloc] initWithFrame:sizeNavigationBar];
	[bar showButtonsWithLeftTitle:@"Left" rightTitle:@"Right" leftBack:NO];
	[bar setBarStyle:5];
	[bar setDelegate:self];
	UINavigationItem *title = [[UINavigationItem alloc] initWithTitle: @"NaviBar"];
	[bar pushNavigationItem: title];
	[window_ addSubview:bar];

//
	if( ![self readXML] ) {
		[self writeXML];
		[textView_ setText:@"write"];
	}
	else
		[textView_ setText:@"read"];
/*	
	int i,j;
	for( i = 0; i < [boardData_ count]; i++ ) {
		NSMutableArray *temp = [boardData_ objectAtIndex:i];
		[textView_ setText:[temp objectAtIndex:0]];
		//NSLog(  );
		//for( j = 1; j < [temp count]; j++ ) {
		//	NSLog( @"-%@,(%@)", [[temp objectAtIndex:j] objectAtIndex:0],[[temp objectAtIndex:j] objectAtIndex:1] );
		//}
	}
*/	
	// Show window_
	[window_ orderFront:self];
	[window_ makeKey:self];
	[window_ _setHidden:NO];
}
@end