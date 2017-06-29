//
//  Elements.h
//  NMSimpleiOSApp
//
//  Created by idolplay-macpro on 2017/6/29.
//  Copyright © 2017年 namunaka. All rights reserved.
//

#import "BaseModel.h"

@interface Elements : BaseModel

@property (assign, nonatomic) long long type;
@property (copy, nonatomic) NSArray *data;
@property (copy, nonatomic) NSString *desc;

@end
