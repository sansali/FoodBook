//
//  CommentTableViewCell.m
//  FoodBook
//
//  Created by sansali on 11/2/15.
//  Copyright © 2015 sansali. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor getColor:@"f5f5fd"];
        
        /*
         UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(13, 6, SCREENWIDTH - 26, 82)];
         whiteView.backgroundColor = [UIColor whiteColor];
         whiteView.layer.borderColor = [UIColor getColor:@"d6d5da"].CGColor;
         whiteView.layer.borderWidth = 1;
         whiteView.layer.cornerRadius = 1;
         [self addSubview:whiteView];
         */
        
        UIImageView *foodImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 12, 50, 50)];
        foodImgView.tag = 0x9876;
        foodImgView.image = [UIImage imageNamed:@"person"];
        [self addSubview:foodImgView];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 18, SCREENWIDTH - 26 - 85, 16)];
        nameLabel.text = @"熊大";
        nameLabel.textColor = [UIColor blackColor];
        [self addSubview:nameLabel];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 15, SCREENWIDTH - 120, 40)];
        titleLabel.font = [UIFont    systemFontOfSize:16.0];
        titleLabel.text = @"今天心情不错，挺风和日丽的，啦啦啦的法定时间看风景啊都开始放假啊快点放假喀什";
        titleLabel.numberOfLines  =2;
        
        titleLabel.textColor = [UIColor grayColor];
        [self addSubview:titleLabel];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 58,SCREENWIDTH - 26 - 85, 16)];
        timeLabel.text = @"10分钟前";
        timeLabel.textColor = [UIColor getColor:@"a1a1a1"];
        [self addSubview:timeLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
