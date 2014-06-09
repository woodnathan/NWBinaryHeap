//
//  NWBinaryHeap.h
//  BinaryHeap
//
//  Created by Nathan Wood on 8/06/2014.
//  Copyright (c) 2014 Nathan Wood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWBinaryHeap : NSObject

+ (instancetype)minimumHeap;

- (instancetype)init;

@property (nonatomic, readonly, getter = isEmpty) BOOL empty;

- (void)insertObject:(id)object withKey:(id)key;
- (id)examine;
- (id)extract;

@end
