//
//  APPConfigController.m
//  NMSimpleiOSApp
//
//  Created by idolplay-macpro on 2017/6/29.
//  Copyright © 2017年 namunaka. All rights reserved.
//

#import "APPConfigController.h"
#import "YYFPSLabel.h"

@interface APPConfigController ()

@property (nonatomic, strong) UITabBarController * rootController;

@end

@implementation APPConfigController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if (SHOW_FPS_VIEW) {
    [self addFPSView];
  }
  
  
  [self setupRootViewController];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)setupRootViewController
{
  
//  UINavigationController *indexNav    = [self makeController:[HeadlineViewController class]
//                                            itemImageNormall:TabIndexNormalIcon
//                                           itemImageSelected:TabIndexSelectedIcon
//                                                       title:@"Z.TAO"];
//  UINavigationController * postsNav   = [self makeController:[HLViewController class]
//                                            itemImageNormall:TabPostsNormalIcon
//                                           itemImageSelected:TabPostsSelectedIcon
//                                                       title:@"海浪"];
//  UINavigationController * welfareNav = [self makeController:[WelfareViewController class]
//                                            itemImageNormall:TabWelfareNormalIcon
//                                           itemImageSelected:TabWelfareSelectedIcon
//                                                       title:@"福利"];
//  UINavigationController * mineNav    = [self makeController:[MineViewController class]
//                                            itemImageNormall:TabMineNormalIcon
//                                           itemImageSelected:TabMineSelectedIcon
//                                                       title:@"我"];
//  self.rootController = [[IDOTabBarController alloc] init];
//  [self.rootController setViewControllers:@[indexNav,postsNav,welfareNav,mineNav]];
//  
//  AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//  
//  appDelegate.window.rootViewController = self.rootController;
//  [appDelegate.window makeKeyAndVisible];
  
  
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)addFPSView{
  UIViewController *appRootVC;
  if ([[UIDevice currentDevice].systemVersion floatValue] < 6.0) {
    NSArray* array=[[UIApplication sharedApplication]windows];
    UIWindow* win=[array objectAtIndex:0];
    UIView* rootView=[[win subviews] objectAtIndex:0];
    appRootVC=(UIViewController*)[rootView nextResponder];
    
  }else{
    appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
  }
  UIViewController *naverVC= appRootVC;
  while (naverVC.presentedViewController) {
    naverVC = naverVC.presentedViewController;
    
  }
  
  YYFPSLabel *fpsLabel = [YYFPSLabel new];
  [fpsLabel sizeToFit];
  CGPoint origin = CGPointMake(5, 75);
  CGSize picSize = CGSizeMake(70, 20);
  fpsLabel.frame = (CGRect){.origin = origin, .size = picSize};
  fpsLabel.alpha = 1;
  [naverVC.view addSubview:fpsLabel];
  [fpsLabel bringSubviewToFront:naverVC.view];
}
@end
