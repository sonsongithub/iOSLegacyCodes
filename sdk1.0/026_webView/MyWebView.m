
#import "MyWebView.h"

@interface UIWebView (HackWebView)	// for peeking msg to UIWebView
- (BOOL) respondsToSelector:(SEL) selector;
@end
@implementation UIWebView (HackWebView)
- (BOOL) respondsToSelector:(SEL) selector {
	NSLog(@"[UIWebView] respondsToSelector: %s", selector);
	return [super respondsToSelector:selector];
}
@end

@implementation MyWebView
- (id) initWithFrame:(CGRect) frame {
	if( ! ( self = [super initWithFrame:frame] ) )
		return nil;
		
	// create WebView
	uiWebView_ = [[[UIWebView alloc] initWithFrame:frame] autorelease];
	[uiWebView_ setDelegate:self];
//	[[uiWebView_ webView] setPolicyDelegate:self];
	[uiWebView_ setTilingEnabled: YES];
	[uiWebView_ setTileSize: CGSizeMake(320,500)];
	[uiWebView_ setAutoresizes: YES];
	[self addSubview:uiWebView_];
	
	// set delegate
	id webView = [uiWebView_ webView];
	[webView setResourceLoadDelegate:self];
	[webView setDownloadDelegate:self];
	[webView setFrameLoadDelegate:self];
	
	// load html
	NSString *path = [[NSBundle mainBundle] pathForResource:@"source" ofType:@"html"];
	NSString *html = [NSString stringWithContentsOfFile:path encoding:/*NSShiftJISStringEncoding*/NSUTF8StringEncoding error:nil];
	[uiWebView_ loadHTMLString:html baseURL:nil];
	
	return self;
}

// delegate

- (void)webView:(WebView*)sender didStartProvisionalLoadForFrame:(WebFrame*)frame {
	if (frame == [sender mainFrame]) {
		resourceCount_ = 0;    
		resourceCompletedCount_ = 0;
		resourceFailedCount_ = 0;
		[UIApp setStatusBarShowsProgress:YES];
	}
}

- (id)webView:(WebView*)sender identifierForInitialRequest:(NSURLRequest*)request fromDataSource:(WebDataSource*)dataSource {
	NSNumber*number;
	number = [NSNumber numberWithInt:resourceCount_++];
	return number;
}

- (void)webView:(WebView*)sender resource:(id)identifier didFailLoadingWithError:(NSError*)error fromDataSource:(WebDataSource*)dataSource {
	resourceFailedCount_++;
	[self controlSyndicator];
}

- (void)webView:(WebView*)sender resource:(id)identifier didFinishLoadingFromDataSource:(WebDataSource*)dataSource {
    resourceCompletedCount_++;
	[self controlSyndicator];
}

- (void) view:(id)view didDrawInRect:(CGRect)rect duration:(float)duration {
}

- (void) view:(id)view didSetFrame:(CGRect)currentRect oldFrame:(CGRect)oldRect {
	[self setContentSize:currentRect.size];
}

- (BOOL) respondsToSelector:(SEL) selector {
	NSLog(@"[MyWebView] respondsToSelector: %s", selector);
	return [super respondsToSelector:selector];
}

// method

- (void) controlSyndicator {
	int  downloadedCount = resourceCompletedCount_ + resourceFailedCount_;
	if( downloadedCount == resourceCount_ ) {
		[UIApp setStatusBarShowsProgress:NO];
	}
}

@end
