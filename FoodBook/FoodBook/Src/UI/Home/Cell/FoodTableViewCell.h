//
//  FoodTableViewCell.h
//  FoodBook
//
//  Created by sansali on 15/9/30.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodBookData;
@interface FoodTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *iconImgView;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *favLab;
@property(nonatomic,strong)UILabel *typeLab;
@property(nonatomic,strong)UILabel *addressLab;


-(void)refreshViewWithData:(FoodBookData *)data;
@end
