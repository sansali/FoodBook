//
//  IntroViewController.m
//  FoodBook
//
//  Created by sansali on 15/9/15.
//  Copyright (c) 2015年 sansali. All rights reserved.
//

#import "IntroViewController.h"
#import "AppDelegate.h"
@interface IntroViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIPageControl *pageControl;

@end

#define introCount (1)
@implementation IntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc ] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT + 20)];
    scrollView.contentSize = CGSizeMake(SCREENWIDTH*2, SCREENHEIGHT + 20);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < introCount; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH*i, 0, SCREENWIDTH, SCREENHEIGHT+20)];
        imgView.image = [UIImage imageNamed:@"start_30"];
        imgView.backgroundColor = [UIColor redColor];
        [scrollView addSubview:imgView];
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 50, SCREENWIDTH, 50)];
    _pageControl.numberOfPages = introCount;
    [self.view addSubview:_pageControl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/SCREENWIDTH;
    _pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x >= SCREENWIDTH*(introCount - 1)) {
        //goto home
        [AppDelegate gotoHome];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
