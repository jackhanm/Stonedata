//
//  MHLevelShareCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/27.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHLevelShareCell.h"

@implementation MHLevelShareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#d8011f"];
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(10), 0, kRealValue(355), kRealValue(400))];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
 
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_bgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(kRealValue(5), kRealValue(5))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        _bgView.layer.mask = maskLayer;
        
        
        NSArray *array = [NSArray arrayWithObjects:@"邀请记录",@"奖励榜单", nil];
        _segment = [[UISegmentedControl alloc]initWithItems:array];
      
 
        _segment.frame = CGRectMake(0, kRealValue(3), kRealValue(218), kRealValue(30));
        _segment.selectedSegmentIndex = 0;
        _segment.backgroundColor = [UIColor whiteColor];
        ViewBorderRadius(_segment, kRealValue(15), 1, [UIColor colorWithHexString:@"#d8011f"]);
        [_segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
        _segment.selectedSegmentIndex = 0;
        _segment.centerX = kRealValue(343)/2;
        _segment.tintColor = [UIColor colorWithHexString:@"#d8011f"];
        [_bgView addSubview:_segment];
        
    }
    return self;
}


-(void)segmentValueChanged:(UISegmentedControl *)seg{
    if (seg.selectedSegmentIndex == 0) {
        _scrollView2.hidden = YES;
         _scrollView1.hidden = NO;
    }else{
        _scrollView2.hidden = NO;
        _scrollView1.hidden = YES;
    }
}

-(void)setBangdanArr:(NSMutableArray *)bangdanArr{
    _bangdanArr = bangdanArr;
    if (!_scrollView2) {
        _scrollView2 = [[MHVIPlistScrollview alloc]initWithFrame:CGRectMake(kRealValue(10), kRealValue(40), kRealValue(335), kRealValue(350)) array:_bangdanArr];
        _scrollView2.hidden = YES;
        ViewBorderRadius(_scrollView2, 4, 1/kScreenScale, [UIColor colorWithHexString:@"#FF125D"]);
        [_bgView addSubview:_scrollView2];
    }
}


-(void)setYaoqingArr:(NSMutableArray *)yaoqingArr{
    _yaoqingArr = yaoqingArr;
    if (!_scrollView1) {
        _scrollView1 = [[MHVIPlistScrollview alloc]initWithFrame:CGRectMake(kRealValue(10), kRealValue(40), kRealValue(335), kRealValue(350)) array:_yaoqingArr];
        _scrollView1.hidden = NO;
        ViewBorderRadius(_scrollView1, 4, 1/kScreenScale, [UIColor colorWithHexString:@"#FF125D"]);
        [_bgView addSubview:_scrollView1];
    }
}


@end
