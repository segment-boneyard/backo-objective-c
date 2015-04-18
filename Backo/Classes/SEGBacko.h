// SEGBacko.h
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

#import <Foundation/Foundation.h>
#import "SEGBackoBuilder.h"

//! Project version number for Backo.
FOUNDATION_EXPORT double BackoVersionNumber;

//! Project version string for Backo.
FOUNDATION_EXPORT const unsigned char BackoVersionString[];

/**
* Backo implements the "full jitter" backoff policy as described in this article <a
* href="http://www.awsarchitectureblog.com/2015/03/backoff.html">Exponential Backoff And
* Jitter </a>.
* <p>
* Create your own instance with the SEGBackoBuilder class. Instances of backoff are stateless, so
* you can create them once and share them across threads throughout your app.
* <p>
* @see SEGBackoBuilder clas
*
* @see <a href="http://www.awsarchitectureblog.com/2015/03/backoff.html">Exponential Backoff And
* Jitter
* </a>
*/
@interface SEGBacko : NSObject

@property(readonly) long base;
@property(readonly) int factor;
@property(readonly) double jitter;
@property(readonly) long cap;

+ (instancetype)createWithBuilder:(SEGBackoBuilderBlock)block;

+ (instancetype)create;

/** Return the duration (in milliseconds) for which you should backoff. */
- (long)backoff:(int)attempt;

/** Sleep on the current thread for the duration returned by backoff. */
- (void)sleep:(int)attempt;

@end
