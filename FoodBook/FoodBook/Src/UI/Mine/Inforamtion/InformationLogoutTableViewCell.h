//
//  InformationLogoutTableViewCell.h
//  FoodBook
//
//  Created by sansali on 15/10/12.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationLogoutTableViewCell : UITableViewCell<UIAlertViewDelegate>

@property(nonatomic,copy) void (^loginoutCallBack)();

@end
