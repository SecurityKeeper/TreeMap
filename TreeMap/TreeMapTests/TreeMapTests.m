//
//  TreeMapTests.m
//  TreeMapTests
//
//  Created by Jiao Liu on 7/21/16.
//  Copyright © 2016 ChangHong. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSTreeMap.h"
#import "SBTree.h"
#import <string>
#import <map>

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
    NSTreeMap *tmap = [[NSTreeMap alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    SBTree tree = nil;
    map<string, int> mp;
    int i = 0;
    while (i < 20) {
        [tmap setValue:@1 forKey:[NSNumber numberWithInt:i]];
//        SBT_Insert(tree, new SBTNode(std::to_string(i),"d",valueTypeString));
//        [dic setObject:@"1" forKey:[NSString stringWithFormat:@"%d",i]];
//        mp.insert(make_pair(std::to_string(i), 2));
        i++;
    }
    
    NSLog(@"%lu",[tmap rankOfKey:@15]);
    
    [tmap removeValueForKey:@10];
    [tmap removeValueForKey:@13];
    NSLog(@"%@",[tmap valueForKey:@7]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        NSTreeMap *map = [[NSTreeMap alloc] init];
        SBTree tree = nil;
        int i = 0;
        while (i < 1e7) {
            [map setValue:@"1" forKey:[NSNumber numberWithInt:i]];
//            SBT_Insert(tree, new SBTNode(std::to_string(i),"d",valueTypeString));
            i++;
        }
    }];
}

@end
