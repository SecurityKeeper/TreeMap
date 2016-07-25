//
//  NSTreeNode.m
//  TreeMap
//
//  Created by Jiao Liu on 7/25/16.
//  Copyright © 2016 ChangHong. All rights reserved.
//

#import "NSTreeNode.h"

@implementation NSTreeNode

- (id)init
{
    self = [super init];
    if (self) {
        _key = nil;
        _value = nil;
        _size = 0;
        _lchild = nil;
        _rchild = nil;
        _father = nil;
    }
    return self;
}

- (id)initWithValue:(id)value size:(unsigned long)size key:(id)key father:(NSTreeNode *)father
{
    self = [super init];
    if (self) {
        _key = key;
        _value = value;
        _size = size;
        _lchild = nil;
        _rchild = nil;
        _father = father;
    }
    return self;
}

- (void)dealloc
{
    if (_lchild != nil) {
        _lchild = nil;
    }
    if (_rchild != nil) {
        _rchild = nil;
    }
    if (_father != nil) {
        _father = nil;
    }
}

#pragma mark - Tree Maintain

- (NSTreeNode *)left_rotate:(NSTreeNode *)node
{
    NSTreeNode *temp = node.rchild;
    node.rchild = temp.lchild;
    temp.lchild.father = node;
    temp.lchild = node;
    temp.father = node.father;
    node.father = temp;
    temp.size = node.size;
    node.size = node.lchild.size + node.rchild.size + 1;
    return temp;
}

- (NSTreeNode *)right_rotate:(NSTreeNode *)node
{
    NSTreeNode *temp = node.lchild;
    node.lchild = temp.rchild;
    temp.rchild.father = node;
    temp.rchild = node;
    temp.father = node.father;
    node.father = temp;
    temp.size = node.size;
    node.size = node.lchild.size + node.rchild.size + 1;
    return temp;
}

- (NSTreeNode *)maintain:(NSTreeNode *)node withFlag:(bool)flag
{
    if (flag == false) {
        if (node.lchild.lchild.size > node.rchild.size) {
            node = [self right_rotate:node];
        } else if (node.lchild.rchild.size > node.rchild.size) {
            node.lchild = [self left_rotate:node.lchild];
            node = [self right_rotate:node];
        } else {
            return node;
        }
    } else {
        if (node.rchild.rchild.size > node.lchild.size) {
            node = [self left_rotate:node];
        } else if (node.rchild.lchild.size > node.lchild.size) {
            node.rchild = [self right_rotate:node.rchild];
            node = [self left_rotate:node];
        } else {
            return node;
        }
    }
    node.lchild = [self maintain:node.lchild withFlag:false];
    node.rchild = [self maintain:node.rchild withFlag:true];
    node = [self maintain:node withFlag:false];
    node = [self maintain:node withFlag:true];
    return node;
}

#pragma mark - Node Methods

- (NSTreeNode *)insertAt:(NSTreeNode *)node value:(id)value forKey:(id)key
{
    if ([node.key compare:key] == NSOrderedSame) {
        node.value = value;
        return node;
    }
    else
    {
        node.size += 1;
        if ([node.key compare:key] == NSOrderedAscending) {
            if (node.rchild == nil) {
                node.rchild = [[NSTreeNode alloc] initWithValue:value size:1 key:key father:node];
            }
            else
            {
                node.rchild = [self insertAt:node.rchild value:value forKey:key];
            }
        }
        else
        {
            if (node.lchild == nil) {
                node.lchild = [[NSTreeNode alloc] initWithValue:value size:1 key:key father:node];
            }
            else
            {
                node.lchild = [self insertAt:node.lchild value:value forKey:key];
            }
        }
    }
    return [self maintain:node withFlag:[node.key compare:key] == NSOrderedAscending];
}

- (NSTreeNode *)search:(id)key
{
    if ([_key compare:key] == NSOrderedSame) {
        return self;
    }
    else if ([_key compare:key] == NSOrderedAscending)
    {
        if (_rchild == nil) {
            return nil;
        }
        else
        {
            return [_rchild search:key];
        }
    }
    else
    {
        if (_lchild == nil) {
            return nil;
        }
        else
        {
            return [_lchild search:key];
        }
    }
}

- (NSTreeNode *)predecessor
{
    NSTreeNode *temp = _lchild;
    while (temp != nil && temp.rchild != nil) {
        temp = temp.rchild;
    }
    return temp;
}

- (NSTreeNode *)successor
{
    NSTreeNode *temp = _rchild;
    while (temp != nil && temp.lchild != nil) {
        temp = temp.lchild;
    }
    return temp;
}

- (void)remove_node:(NSTreeNode *)delete_node
{
    NSTreeNode *temp = nil;
    if (delete_node.lchild != nil) {
        temp = delete_node.lchild;
        temp.father = delete_node.father;
        delete_node.lchild = nil;
    }
    
    if (delete_node.rchild != nil) {
        temp = delete_node.rchild;
        temp.father = delete_node.father;
        delete_node.rchild = nil;
    }
    
    if (delete_node.father.lchild == delete_node) {
        delete_node.father.lchild = temp;
    }
    else
    {
        delete_node.father.rchild = temp;
    }
    
    temp = delete_node;
    while (temp != nil) {
        temp.size -= 1;
        temp = temp.father;
    }
    delete_node = nil;
}

- (bool)remove:(id)key
{
    NSTreeNode *delete_node, *current_node;
    current_node = [self search:key];
    if (current_node == nil) {
        return false;
    }
    _size--;
    if (current_node.lchild != nil) {
        delete_node = [current_node predecessor];
    }
    else if (current_node.rchild != nil)
    {
        delete_node = [current_node successor];
    }
    else
    {
        delete_node = current_node;
    }
    current_node.key = delete_node.key;
    current_node.value = delete_node.value;
    [self remove_node:delete_node];
    return true;
}

- (NSTreeNode *)select:(long)rank
{
    long k = _lchild.size + 1;
    if (rank == k) {
        return self;
    }
    else if (rank  < k)
    {
        return [_lchild select:rank];
    }
    else
    {
        return [_rchild select:rank - k];
    }
}

@end
