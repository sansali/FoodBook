//
//  SDAssetPickerController.m
//  TengChuDisclose
//
//  Created by SongDong on 2014-03-10.
//  Copyright (c) 2014 TengChu. All rights reserved.
//  获取图库中得各个文件夹（group）

#import "SDAssetPickerController.h"
#import "SDAssetGroupViewCell.h"
#import "SDAssetViewController.h"

@interface SDAssetPickerController ()

@property (nonatomic, strong) ALAssetsFilter *assetsFilter;
@property(nonatomic, assign) AssetsType assetsType;

@end

#pragma mark- SDAssetGroupViewController
@interface SDAssetGroupViewController()

@property(nonatomic, strong) UITableView *groupTable;

@end

@implementation SDAssetGroupViewController
DEF_SINGLETON(ALAssetsLibrary);

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)+49);
    self.title = @"选择相片";
    [self initMainView];
    [self getGroupData];
}

//返回按钮点击事件
-(void)goBackBtnClick
{
    SDAssetPickerController *picker = (SDAssetPickerController *)self.navigationController;
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

//完成按钮点击事件
-(void)enterBtnClick
{
    
}

//初始化相册组 界面视图
-(void)initMainView
{
    //添加相册组列表视图
    self.groupTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.groupTable.backgroundColor = [UIColor whiteColor];
    self.groupTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.groupTable.delegate = self;
    self.groupTable.dataSource = self;
    [self.view addSubview:self.groupTable];
}

//空态页面
- (void)showNoAssets
{

}

//刷新列表数据
-(void)reload
{
    if (self.groups.count <= 0)
    {
        NSLog(@"没有相册");
    }
    [self.groupTable reloadData];
}

//获取相册数据
- (void)getGroupData
{
    if (!self.assetsLibrary)
    {
        //self.assetsLibrary = [self.class defaultAssetsLibrary];
        self.assetsLibrary = [self.class sharedInstance];
    }
    
    if (!self.groups)
    {
        self.groups = [[NSMutableArray   alloc] init];
    }
    else
    {
        [self.groups removeAllObjects];
    }
    
    SDAssetPickerController *picker = (SDAssetPickerController *)self.navigationController;
    ALAssetsFilter *assetsFilter = picker.assetsFilter;
    
    ALAssetsLibraryGroupsEnumerationResultsBlock resultsBlock = ^(ALAssetsGroup *group, BOOL *stop){

        if (group)
        {
            
            [group setAssetsFilter:assetsFilter];
            if (group.numberOfAssets > 0)
            {
                [self.groups addObject:group];
            }
            else
            {
                [self reload];
            }
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        NSLog(@"此应用无法使用您的照片或视频。");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"不能访问相册" message:@"请在iPhone的“设置-隐私-相册”中允许今日报料访问你的相册" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    };
    
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                      usingBlock:resultsBlock
                                    failureBlock:failureBlock];
    
    NSUInteger type =
    ALAssetsGroupLibrary | ALAssetsGroupAlbum | ALAssetsGroupEvent |
    ALAssetsGroupFaces | ALAssetsGroupPhotoStream;
    
    [self.assetsLibrary enumerateGroupsWithTypes:type
                                      usingBlock:resultsBlock
                                    failureBlock:failureBlock];
    
}

#pragma mark - ALAssetsLibrary

+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

#pragma mark- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groups.count;;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"groupCell";
    SDAssetGroupViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == Nil)
    {
        cell =  [[SDAssetGroupViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"groupCell"];
    }
    [cell updateWithAssetsGroup:[self.groups objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SDAssetViewController *assetViewController = [[SDAssetViewController alloc] initWithAssetsGroup:[self.groups objectAtIndex:indexPath.row]];
    SDAssetPickerController *picker = (SDAssetPickerController *)self.navigationController;
    assetViewController.delegate = picker.delegate;
    [self.navigationController pushViewController:assetViewController animated:YES];
}

@end

@implementation SDAssetPickerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithAssetsType:(AssetsType)assetsType
{
    self.assetsType = assetsType;
    SDAssetGroupViewController *groupViewController = [[SDAssetGroupViewController alloc] init];
    if (self = [super initWithRootViewController:groupViewController])
    {
        switch (self.assetsType)
        {
            case AllAssets:
                self.assetsFilter = [ALAssetsFilter allAssets];
                break;
            case AllPhotos:
                self.assetsFilter = [ALAssetsFilter allPhotos];
                break;
            case AllVideos:
                self.assetsFilter = [ALAssetsFilter allVideos];
                break;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
