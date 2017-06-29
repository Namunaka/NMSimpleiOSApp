//
//  IndexViewModel.h
//  NMSimpleiOSApp
//
//  Created by idolplay-macpro on 2017/6/29.
//  Copyright © 2017年 namunaka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoModel.h"

@interface IndexViewModel : NSObject

@property (strong, readonly, nonatomic) DemoModel *model;

@property (strong , readonly , nonatomic) RACCommand *requestDemoListCommand;
@property (strong , readonly , nonatomic) RACCommand *cancelRequestDemoListCommand;

@end
