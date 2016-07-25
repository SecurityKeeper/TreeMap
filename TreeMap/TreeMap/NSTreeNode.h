//
//  NSTreeNode.h
//  TreeMap
//
//  Created by Jiao Liu on 7/25/16.
//  Copyright © 2016 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTreeNode<KeyType, ObjectType> : NSObject

@property (nonatomic, copy)KeyType key;
@property (nonatomic, strong)ObjectType value;
@property (nonatomic, assign)unsigned long size;
@property (nonatomic, strong)NSTreeNode *lchild;
@property (nonatomic, strong)NSTreeNode *rchild;
@property (nonatomic, strong)NSTreeNode *father;

- (id)initWithValue:(ObjectType)value size:(unsigned long)size key:(KeyType)key father:(NSTreeNode *)father;
- (NSTreeNode *)insertAt:(NSTreeNode *)node value:(ObjectType)value forKey:(KeyType)key;
- (NSTreeNode *)search:(KeyType)key;
- (NSTreeNode *)predecessor;
- (NSTreeNode *)successor;
- (void)remove_node:(NSTreeNode *)delete_node;
- (bool)remove:(KeyType)key;
- (NSTreeNode *)select:(long)rank;

@end
