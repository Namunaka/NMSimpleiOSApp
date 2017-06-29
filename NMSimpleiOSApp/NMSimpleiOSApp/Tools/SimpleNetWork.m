//
//  SimpleNetWork.m
//  NMSimpleiOSApp
//
//  Created by idolplay-macpro on 2017/6/29.
//  Copyright © 2017年 namunaka. All rights reserved.
//

#import "SimpleNetWork.h"

@implementation SimpleNetWork

- (RACSignal *)signalForUrlString:(in NSString *)urlString
                       httpMethod:(in NSString *)httpMethod
                      httpHeaders:(in NSDictionary *)httpHeaders
                       httpParams:(in NSDictionary *)httpParams {
  return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    
    [self requestDomainBeanAndContentTypeUseNormalWithUrlString:urlString httpMethod:httpMethod httpHeaders:httpHeaders httpParams:httpParams progress:^(NSProgress * _Nonnull progress) {
      
    } success:^(NSURLSessionDataTask * _Nonnull tast, id _Nullable obj) {
      [subscriber sendNext:obj];
      [subscriber sendCompleted];
    } failure:^(NSURLSessionDataTask * _Nullable tast, NSError * _Nonnull error) {
      [subscriber sendError:error];
    }];
    
    //
    return [RACDisposable disposableWithBlock:^{
      //这里要处理网络cancel
    }];
  }];
}

- (void)requestDomainBeanAndContentTypeUseNormalWithUrlString:(in NSString *)urlString
                                                   httpMethod:(in NSString *)httpMethod
                                                  httpHeaders:(in NSDictionary *)httpHeaders
                                                   httpParams:(in NSDictionary *)httpParams
                                                     progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                                                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                                                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
  
  
  
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  //设置超时时间
  manager.requestSerializer.timeoutInterval = 100.0f;
  //
  manager.securityPolicy.allowInvalidCertificates = YES;
  // 设置异步返回的数据类型为 二进制
  //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  //
  [httpHeaders enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
  }];
  
  NSLog(@"\n\n\n-----------------> AFNetworking_HTTP_HEADER = \n%@\n\n\n", manager.requestSerializer.HTTPRequestHeaders);
  
  
  NSURLSessionTask *sessionTask = nil;
  
  
  if ([@"GET" isEqualToString:httpMethod]) {
    
    
    sessionTask = [manager GET:urlString
                    parameters:httpParams
                      progress:downloadProgress
                       success:success
                       failure:failure];
    
  } else if ([@"POST" isEqualToString:httpMethod]) {
    
    sessionTask = [manager POST:urlString
                     parameters:httpParams
                       progress:downloadProgress
                        success:success
                        failure:failure];
    
  } else if ([@"PUT" isEqualToString:httpMethod]) {
    
    sessionTask = [manager PUT:urlString
                    parameters:httpParams
                       success:success
                       failure:failure];
    
  } else {
    NSLog(@"上层传递了, 网络层不能识别的 HttpMethod.");
  }
  
}
@end
