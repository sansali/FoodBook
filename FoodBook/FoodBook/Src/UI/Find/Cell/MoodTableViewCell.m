//
//  NewsFeedTableViewCell.m
//  FoodBook
//
//  Created by sansali on 15/9/30.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "MoodTableViewCell.h"
#import "MoodData.h"
#import "UIImageView+WebCache.h"
@interface MoodTableViewCell (){
    
    NSMutableArray *imgs;
    
}

@property(nonatomic,strong)UIImageView *iconImgView;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UILabel *timeLab;


@end

@implementation MoodTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor getColor:@"f5f5fd"];
        
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 12, 50, 50)];
        _iconImgView.tag = 0x9876;
        [self addSubview:_iconImgView];
        
        _contentLab = [[UILabel alloc] initWithFrame:CGRectMake(75, 18, SCREENWIDTH - 85, 17)];
        _contentLab.font = [UIFont systemFontOfSize:16.0];
        _contentLab.textColor = [UIColor blackColor];
        [self addSubview:_contentLab];
        
        _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(75, 40,SCREENWIDTH - 26 - 85, 16)];
        _timeLab.font = [UIFont systemFontOfSize:15.0];
        _timeLab.textColor = [UIColor getColor:@"a1a1a1"];
        [self addSubview:_timeLab];
        
    }
    return self;
}
-(void)refreshViewWithData:(MoodData *)data{
    
    _contentLab.text = data.content;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:data.time/1000.0];
    _timeLab.text = [Tools dataStringWithDate:date];
    [_iconImgView setImageWithURL:[NSURL URLWithString:data.uimg] placeholderImage:[UIImage imageNamed:@"person"]];
    
    if (imgs == nil) {
        imgs = [[NSMutableArray alloc] initWithCapacity:0];
    }else{
        [imgs removeAllObjects];
    }
    
    for (UIView *view in self.subviews) {
        if (view.tag != 0x9876 && [view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    int itemWidth = (SCREENWIDTH  - 95)/3;
    for (int i = 0 ; i < [data.imgs count]; i++) {
        UIImageView *foodImgView = [[UIImageView alloc] initWithFrame:CGRectMake(75 + (i%3)*((SCREENWIDTH - 95)/3 + 5), 65 + i/3*(itemWidth + 5), itemWidth, itemWidth)];
        [foodImgView setImageWithURL:[NSURL URLWithString:data.imgs[i]] placeholderImage:[UIImage imageNamed:@"person"]];

        foodImgView.tag = i;
        foodImgView.userInteractionEnabled = YES;
        [self addSubview:foodImgView];
        
        UITapGestureRecognizer *ges  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [foodImgView addGestureRecognizer:ges];
        [imgs addObject:foodImgView.image];
    }
}

-(void)tap:(UIGestureRecognizer *)ges{
    if (_delegate && [_delegate respondsToSelector:@selector(tapPreviewWithIndex:withData:)]) {
        [_delegate tapPreviewWithIndex:ges.view.tag withData:imgs];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
