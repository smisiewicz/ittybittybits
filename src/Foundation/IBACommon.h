//
//  IBACommon.h
//  IttyBittyBits
//
//  Created by Oliver Jones on 4/05/11.
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

/*!
 \brief     Release and nil the passed variable.
 \param     x   The instance to release.
 */
#define IBA_RELEASE(x) \
    [(x) release]; (x) = nil

/*! 
 \def       IBA_FORMAT_FUNCTION
 \brief     An alias for NS_FORMAT_FUNCTION
 */

/*!
 \def       IBA_FORMAT_ARGUMENT
 \brief     An alias for NS_FORMAT_ARGUMENT
*/

// Perhaps one day this macro will actually do something in Clang.

#ifdef NS_FORMAT_FUNCTION
#define IBA_FORMAT_FUNCTION(F, A) NS_FORMAT_FUNCTION(F, A)
#else
#define IBA_FORMAT_FUNCTION(F, A)
#endif

#ifdef NS_FORMAT_ARGUMENT
#define IBA_FORMAT_ARGUMENT(F, A) NS_FORMAT_ARGUMENT(F)
#else
#define IBA_FORMAT_ARGUMENT(F, A)
#endif

// Give ourselves a consistent way of doing externs that links up nicely
// when mixing objc and objc++
#ifndef IBA_EXTERN
    #ifdef __cplusplus
        #define IBA_EXTERN extern "C"
        #define IBA_EXTERN_C_BEGIN extern "C" {
        #define IBA_EXTERN_C_END }
    #else
        #define IBA_EXTERN extern
        #define IBA_EXTERN_C_BEGIN
        #define IBA_EXTERN_C_END
    #endif
#endif