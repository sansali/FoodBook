//
//  EditContentViewController.m
//  FoodBook
//
//  Created by sansali on 15/10/14.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "EditContentViewController.h"
#import "SDAssetPickerController.h"
#import "ImageLoadCollectionViewCell.h"
#import "ImageWhiteCollectionViewCell.h"
#import "MediaAddCollectionViewCell.h"
#import "PreviewViewController.h"

@interface EditContentViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MediaAddCollectionViewCellDelegate,ImageLoadCollectionViewCellDelegate,UIScrollViewDelegate,PreviewViewControllerDelegate>{
    int count;
    UIScrollView *bgScrollView;
    UIButton *publishBtn;
    UITextView *contentTextView;
}

@property(nonatomic,strong)NSMutableArray *thumbnailArray;
@property(nonatomic, strong) UICollectionView *imageCollectionView;  //呈现准备上传的图片的view

@end
#define ImageLoadViewCellIdentifier @"imageLoadViewCellIdentifier"
#define ImageWhiteViewCellIdentifier @"imageWhiteViewCellIdentifier"
#define ImageAddViewCellIdentifier @"imageAddViewCellIdentifier"

@implementation EditContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"编辑心情";
    
    _thumbnailArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self createAll];
}

-(void)createAll{
    
    bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 44)];
    bgScrollView.delegate = self;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"编辑文字（字数在150字以内）"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(4, 11)];
    UILabel *editTitle = [Tools createLabWithFrame:CGRectMake(10, 10, SCREENWIDTH - 20, 16) withAttributed:string withTitleSize:16.0 withTextColor:[UIColor blackColor]];
    [bgScrollView addSubview:editTitle];
    
    contentTextView  = [[UITextView alloc] initWithFrame:CGRectMake(15, 35, SCREENWIDTH - 30, 80)];
    contentTextView.layer.cornerRadius = 3;
//    contentTextView.delegate = self;
    contentTextView.backgroundColor = [UIColor whiteColor];
    contentTextView.layer.borderColor = [UIColor grayColor].CGColor;
    contentTextView.layer.borderWidth = 0.5;
    
    NSMutableAttributedString *coverString = [[NSMutableAttributedString alloc] initWithString:@"心情图片（上传图片不能超过9张）"];
    [coverString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
    [coverString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(4, 12)];
    UILabel *coverTitle = [Tools createLabWithFrame:CGRectMake(10, 130, SCREENWIDTH - 20, 16) withAttributed:coverString withTitleSize:16.0 withTextColor:[UIColor blackColor]];
    [bgScrollView addSubview:coverTitle];
    
    [self.view addSubview:bgScrollView];
    
    if (!_imageCollectionView)
    {
        UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREENWIDTH -60)/3.0, (SCREENWIDTH -60)/3.0);
        layout.sectionInset = UIEdgeInsetsMake(160.0, 15.0, 10.0, 15.0);
        layout.minimumInteritemSpacing = 3.0;  //格子间距
        layout.minimumLineSpacing = 5.0;    //行间距
        
        _imageCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _imageCollectionView.allowsMultipleSelection = YES;
        _imageCollectionView.backgroundColor = [UIColor clearColor];
        _imageCollectionView.userInteractionEnabled = YES;
        _imageCollectionView.delegate = self;
        _imageCollectionView.dataSource = self;
        [_imageCollectionView registerClass:[ImageLoadCollectionViewCell class] forCellWithReuseIdentifier:ImageLoadViewCellIdentifier];
        [_imageCollectionView registerClass:[MediaAddCollectionViewCell class] forCellWithReuseIdentifier:ImageAddViewCellIdentifier];
        
        [bgScrollView addSubview: self.imageCollectionView];
    }
    
    [_imageCollectionView reloadData];
    publishBtn = [Tools createBtnWithFrame:CGRectMake(10, 180 + (SCREENWIDTH -60)/3.0*2, SCREENWIDTH - 20, 40) withTitle:@"发布" withTitleSize:16];
    //    _loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    publishBtn.backgroundColor = THEMECOLOR;
    publishBtn.layer.cornerRadius = 5;
    publishBtn.tag = 0x987;
    [publishBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:publishBtn];
    [bgScrollView addSubview:contentTextView];

    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesTap:)];
    [bgScrollView addGestureRecognizer:ges];
}

-(void)btnClick:(UIButton *)sender{
    if (sender.tag == 0x987) {
        //publish
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dic setObject:[UserCenter shareInstance].loginUser.token forKey:@"token"];
        [dic setObject:contentTextView.text forKey:@"text"];
//        [dic setObject:[UserCenter shareInstance].loginUser.token forKey:@"myfile1"];

//        for (int  i = 0 ; i < _thumbnailArray.count; i++) {
//            UIImage *image = _thumbnailArray[i];
//            NSData *dataObj = UIImageJPEGRepresentation(image, 0.7);
//            [dic setObject:dataObj forKey:[NSString stringWithFormat:@"myfile%d",i+1]];
//            
//            
//            [formData appendPartWithFileData:dataObj name:[NSString stringWithFormat:@"myfile%d", i+1] fileName:[NSString stringWithFormat:@"myfile%d.png", i+1] mimeType:@"image/jpeg"];
//            
//
//            
//        }
        
        
        [self requestServiceImgPOSTWithURL:@"http://106.185.26.36:8080/yimian/app/blog/addData.do" withParam:dic withImgArr:nil  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *respone = responseObject;
            NSNumber *success = [respone objectForKey:@"success"];
            if ([success intValue] == 1) {
                 [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                NSString *msg = [respone objectForKey:@"message"];
                [Tools showAlertWithTitle:msg];
            }
            NSLog(@"%@",respone);
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"publish newsfeed failed");
//            [self.navigationController popViewControllerAnimated:YES];

        }];

        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)resizeScrollView{
    if (_thumbnailArray.count >= 6) {
        publishBtn.frame = CGRectMake(10, 180 + (SCREENWIDTH -60)/3.0*3, SCREENWIDTH - 20, 40);
    }else{
        publishBtn.frame = CGRectMake(10, 180 + (SCREENWIDTH -60)/3.0*2, SCREENWIDTH - 20, 40);
        
    }
    
    bgScrollView.contentSize = CGSizeMake(SCREENWIDTH, publishBtn.frame.origin.y + 50);
}

-(void)removeImgWithIndex:(int)index{
    [self deleteImageWithIndex:index];
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

-(void)gesTap:(UITapGestureRecognizer *)ges{
    [contentTextView resignFirstResponder];

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
