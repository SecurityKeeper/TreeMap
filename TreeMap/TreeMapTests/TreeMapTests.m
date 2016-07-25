//
//  TreeMapTests.m
//  TreeMapTests
//
//  Created by Jiao Liu on 7/21/16.
//  Copyright © 2016 ChangHong. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSTreeMap.h"

@interface TreeMapTests : XCTestCase

@end

@implementation TreeMapTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        NSTreeMap *map = [[NSTreeMap alloc] init];
        int i = 0;
        while (i < 1e7) {
            [map setValue:@"1" forKey:[NSNumber numberWithInt:i]];
            NSLog(@"%@",[map valueForKey:@12]);
            i++;
            NSString *str1 = @"1";
            NSString *str2 = @"2";
//            if ([str1 compare:str2] == NSOrderedSame) {
////                NSLog(@"same");
//            }
//            else
//            {
                if ([str1 compare:str2] == NSOrderedAscending) {
//                    printf("st1 < str2\n");
                }
                else
                {
//                    NSLog(@"str2 > str1");
                }
//            }
        }
    }];
}

@end
