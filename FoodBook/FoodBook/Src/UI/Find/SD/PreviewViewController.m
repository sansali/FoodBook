//
//  PreviewViewController.m
//  TengChuDisclose
//
//  Created by SongDong on 2014-03-12.
//  Copyright (c) 2014 TengChu. All rights reserved.
//  图片预览器

#import "PreviewViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "SDZoomScrollView.h"

@interface PreviewViewController ()

@property(nonatomic, strong) NSMutableArray *assets;
@property(nonatomic, strong) NSMutableArray *imageArray;
@property(nonatomic, strong) UIScrollView *scrollView;

@end

@implementation PreviewViewController

@synthesize m_delegate;

- (id)initWithAssets:(NSMutableArray *)assets;
{
    self = [super initWithNibName:nil  bundle:nil];
    if (self) {
        self.assets = assets;
    }
    return self;
}

- (id)initWithImages:(NSMutableArray *)images
{
    self = [super initWithNibName:nil  bundle:nil];
    if (self) {
        self.imageArray = images;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self createNav];
    self.view.frame = CGRectMake(0.0, 0.0, SCREENWIDTH, SCREENHEIGHT - 44);
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    CGFloat x = 0.0;
    
    if (self.imageArray>0)
    {
        for (int i = 0; i<self.imageArray.count; i++)
        {
            [self addZoomScrollViewWithImage:[self.imageArray objectAtIndex:i] startX:x];
            x = x+SCREENWIDTH;
        }
        self.scrollView.contentSize = CGSizeMake(SCREENWIDTH*self.imageArray.count, self.view.bounds.size.height);
    }
    else
    {
        for (int i = 0; i < self.assets.count; i++)
        {
            ALAsset *tempAsset = [self.assets objectAtIndex:i];
            ALAssetRepresentation *representaion = [tempAsset defaultRepresentation];
            UIImage *image = [UIImage imageWithCGImage:[representaion fullResolutionImage]];

            [self addZoomScrollViewWithImage:image startX:x];
            x = x+SCREENWIDTH;
        }
        self.scrollView.contentSize = CGSizeMake(SCREENWIDTH*self.assets.count, self.view.bounds.size.height);
    }
    
    
    [self.scrollView setContentOffset:CGPointMake(SCREENWIDTH * self.currentImageIndex, 0.0) ];
}

-(void)createNav{
    
    if (!_isHiddenDelete) {
        
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        publishBtn.frame = CGRectMake(0.0, 0.0, 44, 25);
        [publishBtn setBackgroundColor:[UIColor clearColor]];
        [publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [publishBtn setTitle:@"删除" forState:UIControlStateNormal];
        publishBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        publishBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
        publishBtn.layer.borderWidth = 1;
        publishBtn.layer.cornerRadius = 5;
        [publishBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:publishBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
}

-(void)deleteBtnClick{
    
    if (m_delegate && [m_delegate respondsToSelector:@selector(removeImgWithIndex:)]) {
        [m_delegate removeImgWithIndex:_currentImageIndex];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)addZoomScrollViewWithImage:(UIImage *)image startX:(CGFloat)x
{
    SDZoomScrollView *zoomScrollView =  [[SDZoomScrollView alloc] initWithFrame:CGRectMake(x,0,
                                                                                           self.view.bounds.size.width, self.view.bounds.size.height)
                                                                          image:image];
    [self.scrollView addSubview:zoomScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
