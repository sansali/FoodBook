//
//  FoodTableViewCell.m
//  FoodBook
//
//  Created by sansali on 15/9/30.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "FoodTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "FoodBookData.h"

@implementation FoodTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor getColor:@"f5f5fd"];

        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(13, 6, SCREENWIDTH - 26, 153)];
        whiteView.backgroundColor = [UIColor whiteColor];
        whiteView.layer.borderColor = [UIColor getColor:@"d6d5da"].CGColor;
        whiteView.layer.borderWidth = 1;
        whiteView.layer.cornerRadius = 1;
        [self addSubview:whiteView];
        
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 14, 128, 125)];
        _iconImgView.image = [UIImage imageNamed:@"person"];
        [whiteView addSubview:_iconImgView];
        
//        NSArray *titles = @[@"食材：芝麻酱",@"口味：咸香",@"烹制：煮",@"地域：湖北 武汉"];
        for (int i = 0; i < 4; i++) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(158, 22 + 30*i, 150, 16)];
//            titleLabel.text = titles[i];
            titleLabel.textColor = [UIColor blackColor];
            [whiteView addSubview:titleLabel];
            
            if (i == 0) {
                _nameLab = titleLabel;
            }else if(i == 1){
                _favLab = titleLabel;

            }else if(i == 2){
                _typeLab = titleLabel;

            }else{
                _addressLab = titleLabel;

            }
        }
    }
    return self;
}

-(void)refreshViewWithData:(FoodBookData *)data{
    [_iconImgView setImageWithURL:[NSURL URLWithString:data.img] placeholderImage:[UIImage imageNamed:@"person"]];
    _nameLab.text = [@"食材：" stringByAppendingString:data.name];
    
    if (data.flavor && [data.flavor isKindOfClass:[NSString class]]) {
        _favLab.text = [@"口味：" stringByAppendingString:data.flavor];
        
    }else{
        _favLab.text = [@"口味：" stringByAppendingString:@""];
        
    }
    
    if (data.type && [data.type isKindOfClass:[NSString class]]) {
        _typeLab.text = [@"烹制：" stringByAppendingString:data.type];

    }else{
        _typeLab.text = [@"烹制：" stringByAppendingString:@""];

    }

    
    if (data.address && [data.address isKindOfClass:[NSString class]]) {
        _addressLab.text = [@"地域：" stringByAppendingString:data.address];
        
    }else{
        _addressLab.text = [@"地域：" stringByAppendingString:@""];
        
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
