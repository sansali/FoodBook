//
//  TMQuiltView
//
//  Created by Bruno Virlet on 7/20/12.
//
//  Copyright (c) 2012 1000memories

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
//  and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR 
//  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
//  DEALINGS IN THE SOFTWARE.
//


#import "TMPhotoQuiltViewCell.h"

const CGFloat kTMPhotoQuiltViewMargin = 5;

@implementation TMPhotoQuiltViewCell


- (void)dealloc {
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor getColor:@"babbbd"].CGColor;
        self.layer.borderWidth = 0.5;
        self.clipsToBounds = YES;
    }
    return self;
}

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
        _photoView.clipsToBounds = YES;
        [self addSubview:_photoView];
    }
    return _photoView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
        _titleLabel.textColor = [UIColor getColor:@"333333"];
        _favoriteLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)likeLabel {
    if (!_likeLabel) {
        _likeLabel = [[UILabel alloc] init];
        _likeLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
        _likeLabel.textColor = [UIColor blackColor];
        _likeLabel.font = [UIFont systemFontOfSize:11.0];

        [self addSubview:_likeLabel];
    }
    return _likeLabel;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
        _commentLabel.textColor = [UIColor blackColor];
        _commentLabel.font = [UIFont systemFontOfSize:11.0];

        [self addSubview:_commentLabel];
    }
    return _commentLabel;
}

- (UILabel *)favoriteLabel {
    if (!_favoriteLabel) {
        _favoriteLabel = [[UILabel alloc] init];
        _favoriteLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
        _favoriteLabel.textColor = [UIColor blackColor];
        _favoriteLabel.font = [UIFont systemFontOfSize:11.0];
        [self addSubview:_favoriteLabel];
    }
    return _favoriteLabel;
}

-(UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setBackgroundImage:[UIImage imageNamed:@"a10_03"] forState:UIControlStateNormal];
        [self addSubview:_likeBtn];

    }
    return _likeBtn;
}

-(UIButton *)commentBtn{
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setBackgroundImage:[UIImage imageNamed:@"a10_05"] forState:UIControlStateNormal];
        [self addSubview:_commentBtn];
        
    }
    return _commentBtn;
}

-(UIButton *)favoriteBtn{
    if (!_favoriteBtn) {
        _favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_favoriteBtn setBackgroundImage:[UIImage imageNamed:@"a10_07"] forState:UIControlStateNormal];
        [self addSubview:_favoriteBtn];
        
    }
    return _favoriteBtn;
}
    
- (void)layoutSubviews {
    self.photoView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 55);
    self.titleLabel.frame = CGRectMake(7, self.bounds.size.height - 55,self.bounds.size.width - 14, 30);
    self.likeLabel.frame = CGRectMake(27, self.bounds.size.height - 25,50, 20);
    self.commentLabel.frame = CGRectMake(27 + self.bounds.size.width/3.0 , self.bounds.size.height - 25,50, 20);
    self.favoriteLabel.frame = CGRectMake(27 + self.bounds.size.width*2.0/3.0 , self.bounds.size.height - 25,50, 20);
    
    self.likeBtn.frame = CGRectMake(7 , self.bounds.size.height - 25,18, 18);
    self.commentBtn.frame = CGRectMake(7 + self.bounds.size.width/3.0 , self.bounds.size.height - 25,18, 18);
    self.favoriteBtn.frame = CGRectMake(7 + self.bounds.size.width*2.0/3.0 , self.bounds.size.height - 25,18, 18);

    
}

@end
