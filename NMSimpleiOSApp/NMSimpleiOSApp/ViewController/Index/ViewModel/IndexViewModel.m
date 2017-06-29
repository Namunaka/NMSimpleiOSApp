//
//  IndexViewModel.m
//  NMSimpleiOSApp
//
//  Created by idolplay-macpro on 2017/6/29.
//  Copyright © 2017年 namunaka. All rights reserved.
//

#import "IndexViewModel.h"
#import "SimpleNetWork.h"

@interface IndexViewModel ()

@property (strong, readwrite, nonatomic) RACCommand *requestDemoListCommand;
@property (strong, readwrite, nonatomic) RACCommand *cancelRequestDemoListCommand;

@property (strong, readwrite, nonatomic) DemoModel *model;

@end

@implementation IndexViewModel



- (instancetype)init {
  if (self = [super init]) {
    
    [self initialize];
  }
  return self;
}


- (void)initialize {
  
  @weakify(self)

  self.cancelRequestDemoListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    return [RACSignal empty];
  }];
  
  self.requestDemoListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *input) {
    @strongify(self)
    
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
      @strongify(self)
      
      SimpleNetWork *netWork = [[SimpleNetWork alloc] init];
      
      [[netWork signalForUrlString:@"http://api.breadtrip.com/v2/index/" httpMethod:@"GET" httpHeaders:nil httpParams:nil]
      subscribeNext:^(id obj) {
        [subscriber sendNext:obj];
        [subscriber sendCompleted];
      }error:^(NSError *error) {
        [subscriber sendError:error];
      }];


      return [RACDisposable disposableWithBlock:^{
        
      }] ;
    }] materialize] takeUntil:self.cancelRequestDemoListCommand.executionSignals];;
    
  }];
  
  [self.requestDemoListCommand.executionSignals
   subscribeNext:^(RACSignal *execution) {
     [[execution dematerialize]
      subscribeNext:^(id obj) {
        @strongify(self)
        //这里进行模型的2次处理把生数据进行转化,理论上网络引擎层应该自动过滤服务器返回的错误数据并给予提示
        if ([obj isKindOfClass:[NSDictionary class]]) {
          NSDictionary *responseDic = ((NSDictionary *)obj)[@"data"];
          self.model = [[DemoModel alloc] initWithDictionary:responseDic];
        }

      } error:^(NSError *error) {
        
        
      }];
   }];
  
}
@end
