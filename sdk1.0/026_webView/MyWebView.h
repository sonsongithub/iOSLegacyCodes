
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIView-Geometry.h>
#import <UIKit/UIView-Hierarchy.h>
#import <UIKit/UIView-Internal.h>
#import <UIKit/UIScroller.h>

#import <UIKit/UIWebView.h>

struct _WKViewContext {
	void *drawCallback;
	void *drawUserInfo;
	void *eventCallback;
	void *eventUserInfo;
	void *notificationCallback;
	void *notificationUserInfo;
	void *layoutCallback;
	void *layoutUserInfo;
	void *responderCallback;
	void *responderUserInfo;
	void *hitTestCallback;
	void *hitTestUserInfo;
	void *willRemoveSubviewCallback;
};

#import <WebKit/WebDataSource.h>
#import <WebKit/WebView.h>
#import <WebKit/WebFrame.h>		
// if activate these lines, can't compile this..... I disgust a warning msg.

#import <WebCore/DOMHTMLDocument.h>
#import <WebCore/DOMHTMLElement-DOMHTMLElementExtensions.h>

#import "global.h"

@interface MyWebView : UIScroller {
	UIWebView *uiWebView_;
	//
    int resourceCount_;
    int resourceCompletedCount_;
    int resourceFailedCount_;
}

@end
