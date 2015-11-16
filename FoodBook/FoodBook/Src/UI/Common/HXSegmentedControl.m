//
//  HXSegmentedControl.m
//  FoodBook
//
//  Created by sansali on 15/10/12.
//  Copyright © 2015年 sansali. All rights reserved.
//

#import "HXSegmentedControl.h"

@interface HXSegmentedControl()

@property(nonatomic,strong)NSArray *items;
@property(nonatomic,strong)NSMutableArray *itemBtns;
@property(nonatomic,strong)UIButton *selectedBtn;
@end

@implementation HXSegmentedControl

#define WIDTH (SCREENWIDTH - 40)
#define SELECTEDCOLOR (THEMECOLOR)
#define UNSELECTED ([UIColor getColor:@"d2d2d4"])

- (HXSegmentedControl *)initWithItems:(NSArray *)items{
    self = [[HXSegmentedControl alloc] initWithFrame:CGRectMake(20, 10, WIDTH, 30)];
    if(self){
        
        self.backgroundColor = [UIColor getColor:@"d2d2d4"];
        self.items = items;
        [self createAll];
    }
    return self;
}

-(void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex{
    
    if (_selectedSegmentIndex != selectedSegmentIndex) {
        [_selectedBtn setSelected:NO];
        _selectedBtn.backgroundColor = UNSELECTED;
        self.selectedSegmentIndex = selectedSegmentIndex;
        
        for (UIButton *btn in _itemBtns) {
            if (btn.tag == 1000 + selectedSegmentIndex) {
                [btn setBackgroundColor:SELECTEDCOLOR];
                [btn setSelected:YES];
                _selectedBtn = btn;
                break;
            }
        }
    }
}

-(void)createAll{
    int count = [_items count];
    float itemWidth = (WIDTH - 4)/count;
    
    _itemBtns = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(itemWidth + 2),0, itemWidth , 30);
        if (i == 0) {
            [btn  setBackgroundColor:SELECTEDCOLOR];
            [btn setSelected:YES];
            _selectedBtn = btn;
        }else{
            [btn setBackgroundColor:UNSELECTED];
            [btn setSelected:NO];

        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

        [btn setTitle:_items[i] forState:UIControlStateNormal];
        btn.tag = 1000 + i;
        [btn  addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        [_itemBtns addObject:btn];
    }
}

-(void)btnClick:(UIButton *)sender{
    
    if (sender != _selectedBtn) {
        
        _selectedBtn.backgroundColor = UNSELECTED;
        [_selectedBtn setSelected:NO];
        [sender setBackgroundColor:SELECTEDCOLOR];
        [sender setSelected:YES];
        _selectedSegmentIndex = sender.tag - 1000;
        _selectedBtn = sender;
        
        _segmentChangedCallBack(_selectedSegmentIndex);
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
