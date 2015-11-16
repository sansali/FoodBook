//
//  HXNavigationController.m
//  FoodBook
//
//  Created by sansali on 15/9/15.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "HXNavigationController.h"

@implementation HXNavigationController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.navigationBar.barTintColor = THEMECOLOR;
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,NAVTITLEFONT,NSFontAttributeName, nil]];

}

@end
