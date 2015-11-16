//
//  MediaAddCollectionViewCell.m
//  TengChuDisclose
//
//  Created by SongDong on 2014-04-04.
//  Copyright (c) 2014 TengChu. All rights reserved.
//

#import "MediaAddCollectionViewCell.h"
#define ImageLength2 ((SCREENWIDTH - 60)/3.0 - 5)

@implementation MediaAddCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImage *addImage = [UIImage imageNamed:@"media_add_btn"];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   ImageLength2,
                                                                   ImageLength2)];
        [btn setBackgroundImage:addImage forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
    return self;
}

-(void)addImage
{
    if ([self.delegate respondsToSelector:@selector(addImage)])
    {
        [self.delegate addImage];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
