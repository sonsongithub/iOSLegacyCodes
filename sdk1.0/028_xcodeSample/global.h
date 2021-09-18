
#ifndef _GLOBAL

#import "MyApp.h"

// for debug logger
#ifdef		_DEBUG
	#define	DNSLog(...);			NSLog(__VA_ARGS__);
#else
	#define DNSLog(...);			// NSLog(__VA_ARGS__);
#endif

// like singleton
#define		UIApp		(MyApp*)UIApp

#endif