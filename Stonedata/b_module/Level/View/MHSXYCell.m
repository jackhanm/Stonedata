//
//  MHSXYCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/27.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHSXYCell.h"
#import "MHWebviewViewController.h"
#import "MHProDetailViewController.h"
#import "MHPriceMoreViewController.h"
#import "MHHuGuessViewController.h"
//#import "MHPageItemModel.h"

#define PADDING kRealValue(2.5)
@interface MHSXYCell()
@property (nonatomic, strong) UIScrollView *activityScroll;
@end
@implementation MHSXYCell



-(void)setMHfuliArr:(NSArray *)MHfuliArr{
     _MHfuliArr = MHfuliArr;
    [self.activityScroll removeAllSubviews];
    self.activityScroll = nil;
    [self addSubview:self.activityScroll];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {


    }
    return self;
}

-(UIScrollView *)activityScroll{
    if (!_activityScroll) {
        _activityScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kRealValue(103))];
        _activityScroll.backgroundColor = [UIColor whiteColor];
        _activityScroll.showsHorizontalScrollIndicator = NO;
        _activityScroll.showsVerticalScrollIndicator = NO;
        NSInteger btnoffset = 0;
        float originX  = 0;
        for (int i = 0; i < self.MHfuliArr.count; i++) {
            if (i == 0) {
                originX = kRealValue(16);
            }else{
                originX = PADDING*2+btnoffset;
            }
            UIImageView *bgview = [[UIImageView alloc]initWithFrame:CGRectMake(originX,0, kRealValue(166), kRealValue(93))];
            btnoffset = CGRectGetMaxX(bgview.frame);
            bgview.userInteractionEnabled = YES;
            [bgview sd_setImageWithURL:[NSURL URLWithString:self.MHfuliArr[i][@"sourceUrl"]] placeholderImage:kGetImage(@"")];
            bgview.layer.masksToBounds = YES;
            bgview.layer.cornerRadius = kRealValue(5);
             bgview.tag = 70000+i;
            [_activityScroll addSubview:bgview];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [bgview addGestureRecognizer:tap];
        }
        _activityScroll.contentSize = CGSizeMake(btnoffset+kRealValue(20), kRealValue(103));
    }
    return _activityScroll;
}


-(void)OnTapBtnView:(UITapGestureRecognizer *)sender{

    NSDictionary *sxydict = _MHfuliArr[sender.view.tag-70000];
    if ([sxydict[@"actionUrlType"] integerValue] == 0) {
        //web
        MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:sxydict[@"actionUrl"] comefrom:@"LauchImage"];
        
        [self.cellVC.navigationController pushViewController:vc animated:YES];
    }else{
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[sxydict[@"actionUrl"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
        if ([dict[@"code"] integerValue] == 5) {
            //产品详情
            MHProDetailViewController *vc = [[MHProDetailViewController alloc]init];
            vc.productId = [NSString stringWithFormat:@"%@",dict[@"param"]];
            [self.cellVC.navigationController pushViewController:vc animated:YES];
        }
        if ([dict[@"code"] integerValue] == 7) {
            //奖多多
            MHPriceMoreViewController *vc = [[MHPriceMoreViewController alloc]init];
            [self.cellVC.navigationController pushViewController:vc animated:YES];
        }
        if ([dict[@"code"] integerValue] == 8) {
            //胡猜
            MHHuGuessViewController *vc = [[MHHuGuessViewController alloc]init];
          [self.cellVC.navigationController pushViewController:vc animated:YES];
        }
    }
}


@end
