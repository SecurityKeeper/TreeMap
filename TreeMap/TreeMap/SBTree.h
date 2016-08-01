//
//  SBTree.h
//  TreeMap
//
//  Created by Jiao Liu on 7/27/16.
//  Copyright © 2016 ChangHong. All rights reserved.
//

#ifndef SBTree_h
#define SBTree_h

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string>
#include <regex>
#import <Foundation/Foundation.h>

#endif /* SBTree_h */

using namespace std;

typedef struct SBTNode {
    struct SBTNode *lchild, *rchild;
    string key;
    id value;
    unsigned long size;
    SBTNode(string _key, id _value)
    {
        lchild = rchild = NULL;
        size = 1;
        key = _key;
        value = _value;
    }
}SBTNode, *SBTree;

bool operator>(string &string1,string &string2);

bool operator<(string &string1,string &string2);

SBTNode *SBT_Search(SBTree node, string key);

SBTree SBT_Insert(SBTree &root, SBTNode *node);

SBTNode *SBT_Pred(SBTree node, string key);

SBTNode *SBT_Succ(SBTree node,string key);

SBTNode *SBT_Select(SBTree root, unsigned long i);

unsigned long SBT_Rank(SBTree root, string key);

void SBT_Delete(SBTNode *father, SBTree root, string key, bool flag);

