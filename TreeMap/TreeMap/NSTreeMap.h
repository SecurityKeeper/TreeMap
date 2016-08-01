//
//  NSTreeMap.h
//  TreeMap
//
//  Created by Jiao Liu on 7/21/16.
//  Copyright © 2016 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTreeMap<KeyType, ObjectType> : NSObject

- (void)setValue:(ObjectType)value forKey:(KeyType <NSCopying>)key;
- (ObjectType)valueForKey:(KeyType)key;
- (id)valueOfRank:(unsigned long)rank;
- (unsigned long)rankOfKey:(KeyType)key;
- (void)removeValueForKey:(KeyType)key;
- (void)removeAll;

@end
