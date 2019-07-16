//
//  MHProductDetailPicView.m
//  mohu
//
//  Created by 余浩 on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHProductDetailPicView.h"
#import "MHProductPicModel.h"
@interface MHProductDetailPicView ()<UIScrollViewDelegate>

@property (strong, nonatomic)UIScrollView *activityScroll;

@end
@implementation MHProductDetailPicView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor redColor];
       
    }
    return self;
}
-(void)setPictureArr:(NSMutableArray *)PictureArr
{
    if (_PictureArr != PictureArr) {
        _PictureArr = PictureArr;
        [self setupSubViews];
    }
    
}
#pragma mark private
- (void)setupSubViews
{
   
    self.activityScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
    self.activityScroll.backgroundColor = [UIColor whiteColor];
    self.activityScroll.showsHorizontalScrollIndicator = NO;
    self.activityScroll.showsVerticalScrollIndicator = NO;
    self.activityScroll.delegate =self;
 
//    UILabel *label1 = [[UILabel alloc]init];
//    label1.text = @"商品简介";
//    label1.textColor = KColorFromRGB(0x000000);
//    label1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
//    [self.activityScroll addSubview:label1];
    
    
    UILabel *labeltitle1 = [[UILabel alloc]init];
    labeltitle1.text = @"简  介";
    labeltitle1.textColor = KColorFromRGB(0x000000);
    labeltitle1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [self.activityScroll addSubview:labeltitle1];
    
    
    UILabel *labeldetail1 = [[UILabel alloc]init];
    labeldetail1.text = self.des;
    labeldetail1.textColor = KColorFromRGB(0x333333);
    //    labeldetail1.backgroundColor= kRandomColor;
    labeldetail1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [self.activityScroll addSubview:labeldetail1];
    
//    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.activityScroll.mas_left).offset(kRealValue(16));
//        make.top.equalTo(self.activityScroll.mas_top).offset(kRealValue(15));
//        make.height.mas_equalTo(kRealValue(20));
//    }];
    
    [labeltitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.activityScroll.mas_left).offset(kRealValue(16));
       make.top.equalTo(self.activityScroll.mas_top).offset(kRealValue(15));
        make.width.mas_equalTo(kRealValue(60));
        make.height.mas_equalTo(kRealValue(20));
    }];
    labeldetail1.numberOfLines = 0;
    CGRect rect = [labeldetail1.text boundingRectWithSize:CGSizeMake(kRealValue(264), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(12)]} context:nil];
    [labeldetail1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(labeltitle1.mas_right).offset(kRealValue(19));
       make.top.equalTo(self.activityScroll.mas_top).offset(kRealValue(15));
        //        make.right.equalTo(self.activityScroll.mas_right).offset(16);
        make.width.mas_equalTo(kRealValue(264));
    }];
     NSInteger btnoffset = rect.size.height + kRealValue(40);
    for (int i = 0; i < self.PictureArr.count; i++) {
        UIImageView *bgview;
        MHProductPicModel *model = [self.PictureArr objectAtIndex:i];
        if (klObjectisEmpty(model.width)) {
            bgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,btnoffset ,kScreenWidth, 2* kScreenHeight)];
            [bgview sd_setImageWithURL:[NSURL URLWithString:model.filePath] placeholderImage:kGetImage(@"img_bitmap_white")];
        }else{
            bgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,btnoffset ,kScreenWidth,([model.height integerValue] *kScreenWidth /[model.width integerValue]))];
            [bgview sd_setImageWithURL:[NSURL URLWithString:model.filePath] placeholderImage:kGetImage(@"img_bitmap_white") ];
        }
        btnoffset = btnoffset + ([model.height integerValue] *kScreenWidth /[model.width integerValue]);
        [self.activityScroll addSubview:bgview];
    }
    if ((btnoffset +kTopHeight +kRealValue(44) +kBottomHeight) < kScreenHeight) {
        self.activityScroll.contentSize = CGSizeMake(kScreenWidth,kScreenHeight + kRealValue(40));
    }else{
        self.activityScroll.contentSize = CGSizeMake(kScreenWidth,btnoffset +kTopHeight +kRealValue(50) +kBottomHeight);
    }
    [self addSubview:self.activityScroll];
    if (@available(iOS 11.0, *)) {
        self.activityScroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
//       self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
#pragma mark ---- scrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat offsetY = scrollView.contentOffset.y;
    MHLog(@"%f",offsetY);
    if (offsetY <= -100) {
        if (self.activityScroll && [self.PicViewDelegate respondsToSelector:@selector(pullDragAndShowProduct)]) {
            [self.PicViewDelegate pullDragAndShowProduct];
        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
   
    //禁止左右滑动左右
    self.activityScroll.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
