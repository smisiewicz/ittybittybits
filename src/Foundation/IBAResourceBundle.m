//
//  IBAResourceBundle.m
//  IttyBittyBits
//
//  Created by Oliver Jones on 25/08/11.
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

#import "IBAResourceBundle.h"
#import "IBAResourceBundle+Internal.h"

#import "../Foundation/IBAFoundation.h"

@implementation IBAResourceBundle

+ (id)bundleNamed:(NSString *)name
{
    return [[[self alloc] initWithBundleName:name] autorelease];
}

IBA_SYNTHESIZE(bundle, cache, resources);

/*!
 \brief     Initialize the theme bundle with a bundle of the specified \a name.
 */
- (id)initWithBundleName:(NSString*)name
{
    if ((self = [super init])) 
    {
        IBA_RETAIN_PROPERTY(cache, [[[NSCache alloc] init] autorelease]);
        self.cache.name = [NSString stringWithFormat:@"Resource Bundle Cache: %@", name];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"bundle"];
        IBA_RETAIN_PROPERTY(bundle, [NSBundle bundleWithPath:path]);
        if (self.bundle == nil)
        {
            IBALogError(@"Unable to find bundle named '%@' (%@).", name, path);
        }
        
        NSString *resourcePlistPath = [self.bundle pathForResource:@"Resources" ofType:@"plist"];
        IBA_RETAIN_PROPERTY(resources, [NSDictionary dictionaryWithContentsOfFile:resourcePlistPath]);
        if (self.resources == nil)
        {
            IBALogError(@"Failed to load Resources.plist from bundle '%@'.", name);
        }
        
        if (self.bundle == nil || self.resources == nil)
        {
            IBA_RELEASE(self);
        }
    }
    
    return self;
}

/*
 Deallocates the memory occupied by the receiver.
 */
- (void)dealloc
{
    IBA_RELEASE_PROPERTY(bundle, 
                         cache,
                         resources);

    [super dealloc];
}

- (NSString *)resolveResourceName:(NSString *)name
{
    int count = 0;
    do {
        id object = [self.resources objectForKey:name];
        if (object && [object isKindOfClass:[NSString class]])
        {
            if ([object hasPrefix:@"$"])
            {
                name = [object substringFromIndex:1];
            }
            else
            {
                break;
            }
        }
    }
    while (++count < 100);
    
    if (count >= 100)
    {
        IBALogError(@"Broke out of possible resource redirection loop for resource named: %@", name);
    }
    
    return name;
}

- (BOOL)hasResourceNamed:(NSString *)name
{
    return [self.resources objectForKey:[self resolveResourceName:name]] != nil;
}

- (NSString *)stringNamed:(NSString *)name
{
    NSString *string = nil;
    name = [self resolveResourceName:name];
    if (name)
    {
        string = (NSString  *)[self.cache objectForKey:name];
        if (string == nil)
        {
            id resource = [self.resources valueForKey:name];
            if ([resource isKindOfClass:[NSString class]])
            {
                string = resource;
            }
            else
            {
                string = [resource description];
            }

            if (string)
            {
                [self.cache setObject:string forKey:name cost:[string lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]];
            }
        }
    }
    
    return string;
}

- (NSData *)dataNamed:(NSString *)name
{
    NSData *data = nil;
    name = [self resolveResourceName:name];
    if (name)
    {
        id resource = [self.resources objectForKey:name];
        if ([resource isKindOfClass:[NSData class]])
        {
            data = resource;
        }
        else if ([resource isKindOfClass:[NSString class]])
        {
            NSString *path = [self.bundle pathForResource:resource ofType:nil];
            if (path)
            {
                data = [NSData dataWithContentsOfMappedFile:path];
            }
            else
            {
                IBALogError(@"Unable to load NSData resource named '%@' from file: %@", name, path);
            }
        }
    }
    
    return data;
}

@end