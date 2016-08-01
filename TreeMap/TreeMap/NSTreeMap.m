//
//  NSTreeMap.m
//  TreeMap
//
//  Created by Jiao Liu on 7/21/16.
//  Copyright © 2016 ChangHong. All rights reserved.
//

#import "NSTreeMap.h"
#import <NSTree.h>
#import <SBTree.h>

@implementation NSTreeMap
{
    @private
//    NSTree *tree;
    SBTree tree;
}

- (id)init
{
    self = [super init];
    if (self) {
//        tree = [[NSTree alloc] init];
        tree = nil;
    }
    return self;
}

- (void)dealloc
{
    if (tree != nil) {
//        tree = nil;
        [self deleteTree:tree];
    }
}

- (void)deleteTree:(SBTree)node
{
    if (node != NULL) {
        [self deleteTree:node->lchild];
        [self deleteTree:node->rchild];
        node->lchild = NULL;
        node->rchild = NULL;
        delete node;
    }
}

- (void)setValue:(id)value forKey:(id)key
{
//    [tree insertValue:value forKey:key];
    const char *keyC;
    if ([key isKindOfClass:[NSNumber class]]) {
        keyC = [[[key stringValue] stringByAppendingString:@"{__NOSTRING}"] UTF8String];
    }
    else if ([key isKindOfClass:[NSString class]])
    {
        keyC = [key UTF8String];
    }
    else if ([key isKindOfClass:[NSDictionary class]] || [key isKindOfClass:[NSArray class]])
    {
        keyC = [[[NSString stringWithFormat:@"%@",key] stringByAppendingString:@"{__NOSTRING}"] UTF8String];
    }
    SBTNode *node = new SBTNode(keyC,value);
    SBT_Insert(tree, node);
}

- (id)valueForKey:(id)key
{
    const char *keyC;
    if ([key isKindOfClass:[NSNumber class]]) {
        keyC = [[[key stringValue] stringByAppendingString:@"{__NOSTRING}"] UTF8String];
    }
    else if ([key isKindOfClass:[NSString class]])
    {
        keyC = [key UTF8String];
    }
    else if ([key isKindOfClass:[NSDictionary class]] || [key isKindOfClass:[NSArray class]])
    {
        keyC = [[[NSString stringWithFormat:@"%@",key] stringByAppendingString:@"{__NOSTRING}"] UTF8String];
    }
    SBTNode *node = SBT_Search(tree, keyC);
    if (node != NULL) {
        return node->value;
    }
    else
    {
        return nil;
    }
//    return [tree valueForKey:key];
}

- (id)valueOfRank:(unsigned long)rank
{
    SBTNode *node = SBT_Select(tree, rank);
    if (node != NULL) {
        return node->value;
    }
    else
    {
        return nil;
    }
}

- (unsigned long)rankOfKey:(id)key
{
    const char *keyC;
    if ([key isKindOfClass:[NSNumber class]]) {
        keyC = [[[key stringValue] stringByAppendingString:@"{__NOSTRING}"] UTF8String];
    }
    else if ([key isKindOfClass:[NSString class]])
    {
        keyC = [key UTF8String];
    }
    else if ([key isKindOfClass:[NSDictionary class]] || [key isKindOfClass:[NSArray class]])
    {
        keyC = [[[NSString stringWithFormat:@"%@",key] stringByAppendingString:@"{__NOSTRING}"] UTF8String];
    }
    return SBT_Rank(tree, keyC);
}

- (void)removeValueForKey:(id)key
{
    const char *keyC;
    if ([key isKindOfClass:[NSNumber class]]) {
        keyC = [[[key stringValue] stringByAppendingString:@"{__NOSTRING}"] UTF8String];
    }
    else if ([key isKindOfClass:[NSString class]])
    {
        keyC = [key UTF8String];
    }
    else if ([key isKindOfClass:[NSDictionary class]] || [key isKindOfClass:[NSArray class]])
    {
        keyC = [[[NSString stringWithFormat:@"%@",key] stringByAppendingString:@"{__NOSTRING}"] UTF8String];
    }
    if (SBT_Search(tree, keyC)) {
        SBT_Delete(NULL, tree, keyC, false);
    }
}

@end
