//
//  NewsFeedTableViewCell.h
//  FoodBook
//
//  Created by sansali on 15/9/30.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoodData;

@protocol moodCellDelegate <NSObject>

-(void)tapPreviewWithIndex:(int)index withData:(NSMutableArray *)data;

@end

@interface MoodTableViewCell : UITableViewCell

@property(nonatomic,weak)id<moodCellDelegate> delegate;

-(void)refreshViewWithData:(MoodData *)data;

@end
