//
//  NSTreeMap.m
//  TreeMap
//
//  Created by Jiao Liu on 7/21/16.
//  Copyright © 2016 ChangHong. All rights reserved.
//

#import "NSTreeMap.h"
#import <NSTree.h>

@implementation NSTreeMap
{
    @private
    NSTree *tree;
}

- (id)init
{
    self = [super init];
    if (self) {
        tree = [[NSTree alloc] init];
    }
    return self;
}

- (void)dealloc
{
    if (tree != nil) {
        tree = nil;
    }
}

- (void)setValue:(id)value forKey:(id)key
{
    [tree insertValue:value forKey:key];
}

- (id)valueForKey:(id)key
{
    return [tree valueForKey:key];
}

@end
