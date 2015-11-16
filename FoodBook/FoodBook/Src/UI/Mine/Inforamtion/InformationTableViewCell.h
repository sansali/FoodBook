//
//  InformationTableViewCell.h
//  FoodBook
//
//  Created by sansali on 15/10/12.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationTableViewCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITextField *valueTextFiled;

-(void)editIng:(BOOL)isEditing;

@end
