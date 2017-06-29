//
//  DemoModel.h
//  NMSimpleiOSApp
//
//  Created by idolplay-macpro on 2017/6/29.
//  Copyright © 2017年 namunaka. All rights reserved.
//

#import "BaseModel.h"
@class Elements;

@interface DemoModel : BaseModel

@property (copy, nonatomic) NSArray *search_data;
@property (copy, nonatomic) NSString *date_time;
@property (copy, nonatomic) NSArray <Elements *> *elements;
@property (assign, nonatomic) NSInteger next_start;

@end
