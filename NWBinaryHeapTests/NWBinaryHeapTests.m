//
//  NWBinaryHeapTests.m
//  NWBinaryHeapTests
//
//  Created by Nathan Wood on 9/06/2014.
//  Copyright (c) 2014 Nathan Wood. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NWBinaryHeap.h"

@interface NWBinaryHeapTests : XCTestCase

@end

@implementation NWBinaryHeapTests

- (void)testBasicOperations
{
    NWBinaryHeap *heap = [[NWBinaryHeap alloc] init];
    
    XCTAssertTrue([heap isEmpty], @"New heap should be empty");
    
    [heap insertObject:@1 withKey:@1];
    
    XCTAssertFalse([heap isEmpty], @"Heap should not be empty after insertion");
    XCTAssertEqualObjects(@1, [heap examine], @"Top item should be 1");
    
    XCTAssertEqualObjects(@1, [heap extract], @"Extracted item should be 1");
    XCTAssertTrue([heap isEmpty], @"Heap after extraction should be empty");
}

- (void)testInsert
{
    NWBinaryHeap *heap = [[NWBinaryHeap alloc] init];
    
    [heap insertObject:@1 withKey:@1];
    [heap insertObject:@2 withKey:@2];
    [heap insertObject:@3 withKey:@3];
    
    XCTAssertEqualObjects(@3, [heap examine], @"Top item should be 3");
}

- (void)testInsertMinimum
{
    NWBinaryHeap *heap = [NWBinaryHeap minimumHeap];
    
    [heap insertObject:@1 withKey:@1];
    [heap insertObject:@2 withKey:@2];
    [heap insertObject:@3 withKey:@3];
    
    XCTAssertEqualObjects(@1, [heap examine], @"Top item should be 3");
}

- (void)testExtract
{
    NWBinaryHeap *heap = [[NWBinaryHeap alloc] init];
    
    [heap insertObject:@1 withKey:@1];
    [heap insertObject:@2 withKey:@2];
    [heap insertObject:@3 withKey:@3];
    
    XCTAssertEqualObjects(@3, [heap extract], @"Top item should be 3");
    XCTAssertEqualObjects(@2, [heap extract], @"Top item should be 3");
    XCTAssertEqualObjects(@1, [heap extract], @"Top item should be 3");
    XCTAssertEqualObjects(nil, [heap extract], @"Top item should be nil");
}

- (void)testExtractMinimum
{
    NWBinaryHeap *heap = [NWBinaryHeap minimumHeap];
    
    [heap insertObject:@3 withKey:@3];
    [heap insertObject:@2 withKey:@2];
    [heap insertObject:@1 withKey:@1];
    
    XCTAssertEqualObjects(@1, [heap extract], @"Top item should be 3");
    XCTAssertEqualObjects(@2, [heap extract], @"Top item should be 3");
    XCTAssertEqualObjects(@3, [heap extract], @"Top item should be 3");
    XCTAssertEqualObjects(nil, [heap extract], @"Top item should be nil");
}

@end
