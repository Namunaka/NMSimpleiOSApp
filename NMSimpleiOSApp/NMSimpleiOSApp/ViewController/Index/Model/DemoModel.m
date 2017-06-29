//
//  DemoModel.m
//  NMSimpleiOSApp
//
//  Created by idolplay-macpro on 2017/6/29.
//  Copyright © 2017年 namunaka. All rights reserved.
//

#import "DemoModel.h"
#import "Elements.h"
#import "PRPDebug.h"

@implementation DemoModel
- (NSArray<Elements *> *)elements{
  if (_elements == nil) {
    _elements = [NSMutableArray array];
  }
  return _elements;
}

-(NSArray *)search_data{
  if (_search_data == nil) {
    _search_data = [NSMutableArray array];
  }
  return _search_data;
}


#pragma mark -
#pragma mark - KVC
- (void)setValue:(id)value forKey:(NSString *)key {
  if ([key isEqualToString:@"search_data"]){
    for (NSDictionary *dic in value) {
      [(NSMutableArray *)self.search_data addObject:dic];
    }
  }else if ([key isEqualToString:@"elements"]){
    for (NSDictionary *dic in value) {
      Elements *elements = [[Elements alloc] initWithDictionary:dic];
      [(NSMutableArray<Elements *> *)self.elements addObject:elements];
    }
  }else {
    [super setValue:value forKey:key];
  }
}

- (NSString *)description {
  return descriptionForDebug(self);
}


@end
