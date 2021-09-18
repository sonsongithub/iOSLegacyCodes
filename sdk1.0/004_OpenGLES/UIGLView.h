
#import <CoreSurface/CoreSurface.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import <OpenGLES/egl.h>

@interface UIGLView : UIView {
	EGLDisplay mEGLDisplay;
	EGLContext mEGLContext;
	EGLSurface mEGLSurface;
	CoreSurfaceBufferRef mScreenSurface;
	float t_;
}
- (void)drawCube;
- (id)initWithFrame:(CGRect)frame;
@end
