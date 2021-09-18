
#ifndef _GLOBAL

#import <GraphicsServices/GraphicsServices.h>

// for debug logger
#ifdef		_DEBUG
	#define	DNSLog(...);			NSLog(__VA_ARGS__);
#else
	#define DNSLog(...);			// NSLog(__VA_ARGS__);
#endif

// like singleton
#define		UIApp		(MyApp*)UIApp

// rotation constants
#define		UIAppOrientScreenUp		0
#define		UIAppOrientNormal		1
#define		UIAppOrientUpsideDown	2
#define		UIAppOrientLeft			3
#define		UIAppOrientRight		4
#define		UIAppOrientUnknown		5
#define		UIAppOrientProne		6

#endif