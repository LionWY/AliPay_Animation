//
//  Config.h
//  Fooding
//
//  Created by FOODING on 16/5/4.
//  Copyright © 2016年 Fooding. All rights reserved.
//

#ifndef Config_h
#define Config_h


#endif /* Config_h */




#define SCREEN_WIDTH        ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT       ([UIScreen mainScreen].bounds.size.height)
#define KAPPDELEGATE        (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define KCURRENTARRAY       @"currentArray"

#define KLASTARRAY          @"lastArray"





#define NAVIGATIONBAR_HEIGHT    44.0f  //导航栏高度
#define STATUSBAR_HEIHGT        20.0f   //状态栏高度
#define TABBAR_HEIGHT           49.0f





#define IOS_VERSION         [[[UIDevice currentDevice] systemVersion] floatValue]
#define APP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define CurrentLanguage     ([[NSLocale preferredLanguages] objectAtIndex:0])

#define STATUS_BGCOLOR      [UIColor colorWithRed:0/255.0 green:166/255.0 blue:255/255.0f alpha:1]

#define BACKGROUND_COLOR    [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0f alpha:1]