//
//  SBTree.c
//  TreeMap
//
//  Created by Jiao Liu on 7/27/16.
//  Copyright © 2016 ChangHong. All rights reserved.
//

#include "SBTree.h"

#pragma mark - Tree Maintain

void left_rotate(SBTree &node)
{
    SBTNode *temp = node->rchild;
    node->rchild = temp->lchild;
    temp->lchild = node;
    temp->size = node->size;
    node->size = (!node->lchild ? 0 : node->lchild->size) + (!node->rchild ? 0 : node->rchild->size) + 1;
    node = temp;
}

void right_rotate(SBTree &node)
{
    SBTNode *temp = node->lchild;
    node->lchild = temp->rchild;
    temp->rchild = node;
    temp->size = node->size;
    node->size = (!node->lchild ? 0 : node->lchild->size) + (!node->rchild ? 0 : node->rchild->size) + 1;
    node = temp;
}

void SBT_Maintain(SBTree &node,bool flag)
{
    if(!node)
    {
        return;
    }
    if (!flag) {
        if (node->lchild && node->lchild->lchild && (!node->rchild || node->lchild->lchild->size > node->rchild->size)) { // LL
            right_rotate(node);
        }
        else if (node->lchild && node->lchild->rchild && (!node->rchild || node->lchild->rchild->size > node->rchild->size)) {// LR
            left_rotate(node->lchild);
            right_rotate(node);
        }
        else
        {
            return;
        }
    }
    else
    {
        if (node->rchild && node->rchild->rchild && (!node->lchild || node->rchild->rchild->size > node->lchild->size)) { // RR
            left_rotate(node);
        }
        else if (node->rchild && node->rchild->lchild && (!node->lchild || node->rchild->lchild->size > node->lchild->size)) {// RL
            right_rotate(node->rchild);
            left_rotate(node);
        }
        else
        {
            return;
        }

    }
    
    SBT_Maintain(node->lchild,0);
    SBT_Maintain(node->rchild,1);
    SBT_Maintain(node,0);
    SBT_Maintain(node,1);
}

#pragma mark - Tree Methods

SBTNode *SBT_Search(SBTree node, string key)
{
    if (!node || node->key == key) {
        return node;
    }
    else if (key < node->key)
    {
        return SBT_Search(node->lchild, key);
    }
    else
    {
        return SBT_Search(node->rchild, key);
    }
}

SBTree SBT_Insert(SBTree &root, SBTNode *node)
{
    if (!root) {
        root = node;
    }
    else if (node->key == root->key)
    {
        root->value = node->value;
    }
    else
    {
        root->size++;
        SBT_Insert(node->key < root->key ? root->lchild : root->rchild, node);
        SBT_Maintain(root, node->key > root->key);
    }
    return root;
}

/*search key before using remove*/
void SBT_Delete(SBTNode *father, SBTree root, string key, bool flag)
{
    if (!root) {
        return;
    }
    
    root->size--;
    if (root->key == key) {
        SBTNode *tmp = root;
        if (root->rchild) {
            SBTNode *succ = root->rchild;
            succ->size--;
            bool hasChild = false;
            if (succ->lchild) {
                hasChild = true;
                tmp = succ;
                succ = succ->lchild;
                succ->size--;
            }
            while (succ->lchild) {
                tmp = succ;
                succ = succ->lchild;
                succ->size--;
            }
            root->key = succ->key;
            root->value = succ->value;
            if (!hasChild) {
                tmp->rchild = NULL;
            }
            else
            {
                tmp->lchild = NULL;
            }
            delete succ;
        }
        else if (root->lchild)
        {
            SBTNode *pred = root->lchild;
            pred->size--;
            bool hasChild = false;
            if (pred->rchild) {
                hasChild = true;
                tmp = pred;
                pred = pred->rchild;
                pred->size--;
            }
            while (pred->rchild) {
                tmp = pred;
                pred = pred->rchild;
                pred->size--;
            }
            root->key = pred->key;
            root->value = pred->value;
            if (!hasChild) {
                tmp->lchild = NULL;
            }
            else
            {
                tmp->rchild = NULL;
            }
            delete pred;
        }
        else
        {
            if (flag) {
                father->rchild = NULL;
            }
            else
            {
                father->lchild = NULL;
            }
            delete root;
        }
    }
    else if (root->key > key)
    {
        SBT_Delete(root, root->lchild, key, false);
    }
    else
    {
        SBT_Delete(root, root->rchild, key, true);
    }
}

SBTNode *SBT_Pred(SBTree node, string key)
{
    if (!node) {
        return NULL;
    }
    if (key <= node->key) {
        return SBT_Pred(node->lchild, key);
    }
    else
    {
        SBTNode *pred = SBT_Pred(node->rchild, key);
        return (!pred ? node : pred);
    }
}

SBTNode *SBT_Succ(SBTree node,string key)
{
    if (!node) {
        return NULL;
    }
    if (key >= node->key) {
        return SBT_Succ(node->rchild, key);
    }
    else
    {
        SBTNode *succ = SBT_Succ(node->lchild, key);
        return (!succ ? node : succ);
    }
}

SBTNode *SBT_Select(SBTree root, unsigned long i)
{
    if (!root || i > root->size) {
        return NULL;
    }
    unsigned long rank = (!root->lchild ? 0 : root->lchild->size) + 1;
    if (i == rank) {
        return root;
    }
    else if (i < rank)
    {
        return SBT_Select(root->lchild, i);
        
    }
    else
    {
        return SBT_Select(root->rchild, i-rank);
    }
}

unsigned long SBT_Rank(SBTree root, string key)
{
    if (!root) {
        return 0;
    }
    if (root->key == key) {
        return (!root->lchild ? 0 : root->lchild->size) + 1;
    }
    else if (key < root->key)
    {
        return SBT_Rank(root->lchild, key);
    }
    else
    {
        unsigned long rank = SBT_Rank(root->rchild,key);
        return rank == 0 ? 0 : rank + (!root->lchild ? 0 : root->lchild->size) + 1;
    }
}











