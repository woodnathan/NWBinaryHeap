//
//  NWBinaryHeap.m
//  BinaryHeap
//
//  Created by Nathan Wood on 8/06/2014.
//  Copyright (c) 2014 Nathan Wood. All rights reserved.
//

#import "NWBinaryHeap.h"

@interface NWBHeapNode : NSObject

+ (instancetype)nodeWithKey:(id)key value:(id)value;
- (instancetype)initWithKey:(id)key value:(id)value;

@property (nonatomic, strong) id key;
@property (nonatomic, strong) id value;

@property (nonatomic, weak) NWBHeapNode *parent;
@property (nonatomic, strong) NWBHeapNode *leftChild;
@property (nonatomic, strong) NWBHeapNode *rightChild;

/**
 *  @return NSOrderedAscending if the key of otherNode is greater than the
 *          receiver’s, NSOrderedSame if they’re equal, and NSOrderedDescending
 *          if the key of otherNode is less than the receiver’s.
 */
- (NSComparisonResult)compare:(NWBHeapNode *)otherNode;

@end

static inline void NWBHeapNodeSwap(NWBHeapNode *a, NWBHeapNode *b)
{
    id tKey = a.key;
    id tValue = a.value;
    a.key = b.key;
    a.value = b.value;
    b.key = tKey;
    b.value = tValue;
}

@interface NWBinaryHeap ()

@property (nonatomic, strong) NWBHeapNode *rootNode;
@property (nonatomic, weak) NWBHeapNode *lastInsertedNode;

- (BOOL)node:(NWBHeapNode *)nodeA isGreaterThan:(NWBHeapNode *)nodeB;

@end

@interface NWMinimumBinaryHeap : NWBinaryHeap

@end

@implementation NWBinaryHeap

+ (instancetype)minimumHeap
{
    return [[NWMinimumBinaryHeap alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (BOOL)isEmpty
{
    return (self.rootNode == nil);
}

- (BOOL)node:(NWBHeapNode *)nodeA isGreaterThan:(NWBHeapNode *)nodeB
{
    return ([nodeA compare:nodeB] > NSOrderedSame); // NSOrderedDescending
}

#pragma mark

- (void)insertNode:(NWBHeapNode *)node
{
    NWBHeapNode *lastInsertedNode = self.lastInsertedNode;
    if (self.rootNode == nil)
    {
        self.rootNode = node;
    }
    else if (lastInsertedNode.parent == nil) // Only the root node exists
    {
        lastInsertedNode.leftChild = node;
    }
    else if (lastInsertedNode.parent.rightChild == nil) // Last inserted a left child
    {
        lastInsertedNode.parent.rightChild = node;
    }
    else // Last inserted a right child
    {
        NWBHeapNode *i = lastInsertedNode.parent;
        while (i.parent.leftChild != i && i.parent != nil)
            i = i.parent;
        NWBHeapNode *j = (i.parent != nil) ? i.parent.rightChild : i.leftChild;
        while (j.leftChild != nil)
            j = j.leftChild;
        j.leftChild = node;
    }
    self.lastInsertedNode = node;
}

- (void)insertObject:(id)object withKey:(id)key
{
    NWBHeapNode *node = [NWBHeapNode nodeWithKey:key value:object];
    [self insertNode:node];
    
    [self heapifyUp:node];
}

- (void)heapifyUp:(NWBHeapNode *)node
{
    while (node.parent != nil)
    {
        if ([self node:node isGreaterThan:node.parent])
        {
            NWBHeapNodeSwap(node, node.parent);
            node = node.parent;
        }
        else
        {
            break;
        }
    }
}

- (id)examine
{
    if ([self isEmpty])
        return nil;
    return self.rootNode.value;
}

- (id)extract
{
    if ([self isEmpty])
        return nil;
    NWBHeapNode *const prevRootNode = self.rootNode;
    NWBHeapNode *lastInsertedNode = self.lastInsertedNode;
    NWBHeapNode *rootNode = lastInsertedNode;
    
    if (lastInsertedNode.parent.leftChild == lastInsertedNode)
    {
        NWBHeapNode *i = lastInsertedNode.parent;
        while (i.parent.rightChild != i && i.parent != nil)
            i = i.parent;
        NWBHeapNode *j = (i.parent != nil) ? i.parent.leftChild : i.rightChild;
        while (j.rightChild != nil)
            j = j.rightChild;
        lastInsertedNode = j;
    }
    else if (lastInsertedNode.parent.rightChild == lastInsertedNode)
    {
        lastInsertedNode = lastInsertedNode.parent.leftChild;
    }
    else if (lastInsertedNode == prevRootNode)
    {
        rootNode = nil;
        lastInsertedNode = nil;
    }
    
    if (rootNode != nil) // Save objc_msgSend doing this a few times
    {
        rootNode.parent = nil;
        rootNode.leftChild = prevRootNode.leftChild;
        rootNode.rightChild = prevRootNode.rightChild;
    }
    
    self.rootNode = rootNode;
    self.lastInsertedNode = lastInsertedNode;
    
    [self heapifyDown:rootNode];
    
    return prevRootNode.value;
}

- (void)heapifyDown:(NWBHeapNode *)node
{
    NWBHeapNode *leftChild = node.leftChild;
    NWBHeapNode *rightChild = node.rightChild;
    while (leftChild != nil || rightChild != nil)
    {
        NWBHeapNode *largestChild = nil;
        if (leftChild != nil && rightChild != nil) // Both children exist
        {
            largestChild = ([self node:leftChild isGreaterThan:rightChild]) ? leftChild : rightChild;
        }
        else if (leftChild != nil)
        {
            largestChild = leftChild;
        }
        else if (rightChild != nil)
        {
            largestChild = rightChild;
        }
        
        if (largestChild == nil)
            break;
        
        if ([self node:largestChild isGreaterThan:node])
            NWBHeapNodeSwap(node, largestChild);
        
        node = largestChild;
        leftChild = node.leftChild;
        rightChild = node.rightChild;
    }
}

@end

@implementation NWBHeapNode

+ (instancetype)nodeWithKey:(id)key value:(id)value
{
    return [[self alloc] initWithKey:key value:value];
}

- (instancetype)initWithKey:(id)key value:(id)value
{
    self = [super init];
    if (self)
    {
        NSAssert([key respondsToSelector:@selector(compare:)], @"Key must implement -compare:");
        
        self.key = key;
        self.value = value;
    }
    return self;
}

- (NSComparisonResult)compare:(NWBHeapNode *)otherNode
{
    return [self.key compare:otherNode.key];
}

#pragma mark Accessors

- (void)setParent:(NWBHeapNode *)parent
{
    if (self->_parent != parent)
    {
        if (parent == nil)
        {
            if (self->_parent.leftChild == self)
                self->_parent.leftChild = nil;
            else if (self->_parent.rightChild == self)
                self->_parent.rightChild = nil;
        }
        self->_parent = parent;
    }
}

- (void)setLeftChild:(NWBHeapNode *)leftChild
{
    if (self->_leftChild != leftChild)
    {
        leftChild.parent = self;
        self->_leftChild = leftChild;
    }
}

- (void)setRightChild:(NWBHeapNode *)rightChild
{
    if (self->_rightChild != rightChild)
    {
        rightChild.parent = self;
        self->_rightChild = rightChild;
    }
}

@end

@implementation NWMinimumBinaryHeap

/**
 *  We mostly fake it here for the minimum heap
 */
- (BOOL)node:(NWBHeapNode *)nodeA isGreaterThan:(NWBHeapNode *)nodeB
{
    return ([nodeA compare:nodeB] < NSOrderedSame); // NSOrderedAscending
}

@end
