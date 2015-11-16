//
//  EditFoodContentThirdViewController.m
//  FoodBook
//
//  Created by sansali on 15/10/20.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "EditFoodContentThirdViewController.h"
#import "SDAssetPickerController.h"
#import "ImageLoadCollectionViewCell.h"
#import "ImageWhiteCollectionViewCell.h"
#import "MediaAddCollectionViewCell.h"
#import "PreviewViewController.h"

@interface EditFoodContentThirdViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MediaAddCollectionViewCellDelegate,ImageLoadCollectionViewCellDelegate,PreviewViewControllerDelegate>
{
    UIScrollView *scrollView;
    UIButton *editDoneBtn;

}
@property(nonatomic,strong)NSMutableArray *thumbnailArray;
@property(nonatomic, strong) UICollectionView *imageCollectionView;  //呈现准备上传的图片的view

@end
#define ImageLoadViewCellIdentifier @"imageLoadViewCellIdentifier"
#define ImageWhiteViewCellIdentifier @"imageWhiteViewCellIdentifier"
#define ImageAddViewCellIdentifier @"imageAddViewCellIdentifier"

@implementation EditFoodContentThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"编辑食谱内容";
    
    self.thumbnailArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self createAll];
}
-(void)createAll{
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 44)];

    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 131, 27)];
    iconImgView.image = [UIImage imageNamed:@"step_3"];
    [scrollView addSubview:iconImgView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 20 + iconImgView.frame.size.height, SCREENWIDTH - 20, 30)];
    textField.layer.cornerRadius = 3;
    textField.placeholder = @"处理食材";
    textField.backgroundColor = [UIColor whiteColor];
    textField.layer.borderColor = [UIColor grayColor].CGColor;
    textField.layer.borderWidth = 0.5;
    [scrollView addSubview:textField];
    
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"操作描述（字数在150字以内）"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, 4)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(4, 11)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(4, 11)];
    UILabel *editIntroduce = [Tools createLabWithFrame:CGRectMake(10, 60 + iconImgView.frame.size.height, SCREENWIDTH - 20, 20) withAttributed:string withTitleSize:14.0 withTextColor:[UIColor blackColor]];
    [scrollView addSubview:editIntroduce];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 90 + iconImgView.frame.size.height, SCREENWIDTH - 20, 80)];
    textView.layer.cornerRadius = 3;
    textView.backgroundColor = [UIColor whiteColor];
    textView.layer.borderColor = [UIColor grayColor].CGColor;
    textView.layer.borderWidth = 0.5;
    [scrollView addSubview:textView];
    
    NSMutableAttributedString *coverString = [[NSMutableAttributedString alloc] initWithString:@"操作过程图片（请按操作顺序上传不超过9张图片）"];
    [coverString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 6)];
    [coverString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, 6)];
    [coverString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(6, 17)];
    [coverString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(6, 17)];
    UILabel *coverTitle = [Tools createLabWithFrame:CGRectMake(10, 180 + iconImgView.frame.size.height, SCREENWIDTH - 20, 20) withAttributed:coverString withTitleSize:14.0 withTextColor:[UIColor blackColor]];
    [scrollView addSubview:coverTitle];
    
    
    [self.view addSubview:scrollView];
    
    float itemWidth = (SCREENWIDTH - 40)/3.0;

    if (!_imageCollectionView)
    {
        UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREENWIDTH -60)/3.0, (SCREENWIDTH -60)/3.0);
        layout.sectionInset = UIEdgeInsetsMake(240.0, 15.0, 10, 15.0);
        layout.minimumInteritemSpacing = 3.0;  //格子间距
        layout.minimumLineSpacing = 5.0;    //行间距
        
        _imageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 1000) collectionViewLayout:layout];
        _imageCollectionView.allowsMultipleSelection = YES;
        _imageCollectionView.backgroundColor = [UIColor clearColor];
        _imageCollectionView.userInteractionEnabled = YES;
        _imageCollectionView.delegate = self;
        _imageCollectionView.dataSource = self;
        _imageCollectionView.scrollEnabled = NO;
        [_imageCollectionView registerClass:[ImageLoadCollectionViewCell class] forCellWithReuseIdentifier:ImageLoadViewCellIdentifier];
        [_imageCollectionView registerClass:[MediaAddCollectionViewCell class] forCellWithReuseIdentifier:ImageAddViewCellIdentifier];
        
        [scrollView addSubview: self.imageCollectionView];
    }
    
    [_imageCollectionView reloadData];
    
    editDoneBtn = [Tools createBtnWithFrame:CGRectMake(10, 247 + itemWidth, SCREENWIDTH - 20, 40) withTitle:@"编辑完成" withTitleSize:16];
    editDoneBtn.backgroundColor = THEMECOLOR;
    editDoneBtn.layer.cornerRadius = 3;
    editDoneBtn.tag = 0x987;
    [editDoneBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:editDoneBtn];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 0x987:
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
            break;
            
        default:
            break;
    }
}

//添加图片事件
-(void)gotoSelectImage
{
    SDAssetPickerController *pickerController = [[SDAssetPickerController alloc] initWithAssetsType:AllPhotos];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:^{}];
}

#pragma mark- SDAssetControllerDelegate
-(void)assetsPickerController:(SDAssetPickerController *)picker didFinishPickingAssets:(NSMutableArray *)assets
{
    for (int i = 0; i < assets.count; i++)
    {
        if (self.thumbnailArray.count >= 9)
        {
            break;
        }
        ALAsset *tempAsset = [assets objectAtIndex:i];
        [self.thumbnailArray addObject:[UIImage imageWithCGImage:[tempAsset defaultRepresentation].fullScreenImage]];
    }
    
    [self.imageCollectionView reloadData];
    [self resizeScrollView];

}

-(void)resizeScrollView{
    if (_thumbnailArray.count >= 6) {
        editDoneBtn.frame = CGRectMake(10, 250 + (SCREENWIDTH -60)/3.0*3, SCREENWIDTH - 20, 40);
    }else if (_thumbnailArray.count >= 3){
        editDoneBtn.frame = CGRectMake(10, 250 + (SCREENWIDTH -60)/3.0*2, SCREENWIDTH - 20, 40);
    }else{
        editDoneBtn.frame = CGRectMake(10, 250 + (SCREENWIDTH -60)/3.0, SCREENWIDTH - 20, 40);
    }
    
    scrollView.contentSize = CGSizeMake(SCREENWIDTH, editDoneBtn.frame.origin.y + 50);
}

#pragma mark - Collection View Data Source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self.thumbnailArray count] < 9) {
        return  self.thumbnailArray.count + 1;
    }else{
        return self.thumbnailArray.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ((self.thumbnailArray.count < 9 && indexPath.row == self.thumbnailArray.count))  //添加按钮的icon
    {
        MediaAddCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageAddViewCellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
    
    ImageLoadCollectionViewCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageLoadViewCellIdentifier
                                                                                       forIndexPath:indexPath];
    imageCell.delegate = self;
    [imageCell updateWithImage:[self.thumbnailArray objectAtIndex:indexPath.item] index:indexPath.item];
    return imageCell;
    
}

-(void)addImage{
    [self gotoSelectImage];
}

//删除
-(void)deleteImageWithIndex:(int)index{
    [self.thumbnailArray removeObjectAtIndex:index];
    [self.imageCollectionView reloadData];
    [self resizeScrollView];

}

//点击图片预览
-(void)tapPreviewWithIndex:(int)index{
    PreviewViewController *previewCntroller = [[PreviewViewController alloc] initWithImages:self.thumbnailArray];
    previewCntroller.m_delegate = self;
    previewCntroller.currentImageIndex = index;
    [self.navigationController pushViewController:previewCntroller animated:YES];
}

-(void)removeImgWithIndex:(int)index{
    [self.thumbnailArray removeObjectAtIndex:index];
    [self.imageCollectionView reloadData];
    [self resizeScrollView];

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
