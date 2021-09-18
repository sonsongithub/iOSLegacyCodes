
#import "MyApp.h"

extern NSString *kUIButtonBarButtonAction;
extern NSString *kUIButtonBarButtonInfo;
extern NSString *kUIButtonBarButtonInfoOffset;
extern NSString *kUIButtonBarButtonSelectedInfo;
extern NSString *kUIButtonBarButtonStyle;
extern NSString *kUIButtonBarButtonTag;
extern NSString *kUIButtonBarButtonTarget;
extern NSString *kUIButtonBarButtonTitle;
extern NSString *kUIButtonBarButtonTitleVerticalHeight;
extern NSString *kUIButtonBarButtonTitleWidth;
extern NSString *kUIButtonBarButtonType;
   
@implementation MyApp
- (void) applicationDidFinishLaunching: (id) unused {
	// Get screen rect
	CGRect  screenRect;
	screenRect = [UIHardware fullScreenApplicationContentRect];
	screenRect.origin.x = screenRect.origin.y = 0;
	
	CGRect sizeTextView = CGRectMake(0, 0, 320, 384);
	CGRect sizeNavigationBar = CGRectMake(0, 0, 320, 48);
	CGRect sizeButtonBar = CGRectMake(0, 20, 320, 48);
	
	// Create window
	UIWindow*   window = [[UIWindow alloc] initWithContentRect:screenRect];

	// Make size
	UIView*	view = [[UIView alloc] initWithFrame:sizeTextView];
	
	int style = 0;
	int type = 0;
	int i;
	
	int tag = 1;
	NSMutableArray *ary = [NSMutableArray array];
	[ary addObject: [NSDictionary dictionaryWithObjectsAndKeys:
		self, kUIButtonBarButtonTarget, 
		@"reload", kUIButtonBarButtonAction, 
		@"NavBack.png", kUIButtonBarButtonInfo, 
		[NSNumber numberWithUnsignedInt:tag++], kUIButtonBarButtonTag, 
		[NSNumber numberWithUnsignedInt:style], kUIButtonBarButtonStyle,
		[NSNumber numberWithUnsignedInt:type], kUIButtonBarButtonType,
		[NSValue valueWithSize:NSMakeSize(0., 0.)], kUIButtonBarButtonInfoOffset, 
		nil]
	];
	
	for( i = 0; i < 4; i++ ) {
		if( i == 3 ) {
			[ary addObject: [NSDictionary dictionaryWithObjectsAndKeys:
		self, kUIButtonBarButtonTarget, 
		@"reload", kUIButtonBarButtonAction, 
		@"reload.png", kUIButtonBarButtonInfo,
		[NSNumber numberWithUnsignedInt:style], kUIButtonBarButtonStyle,
		[NSNumber numberWithUnsignedInt:type], kUIButtonBarButtonType,
		[NSNumber numberWithUnsignedInt:tag++], kUIButtonBarButtonTag, 
		[NSValue valueWithSize:NSMakeSize(0., 2.)], kUIButtonBarButtonInfoOffset, 
		nil]
	];
	}
		else{
			[ary addObject: [NSDictionary dictionaryWithObjectsAndKeys:
			nil, kUIButtonBarButtonInfo,
		//	[NSNumber numberWithUnsignedInt:3], kUIButtonBarButtonStyle,
			[NSNumber numberWithUnsignedInt:3], kUIButtonBarButtonType,
			[NSNumber numberWithUnsignedInt:tag++], kUIButtonBarButtonTag,
			nil]
		];
		}
	}
	[ary addObject: [NSDictionary dictionaryWithObjectsAndKeys:
		self, kUIButtonBarButtonTarget, 
		@"reload", kUIButtonBarButtonAction, 
		@"NavForward.png", kUIButtonBarButtonInfo,
		[NSNumber numberWithUnsignedInt:style], kUIButtonBarButtonStyle,
		[NSNumber numberWithUnsignedInt:type], kUIButtonBarButtonType,
		[NSNumber numberWithUnsignedInt:tag++], kUIButtonBarButtonTag, 
		[NSValue valueWithSize:NSMakeSize(0., 2.)], kUIButtonBarButtonInfoOffset, 
		nil]
	];
	
	id buttonBar = [[UIButtonBar alloc] initInView:view withFrame:sizeButtonBar withItemList:ary];
	
	int* buttons = (int*)malloc(sizeof( int ) * tag );
	for( i = 1; i < tag; i++ ) {
		buttons[i-1] = i;
		NSLog( @"%d,%d", buttons[i-1], i );
	}
	
	[buttonBar registerButtonGroup:1 withButtons:buttons withCount:tag-1	];
	[buttonBar showButtonGroup:1 withDuration:0.2];
	//[buttonBar showButtons:buttons withCount:3 withDuration:(double)0.2];
	free( buttons );
	
	// Set content view
	[view addSubview:buttonBar];
	[window setContentView:view];
	
	// Show window
	[window orderFront:self];
	[window makeKey:self];
	[window _setHidden:NO];
}
- (void) reload {
	NSLog( @"reload" );
}
@end