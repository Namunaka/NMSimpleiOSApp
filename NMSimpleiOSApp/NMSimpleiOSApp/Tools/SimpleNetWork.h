//
//  SimpleNetWork.h
//  NMSimpleiOSApp
//
//  Created by idolplay-macpro on 2017/6/29.
//  Copyright © 2017年 namunaka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface SimpleNetWork : NSObject


- (RACSignal *)signalForUrlString:(in NSString *)urlString
                       httpMethod:(in NSString *)httpMethod
                      httpHeaders:(in NSDictionary *)httpHeaders
                       httpParams:(in NSDictionary *)httpParams;
@end
