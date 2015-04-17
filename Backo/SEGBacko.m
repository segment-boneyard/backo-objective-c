// SEGBacko.m
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

#import "SEGBacko.h"

#define ARC4RANDOM_MAX      0x100000000

@implementation SEGBacko

+ (instancetype)createWithBuilder:(SEGBackoBuilderBlock)block; {
    return [[self alloc] initWithBuilder:[SEGBackoBuilder builderWithBlock:block]];
}

- (id)initWithBuilder:(SEGBackoBuilder *)builder; {
    self = [super init];

    if (self) {
        _base = builder.base;
        _factor = builder.factor;
        _jitter = builder.jitter;
        _cap = builder.cap;
    }

    return self;
}


- (long)min:(long)a and:(long)b; {
    return (a) < (b) ? (a) : (b);
}

- (long)max:(long)a and:(long)b; {
    return (a) > (b) ? (a) : (b);
}

- (long)backoff:(int)attempt; {
    long duration = _base * (long) pow(_factor, attempt);
    if (_jitter != 0) {
        double random = floor(((double) arc4random() / ARC4RANDOM_MAX) * 100.0f);

        int deviation = (int) floor(random * _jitter * duration);
        if ((((int) floor(random * 10)) & 1) == 0) {
            duration = duration - deviation;
        } else {
            duration = duration + deviation;
        }
    }
    if (duration < 0) {
        duration = LONG_MAX;
    }

    return [self min:[self max:duration and:_base] and:_cap];
}

@end
