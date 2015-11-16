//
//  InformationSexTableViewCell.h
//  FoodBook
//
//  Created by sansali on 15/10/12.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationSexTableViewCell : UITableViewCell
{
    UIButton *womanBtn;
    UIButton *manBtn;
    BOOL _isEditing;
}

@property(nonatomic,strong) void (^btnCallBack)(int sex);

-(void)setSex:(int)sex whitEditing:(BOOL)isEditIng;

@end
