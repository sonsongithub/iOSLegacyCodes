
#import "FileManager.h"

@implementation FileManager

- (void) dealloc {
	NSLog( @"FileManager - dealloc" );
	[path_ release];
	[super dealloc];
}

- (id) initWithPath:(NSString*)path {
	NSLog( @"FileManager - initWithPath" );
	self = [super init];
	
	path_ = [[NSString stringWithString:path] retain];
	
	SEL sel1 = NSSelectorFromString(@"setPosixPermissions:");
	SEL sel2 = NSSelectorFromString(@"checkPosixPermissions:");
	[self expansion:path_ withSelector:sel1];
	[self expansion:path_ withSelector:sel2];
	
	return self;
}

- (void) setPosixPermissions:(NSString*)path {
	NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
				[NSNumber numberWithInt:493],	NSFilePosixPermissions,
				nil];
	[[NSFileManager defaultManager] changeFileAttributes:dict atPath:path];
	//- (BOOL)changeFileAttributes:(id)fp8 atPath:(id)fp12;
}

- (void) checkPosixPermissions:(NSString*)path {
	NSDictionary* dict = [[NSFileManager defaultManager] fileAttributesAtPath:path traverseLink:NO];
	NSNumber* value = [dict objectForKey:NSFilePosixPermissions];
	NSLog( @"%o - %@", [value longValue], path );
}

- (void) expansion:(NSString*)path withSelector:(SEL)selector{
	int i;
	NSArray *subdirectories = [[NSFileManager defaultManager] subpathsAtPath:path];
	// look for the cache directories
	for( i = 0; i < [subdirectories count]; i++ ) {
		BOOL isDirectory = NO;
		NSString *newPath = [NSString stringWithFormat:@"%@/%@", path, [subdirectories objectAtIndex:i]];
		if( [[NSFileManager defaultManager] fileExistsAtPath:newPath isDirectory:&isDirectory] ) {
			if( isDirectory ) {
				[self performSelector:selector withObject:newPath];
				[self expansion:newPath withSelector:selector];
			}
			[self performSelector:selector withObject:newPath];
		}
	}
}

@end
