//
//  IBANavigationController.h
//  IttyBittyBits
//
//  Created by Oliver Jones on 18/10/11.
//  Copyright (c) 2011 Itty Bitty Apps Pty. Ltd. All rights reserved.
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

#import <UIKit/UIKit.h>
#import "IBAViewController.h"

@class IBANavigationController;

@protocol IBANavigationControllerDelegate <IBAViewControllerDelegate, UINavigationControllerDelegate>
@optional
- (void)navigationController:(IBANavigationController *)navigationController didPopViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)navigationController:(IBANavigationController *)navigationController willPushViewController:(UIViewController *)viewController animated:(BOOL)animated;
@end

@interface IBANavigationController : UINavigationController

@end
