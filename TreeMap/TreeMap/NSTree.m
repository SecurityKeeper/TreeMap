//
//  NSTree.m
//  TreeMap
//
//  Created by Jiao Liu on 7/21/16.
//  Copyright © 2016 ChangHong. All rights reserved.
//

#import "NSTree.h"

@implementation NSTree
{
@private
    NSTreeNode *root;
}

- (id)init
{
    self = [super init];
    if (self) {
        root = nil;
    }
    return self;
}

- (void)dealloc
{
    if (root != nil) {
        root = nil;
    }
}

#pragma mark - Tree Methods

- (void)insertValue:(id)value forKey:(id)key
{
    if (root == nil) {
        root = [[NSTreeNode alloc] initWithValue:value size:1 key:key father:nil];
    }
    else
    {
        root = [root insertAt:root value:value forKey:key];
    }
}

- (bool)find:(id)key
{
    if ([root search:key] == nil) {
        return false;
    }
    else
    {
        return true;
    }
}

- (bool)remove:(id)key
{
    return [root remove:key];
}

- (NSTreeNode *)select:(long)rank
{
    return [root select:rank];
}

- (id)valueForKey:(id)key
{
    NSTreeNode *node = [root search:key];
    if (node == nil) {
        return nil;
    }
    else
    {
        return node.value;
    }
}

@end
