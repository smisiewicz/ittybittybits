//
//  IBACoreLocation.h
//  IttyBittyBits
//
//  Created by Oliver Jones on 20/05/11.
//  Copyright 2011 Itty Bitty Apps Pty. Ltd. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not
//  use this file except in compliance with the License.  You may obtain a copy
//  of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
//  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
//  License for the specific language governing permissions and limitations under
//  the License.
//

#import <CoreLocation/CoreLocation.h>

/*!
 \brief     Compares to CLLocationCoordinate2D structs for equality.
 */
#define IBACLLocationCoordinate2DAreEqual(x, y) (((x).latitude - (y).latitude) == 0.0 && ((x).longitude - (y).longitude) == 0.0)