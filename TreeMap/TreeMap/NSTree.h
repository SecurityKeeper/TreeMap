//
//  NSTree.h
//  TreeMap
//
//  Created by Jiao Liu on 7/21/16.
//  Copyright © 2016 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSTreeNode.h>

@interface NSTree<KeyType, ObjectType> : NSObject

- (void)insertValue:(ObjectType)value forKey:(KeyType)key;
- (bool)find:(KeyType)key;
- (bool)remove:(KeyType)key;
- (NSTreeNode *)select:(long)rank;
- (ObjectType)valueForKey:(KeyType)key;

@end
