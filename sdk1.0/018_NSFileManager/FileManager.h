
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>

@interface FileManager : NSObject {
	NSString* path_;	
}
- (id) initWithPath:(NSString*)path;
- (void) checkPosixPermissions:(NSString*)path;
- (void) expansion:(NSString*)path withSelector:(SEL)selector;
@end
