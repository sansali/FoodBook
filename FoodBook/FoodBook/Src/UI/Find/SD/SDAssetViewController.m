//
//  SDAssetViewController.m
//  TengChuDisclose
//
//  Created by SongDong on 2014-03-10.
//  Copyright (c) 2014 TengChu. All rights reserved.
//  点击图库下某个文件夹（group）进入，获取该group下得所有图片或视频

#import "SDAssetViewController.h"
#import "SDAssetCollectionCell.h"
#import "SDAssetPickerController.h"
#import "PreviewViewController.h"

#define columns 3
#define Item_Length 102
#define ItemSize CGSizeMake(Item_Length, Item_Length)
#define AssetsViewCellIdentifier @"AssetsViewCellIdentifier"

@interface SDAssetViewController ()

@property(nonatomic, strong) UICollectionView *assetCollectionView;

@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, assign) NSInteger numberOfPhotos;
@property (nonatomic, assign) NSInteger numberOfVideos;

@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, strong) NSMutableArray *indexPathsForSelectedItems;

@property(nonatomic, strong) UIButton *previewBtn;  //预览按钮
@property(nonatomic, strong) UIButton *finishBtn;  //完成按钮

@end

@implementation SDAssetViewController

-(id)initWithAssetsGroup:(ALAssetsGroup *)theAssetsGroup
{
    self = [super init];
    if (self)
    {
        self.assetsGroup = theAssetsGroup;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)+49);
    self.title = @"选择相片";
    [self initMainView];
     [self getAssets];
}

//完成
-(void)finishBtnClick
{
    NSMutableArray *assets = [[NSMutableArray alloc] init];
    
    for (NSIndexPath *indexPath in self.assetCollectionView.indexPathsForSelectedItems)
    {
        [assets addObject:[self.assets objectAtIndex:indexPath.item]];
    }
    
    SDAssetPickerController *picker = (SDAssetPickerController *)self.navigationController;
    
    if ([self.delegate respondsToSelector:@selector(assetsPickerController:didFinishPickingAssets:)])
    {
        [self.delegate assetsPickerController:picker didFinishPickingAssets:assets];
    }
    
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

-(void)initMainView
{
    //初始化导航条
    
    //初始化图片列表
    UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = ItemSize;
    layout.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 158, 5.0);
    layout.minimumInteritemSpacing = 2.0;
    layout.minimumLineSpacing = 5.0;
    
    self.assetCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.assetCollectionView.allowsMultipleSelection = YES;
    self.assetCollectionView.backgroundColor = [UIColor whiteColor];
    self.assetCollectionView.delegate = self;
    self.assetCollectionView.dataSource = self;
    [self.assetCollectionView registerClass:[SDAssetCollectionCell class] forCellWithReuseIdentifier:AssetsViewCellIdentifier];
    [self.view addSubview:self.assetCollectionView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, SCREENWIDTH,44)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    self.previewBtn = [[UIButton alloc] initWithFrame:CGRectMake(15,SCREENHEIGHT - 88 + 7,50,30)];
    _previewBtn.backgroundColor = [UIColor clearColor];
    [_previewBtn setTitle:@"预览" forState:UIControlStateNormal];
    [_previewBtn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    [self.previewBtn addTarget:self action:@selector(previewBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.previewBtn];
    
    
    _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _finishBtn.frame = CGRectMake(SCREENWIDTH - 75, SCREENHEIGHT - 88 +7, 60, 30);
    [_finishBtn setBackgroundColor:THEMECOLOR];
    _finishBtn.layer.cornerRadius = 5.0;
    [_finishBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    _finishBtn.clipsToBounds = YES;
     [_finishBtn addTarget:self action:@selector(finishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_finishBtn];

}

//预览按钮点击事件
-(void)previewBtnClick
{
    NSMutableArray *assets = [[NSMutableArray alloc] init];
    
    for (NSIndexPath *indexPath in self.assetCollectionView.indexPathsForSelectedItems)
    {
        [assets addObject:[self.assets objectAtIndex:indexPath.item]];
    }
    
    PreviewViewController *previewCntroller = [[PreviewViewController alloc] initWithAssets:assets];
    previewCntroller.isHiddenDelete = YES;
    [self.navigationController pushViewController:previewCntroller animated:YES];
}

//获取每个相册文件夹下面的内容
-(void)getAssets
{
    if (!self.assets)
    {
        self.assets = [[NSMutableArray alloc] init];
    }
    else
    {
        [self.assets removeAllObjects];
    }
    
    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop){
        if (result)
        {
            [self.assets addObject:result];
            NSString *assetType = [result valueForProperty:ALAssetPropertyType];
            
            if ([assetType isEqual:ALAssetTypePhoto])
            {
                self.numberOfPhotos++;
            }
            
            if ([assetType isEqual:ALAssetTypeVideo])
            {
                self.numberOfVideos++;
            }
        }
        else if(self.assets.count > 0)
        {
            [self.assetCollectionView reloadData];
            [self.assetCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.assets.count-1 inSection:0]
                                             atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        }
    };
    [self.assetsGroup enumerateAssetsUsingBlock:resultsBlock];
}

#pragma mark - Collection View Data Source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SDAssetCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AssetsViewCellIdentifier forIndexPath:indexPath];
    [cell updateWithAsset:[self.assets objectAtIndex:indexPath.item]];
    return cell;
}

#pragma mark- Collection View Delegate
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //最多选9个
    BOOL isNoOver9 = collectionView.indexPathsForSelectedItems.count < 9;
    if (!isNoOver9) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"最多只能上传9张图片" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
    return isNoOver9;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //选中
    SDAssetCollectionCell *theCell = (SDAssetCollectionCell* )[collectionView cellForItemAtIndexPath:indexPath];
    [theCell updateState];
    [_finishBtn setTitle:[NSString stringWithFormat:@"完成(%lu)",(unsigned long)collectionView.indexPathsForSelectedItems.count] forState:UIControlStateNormal];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    SDAssetCollectionCell *theCell = (SDAssetCollectionCell* )[collectionView cellForItemAtIndexPath:indexPath];
    [theCell updateState];
    [_finishBtn setTitle:[NSString stringWithFormat:@"完成(%lu)",(unsigned long)collectionView.indexPathsForSelectedItems.count] forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
