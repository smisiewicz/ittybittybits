//
//  IBAEasing.m
//  IttyBittyBits
//
//  Created by Oliver Jones on 1/09/11.
//  Copyright 2011 Itty Bitty Apps Pty. Ltd. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  Portions Copyright © 2001 Robert Penner
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, 
//  are permitted provided that the following conditions are met:
// 
//   1. Redistributions of source code must retain the above copyright notice,
//      this list of conditions and the following disclaimer.
//   2. Redistributions in binary form must reproduce the above copyright notice, 
//      this list of conditions and the following disclaimer in the documentation 
//      and/or other materials provided with the distribution.
//   3. Neither the name of the author nor the names of contributors may be used 
//      to endorse or promote products derived from this software without specific 
//      prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

#import "IBAEasing.h"
#import "IBACommon.h"
#import "IBAMath.h"

#import <math.h>

/*!
 \brief     A linear easing/interpolation function.
 \param     time    The current elapsed time (should be in the range of [0.0, duration])
 \param     begin   The starting/beginning value.
 \param     change  The change in value for the \a duration (at end of duration the returned value should equal begin+change).
 \return    The interpolated value.
 */
CGFloat IBALinearEase(NSTimeInterval time, CGFloat begin, CGFloat change, NSTimeInterval duration)
{
    CGFloat timef = (CGFloat)time;
    CGFloat durationf = (CGFloat)duration;
    
    return (change * (timef/durationf)) + begin;
}

CGFloat IBACubicEaseIn (NSTimeInterval time, CGFloat begin, CGFloat change, NSTimeInterval duration)
{
    CGFloat timef = (CGFloat)time;
    CGFloat durationf = (CGFloat)duration;
    
    return (change * (timef /= durationf) * IBA_SQUARE(timef)) + begin;
}

CGFloat IBACubicEaseOut(NSTimeInterval time, CGFloat begin, CGFloat change, NSTimeInterval duration)
{
    CGFloat timef = (CGFloat)time;
    CGFloat durationf = (CGFloat)duration;
    
    return (change * ((timef = timef/durationf - 1.0f) * IBA_SQUARE(timef) + 1.0f) + begin);
}

CGFloat IBACubicEaseInOut(NSTimeInterval time, CGFloat begin, CGFloat change, NSTimeInterval duration)
{
    CGFloat timef = (CGFloat)time;
    CGFloat durationf = (CGFloat)duration;

    if ((timef /= durationf/2.0f) < 1.0f) 
    {
        return (change / 2.0f * IBA_CUBE(timef)) + begin;
    }
    
    return (CGFloat) ((change / 2.0f * ((time -= 2.0) * IBA_SQUARE(time) + 2.0)) + begin);
}

CGFloat IBAExpoEaseIn(NSTimeInterval time, CGFloat begin, CGFloat change, NSTimeInterval duration)
{
    CGFloat timef = (CGFloat)time;
    CGFloat durationf = (CGFloat)duration;
    
    return (timef == 0.0f) ? begin : change * powf(2.0f, 10.0f * (timef/durationf - 1.0f)) + begin;
}

CGFloat IBAExpoEaseOut(NSTimeInterval time, CGFloat begin, CGFloat change, NSTimeInterval duration)
{
    CGFloat timef = (CGFloat)time;
    CGFloat durationf = (CGFloat)duration;
    
    return (timef >= durationf) ? (begin + change) : (change * (-powf(2.0f, -10.0f * timef/durationf) + 1.0f) + begin);
}

CGFloat IBAExpoEaseInOut(NSTimeInterval time, CGFloat begin, CGFloat change, NSTimeInterval duration)
{
    CGFloat timef = (CGFloat)time;
    CGFloat durationf = (CGFloat)duration;
    
    if (timef == 0.0f) 
        return begin;
    
    if (timef >= durationf) 
        return begin + change;

    if ((timef /= (durationf/2.0f)) < 1.0f) 
        return (change/2.0f * powf(2.0f, 10.0f * (timef - 1.0f))) + begin;
    
    return (change/2.0f * (-powf(2.0f, -10.0f * --timef) + 2.0f)) + begin;
}

CGFloat IBASineEaseIn(NSTimeInterval time, CGFloat begin, CGFloat change, NSTimeInterval duration)
{
    CGFloat timef = (CGFloat)time;
    CGFloat durationf = (CGFloat)duration;

    return (-change * cosf((timef/durationf) * (IBA_PI/2.0f))) + change + begin;
}

CGFloat IBASineEaseOut(NSTimeInterval time, CGFloat begin, CGFloat change, NSTimeInterval duration)
{
    CGFloat timef = (CGFloat)time;
    CGFloat durationf = (CGFloat)duration;

    return (change * sinf((timef/durationf) * (IBA_PI/2.0f))) + begin;
}

CGFloat IBASineEaseInOut(NSTimeInterval time, CGFloat begin, CGFloat change, NSTimeInterval duration)
{
    CGFloat timef = (CGFloat)time;
    CGFloat durationf = (CGFloat)duration;

    return (-change/2.0f * (cosf(IBA_PI * (timef/durationf)) - 1.0f)) + begin;
}

CGFloat IBAQuartEaseIn(NSTimeInterval time, CGFloat begin, CGFloat change, NSTimeInterval duration)
{
    CGFloat timef = (CGFloat)time;
    CGFloat durationf = (CGFloat)duration;

    return (change * (timef /= durationf) * IBA_CUBE(timef)) + begin;
}

CGFloat IBAQuartEaseOut(NSTimeInterval time, CGFloat begin, CGFloat change, NSTimeInterval duration)
{
    CGFloat timef = (CGFloat)time;
    CGFloat durationf = (CGFloat)duration;

    return (-change * ((timef = timef/durationf - 1.0f) * IBA_CUBE(timef) - 1.0f)) + begin;
}

CGFloat IBAQuartEaseInOut(NSTimeInterval time, CGFloat begin, CGFloat change, NSTimeInterval duration)
{
    CGFloat timef = (CGFloat)time;
    CGFloat durationf = (CGFloat)duration;

    if ((timef /= durationf/2.0f) < 1.0f) 
        return (change/2.0f * IBA_QUARTIC(timef)) + begin;
    
    return (-change/2.0f * ((timef -= 2.0f) * IBA_CUBE(timef) - 2.0f)) + begin;
}

CGFloat IBAQuintEaseIn(NSTimeInterval time, CGFloat begin, CGFloat change, NSTimeInterval duration)
{
    CGFloat timef = (CGFloat)time;
    CGFloat durationf = (CGFloat)duration;

    return (change * (timef /= durationf) * IBA_QUARTIC(timef)) + begin;
}

CGFloat IBAQuintEaseOut(NSTimeInterval time, CGFloat begin, CGFloat change, NSTimeInterval duration)
{
    CGFloat timef = (CGFloat)time;
    CGFloat durationf = (CGFloat)duration;

    return (change * ((timef = (timef/durationf - 1.0f)) * IBA_QUARTIC(timef) + 1.0f)) + begin;
}

CGFloat IBAQuintEaseInOut(NSTimeInterval time, CGFloat begin, CGFloat change, NSTimeInterval duration)
{
    CGFloat timef = (CGFloat)time;
    CGFloat durationf = (CGFloat)duration;

    if ((timef /= (durationf/2.0f)) < 1.0f) 
        return (change/2.0f * IBA_QUARTIC(timef) * timef) + begin;
    
    return (change/2.0f * ((timef -= 2.0f) * IBA_QUARTIC(timef) + 2.0f)) + begin;
}

