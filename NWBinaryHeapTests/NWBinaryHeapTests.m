//
//  NWBinaryHeapTests.m
//
//  Copyright (c) 2014 Nathan Wood ( http://www.woodnathan.com/ )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <XCTest/XCTest.h>
#import "NWBinaryHeap.h"

@interface NWBinaryHeapTests : XCTestCase

@end

@implementation NWBinaryHeapTests

- (void)testBasicOperations
{
    NWBinaryHeap *heap = [[NWBinaryHeap alloc] init];
    
    XCTAssertTrue([heap isEmpty], @"New heap should be empty");
    
    [heap addObject:@1];
    
    XCTAssertFalse([heap isEmpty], @"Heap should not be empty after insertion");
    XCTAssertEqualObjects(@1, [heap topObject], @"Top item should be 1");
    
    XCTAssertEqualObjects(@1, [heap removeTopObject], @"Extracted item should be 1");
    XCTAssertTrue([heap isEmpty], @"Heap after extraction should be empty");
}

- (void)testInsert
{
    NWBinaryHeap *heap = [[NWBinaryHeap alloc] init];
    
    [heap addObject:@1];
    [heap addObject:@2];
    [heap addObject:@3];
    
    XCTAssertEqualObjects(@3, [heap topObject], @"Top item should be 3");
}

- (void)testInsertMinimum
{
    NWBinaryHeap *heap = [[NWBinaryHeap alloc] initWithType:NWBinaryHeapMinimum];
    
    [heap addObject:@1];
    [heap addObject:@2];
    [heap addObject:@3];
    
    XCTAssertEqualObjects(@1, [heap topObject], @"Top item should be 3");
}

- (void)testExtract
{
    NWBinaryHeap *heap = [[NWBinaryHeap alloc] init];
    
    [heap addObject:@1];
    [heap addObject:@2];
    [heap addObject:@3];
    
    XCTAssertEqualObjects(@3, [heap removeTopObject], @"Top item should be 3");
    XCTAssertEqualObjects(@2, [heap removeTopObject], @"Top item should be 3");
    XCTAssertEqualObjects(@1, [heap removeTopObject], @"Top item should be 3");
    XCTAssertEqualObjects(nil, [heap removeTopObject], @"Top item should be nil");
}

- (void)testExtractMinimum
{
    NWBinaryHeap *heap = [[NWBinaryHeap alloc] initWithType:NWBinaryHeapMinimum];
    
    [heap addObject:@3];
    [heap addObject:@2];
    [heap addObject:@1];
    
    XCTAssertEqualObjects(@1, [heap removeTopObject], @"Top item should be 3");
    XCTAssertEqualObjects(@2, [heap removeTopObject], @"Top item should be 3");
    XCTAssertEqualObjects(@3, [heap removeTopObject], @"Top item should be 3");
    XCTAssertEqualObjects(nil, [heap removeTopObject], @"Top item should be nil");
}

- (void)testComparator
{
    NWBinaryHeap *heap = [[NWBinaryHeap alloc] initWithType:NWBinaryHeapMaximum
                                                 comparator:^NSComparisonResult(id obj1, id obj2) {
                                                     return [obj1 caseInsensitiveCompare:obj2];
                                                 }];
    
    [heap addObject:@"B"];
    [heap addObject:@"b"];
    [heap addObject:@"A"];
    [heap addObject:@"a"];
    
    XCTAssertEqualObjects(@"B", [heap removeTopObject], @"Top item should be B");
    XCTAssertEqualObjects(@"b", [heap removeTopObject], @"Top item should be b");
    XCTAssertEqualObjects(@"A", [heap removeTopObject], @"Top item should be A");
    XCTAssertEqualObjects(@"a", [heap removeTopObject], @"Top item should be a");
    XCTAssertEqualObjects(nil, [heap removeTopObject], @"Top item should be nil");
}

- (void)testComparatorMinimum
{
    NWBinaryHeap *heap = [[NWBinaryHeap alloc] initWithType:NWBinaryHeapMinimum
                                                 comparator:^NSComparisonResult(id obj1, id obj2) {
                                                     return [obj1 caseInsensitiveCompare:obj2];
                                                 }];
    
    [heap addObject:@"A"];
    [heap addObject:@"a"];
    [heap addObject:@"B"];
    [heap addObject:@"b"];
    
    XCTAssertEqualObjects(@"A", [heap removeTopObject], @"Top item should be A");
    XCTAssertEqualObjects(@"a", [heap removeTopObject], @"Top item should be a");
    XCTAssertEqualObjects(@"B", [heap removeTopObject], @"Top item should be B");
    XCTAssertEqualObjects(@"b", [heap removeTopObject], @"Top item should be b");
    XCTAssertEqualObjects(nil, [heap removeTopObject], @"Top item should be nil");
}

@end
