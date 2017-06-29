//
//  Elements.m
//  NMSimpleiOSApp
//
//  Created by idolplay-macpro on 2017/6/29.
//  Copyright © 2017年 namunaka. All rights reserved.
//

#import "Elements.h"
#import "PRPDebug.h"

@implementation Elements



#pragma mark -
#pragma mark - KVC
- (void)setValue:(id)value forKey:(NSString *)key {
  [super setValue:value forKey:key];
}

- (NSString *)description {
  return descriptionForDebug(self);
}

@end
