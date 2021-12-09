#import "XCTestObservationCenter+CurrentTestCaseTracker.h"
#import "CurrentTestCaseTracker.h"

@implementation XCTestObservationCenter (CurrentTestCaseTracker)

+ (void)load {
    [[self sharedTestObservationCenter] addTestObserver:[CurrentTestCaseTracker shared]];
}

@end
