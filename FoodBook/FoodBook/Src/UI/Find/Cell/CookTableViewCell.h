//
//  FoodTableViewCell.h
//  FoodBook
//
//  Created by sansali on 15/10/13.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CookTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *uImgView;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UIImageView *imgView;

-(void)refreshViewWithData:(id)data;
@end
