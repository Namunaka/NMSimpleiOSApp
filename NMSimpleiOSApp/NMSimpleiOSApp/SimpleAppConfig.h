//
//  SimpleAppConfig.h
//  SimpleiOSApp
//
//  Created by idolplay-macpro on 2017/3/13.
//  Copyright © 2017年 Skyduck. All rights reserved.
//

#ifndef SimpleAppConfig_h
#define SimpleAppConfig_h

#define SHOW_FPS_VIEW           NO  //fps控件是否打开,开发期间建议打开,提审前必须关闭
#define SHOW_BUG_COLLECTION     NO  //bug收集控件,yes为测试线直接显示,no为生产线隐藏静默收集 开发期间必须打开,提审前必须切换为隐藏模式

#define CHECK_SWICH_THE_BUILD_LINE  (SHOW_FPS_VIEW||SHOW_BUG_COLLECTION)

#endif /* SimpleAppConfig_h */
