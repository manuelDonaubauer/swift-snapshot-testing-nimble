#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>

@interface CurrentTestCaseTracker : NSObject<XCTestObservation>

+ (instancetype _Nonnull)shared;
@property (nullable, assign) XCTestCase *currentTestCase;

@end
