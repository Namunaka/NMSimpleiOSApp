//
//  IndexViewController.m
//  NMSimpleiOSApp
//
//  Created by idolplay-macpro on 2017/6/29.
//  Copyright © 2017年 namunaka. All rights reserved.
//

#import "IndexViewController.h"
#import "AFNetworking.h"
#import "IndexViewModel.h"
#import "MBProgressHUD.h"

@interface IndexViewController ()

@property (strong, nonatomic) IndexViewModel *viewModel;
@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation IndexViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  @weakify(self)
  
  self.viewModel = [[IndexViewModel alloc] init];
  
  //判断是否正在执行
  [[self.viewModel.requestDemoListCommand.executing skip:1] subscribeNext:^(id x) {
    @strongify(self)
    if ([x boolValue]) {
      self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    } else {
      [self.hud hideAnimated:YES];
    }
  }];
  
  
  [self.viewModel.requestDemoListCommand.executionSignals
   subscribeNext:^(RACSignal *execution) {
     [[execution dematerialize]
      subscribeNext:^(id obj) {
        NSLog(@"");
      } error:^(NSError *error) {
        NSLog(@"");
        
      }];
   }];
  
  //执行请求
  [self.viewModel.requestDemoListCommand execute:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
