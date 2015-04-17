// SEGBackoTests.h
//
// Copyright (c) 2015 Segment, Inc.
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

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "SEGBacko.h"

@interface SEGBackoTests : XCTestCase

@end

@implementation SEGBackoTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testBackoff {
    SEGBacko *backo = [SEGBacko createWithBuilder:^(SEGBackoBuilder *configuration) {
        configuration.base = 100;
        configuration.factor = 2;
        configuration.jitter = 0;
        configuration.cap = 800;
    }];

    XCTAssertEqual([backo backoff:0], 100);
    XCTAssertEqual([backo backoff:1], 200);
    XCTAssertEqual([backo backoff:2], 400);
    XCTAssertEqual([backo backoff:3], 800);
    XCTAssertEqual([backo backoff:4], 800);

    XCTAssertEqual([backo backoff:0], 100);
    XCTAssertEqual([backo backoff:1], 200);
}

@end
