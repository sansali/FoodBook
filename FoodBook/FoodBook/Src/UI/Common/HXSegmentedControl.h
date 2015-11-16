//
//  HXSegmentedControl.h
//  FoodBook
//
//  Created by sansali on 15/10/12.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXSegmentedControl : UIView

- (HXSegmentedControl *)initWithItems:( NSArray *)items;

@property(nonatomic) NSInteger selectedSegmentIndex;
@property(nonatomic,copy) void(^segmentChangedCallBack)(NSInteger selectedIndex);


@end
