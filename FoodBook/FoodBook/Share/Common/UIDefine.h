//
//  UIDefine.h
//  FoodBook
//
//  Created by sansali on 15/9/15.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#ifndef FoodBook_UIDefine_h
#define FoodBook_UIDefine_h

/*******************color start*******************/
//navigationgBar  背景色
#define THEMECOLOR ([UIColor getColor:@"ed1b26"])
#define FONTTHEMECOLOR ([UIColor getColor:@"000000"])
#define FONTREADEDCOLOR ([UIColor getColor:@"666666"])
#define FONTCONENTCOLOR ([UIColor getColor:@"777777"])
#define LINECOLOR ([UIColor getColor:@"cccccc"])

/*******************color start*******************/

#define NAVTITLEFONT ([UIFont boldSystemFontOfSize:20.0])

#define VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
#define SCREENHEIGHT ([UIScreen mainScreen].bounds.size.height-20)
#define SCREENWIDTH CGRectGetWidth([[UIScreen mainScreen] applicationFrame])

#define SHOWED (@"ISSHOWED")

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

#endif
