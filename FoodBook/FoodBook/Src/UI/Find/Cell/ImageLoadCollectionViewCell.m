//
//  ImageLoadCollectionViewCell.m
//  TengChuDisclose
//
//  Created by SongDong on 2014-04-03.
//  Copyright (c) 2014 TengChu. All rights reserved.
//

#import "ImageLoadCollectionViewCell.h"

#define ImageLength ((SCREENWIDTH - 60)/3.0 - 5)

@interface ImageLoadCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageView;    //图片
@property (nonatomic, strong) UIButton *deleteBtn;     //删除按钮
@property (nonatomic, assign) int index;

@end

@implementation ImageLoadCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //图片
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       ImageLength,
                                                                       ImageLength)];
        self.imageView.userInteractionEnabled = YES;
        _imageView.layer.cornerRadius = 6.0;
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.imageView];
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"deleteImg"] forState:UIControlStateNormal];
        deleteBtn.frame = CGRectMake(ImageLength - 28, 2, 26, 26);
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_imageView addSubview:deleteBtn];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
        [self.imageView addGestureRecognizer:tapGesture];

    }
    return self;
}

-(void)viewTap:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(tapPreviewWithIndex:)])
    {
        [self.delegate tapPreviewWithIndex:self.index];
    }
}

- (void)updateWithImage:(UIImage *)image index:(int)index
{
    [self.imageView setImage:image];
    self.image = image;
    self.index = index;
}

-(void)deleteBtnClick:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(deleteImageWithIndex:)]) {
        [_delegate deleteImageWithIndex:_index];
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
