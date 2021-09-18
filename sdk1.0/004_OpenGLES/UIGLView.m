
#import "UIGLView.h"

static void PerspectiveMatrix(float fovy, float aspect, float zNear, float zFar)
{
	float f = 1.0f / tanf(fovy * (M_PI / 360.f));
	float z1 = (zFar + zNear) / (zNear - zFar);
	float z2 = (2 * zFar * zNear) / (zNear - zFar);
	float m[] =
	{
		f / aspect,  0,	  0,	  0,
		0,		   f,	  0,	  0,
		0,		   0,	 z1,	 -1,
		0,		   0,	 z2,	  0
	};

	glMultMatrixf(m);
}

static CoreSurfaceBufferRef CreateSurface(int w, int h)
{
    int pitch = w * 2, allocSize = 2 * w * h;
    char *pixelFormat = "565L";
    CFMutableDictionaryRef dict;

    dict = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(dict, kCoreSurfaceBufferGlobal,        kCFBooleanTrue);
    CFDictionarySetValue(dict, kCoreSurfaceBufferMemoryRegion,  CFSTR("PurpleGFXMem"));
    CFDictionarySetValue(dict, kCoreSurfaceBufferPitch,         CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &pitch));
    CFDictionarySetValue(dict, kCoreSurfaceBufferWidth,         CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &w));
    CFDictionarySetValue(dict, kCoreSurfaceBufferHeight,        CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &h));
    CFDictionarySetValue(dict, kCoreSurfaceBufferPixelFormat,   CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, pixelFormat));
    CFDictionarySetValue(dict, kCoreSurfaceBufferAllocSize,     CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &allocSize));

    return CoreSurfaceBufferCreate(dict);
}


@implementation UIGLView
- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		EGLDisplay eglDisplay = eglGetDisplay(0);
		EGLint versMajor;
		EGLint versMinor;
		EGLBoolean result = eglInitialize(eglDisplay, &versMajor, &versMinor);
		
		if (result) {
			printf("GL version %d.%d¥n", versMajor, versMinor);
			
			EGLint configAttribs[] = {
				EGL_BUFFER_SIZE, 16,
				EGL_DEPTH_SIZE, 16,
				EGL_SURFACE_TYPE, EGL_PBUFFER_BIT,
				EGL_NONE
			};

			int numConfigs;
			EGLConfig eglConfig;
			if (!eglChooseConfig(eglDisplay, configAttribs, &eglConfig, 1, &numConfigs) || (numConfigs != 1))
				printf("failed to find usable config =(¥n");
			else {
				GLint configID;
				eglGetConfigAttrib(eglDisplay, eglConfig, EGL_CONFIG_ID, &configID);
			}
				
			EGLContext eglContext = eglCreateContext(eglDisplay, eglConfig, EGL_NO_CONTEXT, 0);
			
			if (eglContext == EGL_NO_CONTEXT)
				printf("failed to allocate context =(¥n");
		
			CoreSurfaceBufferRef screenSurface = CreateSurface(frame.size.width, frame.size.height);
			
			CoreSurfaceBufferLock(screenSurface, 3);
			LKLayer* screenLayer = [[LKLayer layer] retain];
			[screenLayer setFrame: CGRectMake(0, 0, frame.size.width, frame.size.height)];
			[screenLayer setContents: screenSurface];
			[screenLayer setOpaque: YES];
			[_layer addSublayer: screenLayer];
			CoreSurfaceBufferUnlock(screenSurface);
			
			EGLSurface eglSurface = eglCreatePixmapSurface(eglDisplay, eglConfig, screenSurface, 0);
		   
			if (eglSurface == EGL_NO_SURFACE)
				printf("failed to create surface =(, %04x¥n", eglGetError());

			mEGLDisplay = eglDisplay;
			mEGLContext = eglContext;
			mEGLSurface = eglSurface;
			mScreenSurface = screenSurface;
			
			if (!eglMakeCurrent(mEGLDisplay, mEGLSurface, mEGLSurface, mEGLContext))
				printf("make current error: %04x¥n", eglGetError());
		}
	}
	
	t_ = 0;
	
	return self;
}
- (void) drawRect: (CGRect) rect {
	eglWaitNative(EGL_CORE_NATIVE_ENGINE);
	CoreSurfaceBufferLock(mScreenSurface, 3);
	if (!eglMakeCurrent(mEGLDisplay, mEGLSurface, mEGLSurface, mEGLContext))
		printf("make current error: %04x¥n", eglGetError());

	glEnable(GL_DEPTH_TEST);
	glClearColor(0.3f, 0.9f, 0.4f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
	
	int tw, th;

	eglQuerySurface(mEGLDisplay, mEGLSurface, EGL_WIDTH,  &tw);
	eglQuerySurface(mEGLDisplay, mEGLSurface, EGL_HEIGHT, &th);

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	PerspectiveMatrix(50, (float) tw / (float) th, 0.1f, 1000);
	
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	
	glTranslatef( 0, 0, -10 );
	glRotatef( t_, 0, 1, 0 );
	glRotatef( t_, 1, 0, 0 );
	[self drawCube];
	
	t_ += 1.0f;
	
	glDisable(GL_CULL_FACE);
	eglWaitGL();
	eglMakeCurrent(mEGLDisplay, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
	CoreSurfaceBufferUnlock(mScreenSurface);
}
- (void) drawCube {
	const float verts[] =
	{
		 1.0f, 1.0f,-1.0f,	
		-1.0f, 1.0f,-1.0f,	
		-1.0f, 1.0f, 1.0f,	
		 1.0f, 1.0f, 1.0f,	

		 1.0f,-1.0f, 1.0f,	
		-1.0f,-1.0f, 1.0f,	
		-1.0f,-1.0f,-1.0f,	
		 1.0f,-1.0f,-1.0f,	

		 1.0f, 1.0f, 1.0f,	
		-1.0f, 1.0f, 1.0f,	
		-1.0f,-1.0f, 1.0f,	
		 1.0f,-1.0f, 1.0f,	

		 1.0f,-1.0f,-1.0f,	
		-1.0f,-1.0f,-1.0f,	
		-1.0f, 1.0f,-1.0f,	
		 1.0f, 1.0f,-1.0f,	

		 1.0f, 1.0f,-1.0f,	
		 1.0f, 1.0f, 1.0f,	
		 1.0f,-1.0f, 1.0f,	
		 1.0f,-1.0f,-1.0f,

		-1.0f, 1.0f, 1.0f,	
		-1.0f, 1.0f,-1.0f,	
		-1.0f,-1.0f,-1.0f,	
		-1.0f,-1.0f, 1.0f
	 };

	glEnableClientState(GL_VERTEX_ARRAY);
	
	glColor4f(0, 1, 0, 1);
	glVertexPointer(3, GL_FLOAT, 0, verts);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	
	glColor4f(1, 0, 1, 1);
	glVertexPointer(3, GL_FLOAT, 0, verts + 12);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	
	glColor4f(0, 0, 1, 1);
	glVertexPointer(3, GL_FLOAT, 0, verts + 24);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	
	glColor4f(1, 1, 0, 1);
	glVertexPointer(3, GL_FLOAT, 0, verts + 36);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	
	glColor4f(1, 0, 0, 1);
	glVertexPointer(3, GL_FLOAT, 0, verts + 48);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	
	glColor4f(0, 1, 1, 1);
	glVertexPointer(3, GL_FLOAT, 0, verts + 60);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
}
@end
