//
//  File.m
//  
//
//  Created by Bastian Kusserow on 09.12.21.
//

#import <Foundation/Foundation.h>
#import "CurrentTestCaseTracker.h"

@implementation CurrentTestCaseTracker

+ (instancetype)shared
{
    static CurrentTestCaseTracker *sharedInstance = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedInstance = [[CurrentTestCaseTracker alloc] init];
        });
        return sharedInstance;
}

- (void)testCaseWillStart:(XCTestCase *)testCase {
    self.currentTestCase = testCase;
}

- (void)testCaseDidFinish:(XCTestCase *)testCase {
    self.currentTestCase = nil;
}

@end
