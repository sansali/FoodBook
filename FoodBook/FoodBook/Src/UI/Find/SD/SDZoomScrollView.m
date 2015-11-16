//
//  SDZoomScrollView.m
//  TengChuDisclose
//
//  Created by SongDong on 2014-03-14.
//  Copyright (c) 2014 TengChu. All rights reserved.
//  图片缩放器

#import "SDZoomScrollView.h"

@interface SDZoomScrollView()

@property(nonatomic, assign) CGRect viewFrame;

@end

#define HEIGHT_MAX 441

@implementation SDZoomScrollView

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.viewFrame = frame;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
       [self initImageView:image];
    }
    return self;
}

-(void)initImageView:(UIImage *)image
{
    //创建图片View
    self.imageView = [[UIImageView alloc]init];
    CGFloat imageHeight = image.size.height*(CGRectGetWidth(self.bounds)/image.size.width);
    imageHeight = imageHeight< self.bounds.size.height ? imageHeight : self.bounds.size.height;
    self.imageView.frame = CGRectMake(0, (CGRectGetHeight(self.bounds) - imageHeight)/2, self.bounds.size.width, imageHeight);
    self.imageView.userInteractionEnabled = YES;
    [self.imageView setImage:image];
    [self addSubview:self.imageView];
    
    //双击手势添加到图片view
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    [doubleTapGesture setNumberOfTapsRequired:2];
    [self.imageView addGestureRecognizer:doubleTapGesture];
    
    [self setMaximumZoomScale:2.5];
}

-(void)doubleTap:(UIGestureRecognizer *)gesture
{
    CGRect zoomRect = CGRectZero;
    if (isAmplification)
    {
        zoomRect = [self zoomRectForScale:self.minimumZoomScale withCenter:[gesture locationInView:gesture.view]];
    }
    else
    {
        zoomRect = [self zoomRectForScale:self.maximumZoomScale withCenter:[gesture locationInView:gesture.view]];
    }
    [self zoomToRect:zoomRect animated:YES];
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height/scale;
    zoomRect.size.width  = self.frame.size.width /scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    NSLog(@"self.view:  %f,  %f,  %f,  %f", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    NSLog(@"center:    %f, %f", center.x,center.y);
    NSLog(@"zoomRect:    %f,  %f,  %f,  %f", zoomRect.origin.x, zoomRect.origin.y, zoomRect.size.width, zoomRect.size.height);
    return zoomRect;
}

-(void)updateSize
{
    if (isAmplification)
    {
        [self setFrame:self.viewFrame];
    }
    else
    {
        if (self.viewFrame.size.height < HEIGHT_MAX)
        {
            CGFloat height = self.viewFrame.size.height * self.maximumZoomScale;
            height = height > HEIGHT_MAX?HEIGHT_MAX:height;
            [self setFrame:CGRectMake(self.viewFrame.origin.x, (441 - height)/2, SCREENWIDTH, height)];
        }
    }
}

#pragma mark- UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

//- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
//{
//    [self updateSize];
//}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    //[scrollView setZoomScale:scale animated:NO];
    isAmplification = !isAmplification;
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
