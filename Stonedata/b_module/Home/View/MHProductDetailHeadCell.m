//
//  MHProductDetailHeadCell.m
//  mohu
//
//  Created by 余浩 on 2018/9/19.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHProductDetailHeadCell.h"
#import "MHProductDetailCellHead.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "MHBannerProductItem.h"
#import "MHPageItemModel.h"

#import "MHProductPicModel.h"
@interface MHProductDetailHeadCell()<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@end

@implementation MHProductDetailHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = KColorFromRGB(0xF0F1F4);
       
    }
    return self;
}
-(void)setDic:(NSMutableDictionary *)dic
{
    _dic  = dic;
    [self createview];
    //判断上下架状态
    if ([[NSString stringWithFormat:@"%@",[dic valueForKey:@"updown"]] isEqualToString:@"0"]) {
        self.likebt.selected = NO;
        self.likelabel.text =@"上架";
    }else{
        self.likebt.selected = YES;
        self.likelabel.text =@"下架";
    }
    //产品名字
//    self.titlelabel.text = [dic valueForKey:@"productName"];
    UIImage *image = [UIImage imageNamed:@"biqan"];
    NSMutableAttributedString *attachment = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeScaleToFill attachmentSize:CGSizeMake(kRealValue(60), kRealValue(18)) alignToFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(17)] alignment:YYTextVerticalAlignmentCenter];
    NSMutableAttributedString *errorDesc = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",[dic valueForKey:@"productName"]]];
    errorDesc.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(17)];
    errorDesc.color = [UIColor colorWithHexString:@"000000"];
    [attachment appendAttributedString: errorDesc];
    self.titlelabel.attributedText = attachment;
    
    if (klStringisEmpty([GVUserDefaults standardUserDefaults].userRole)) {
        [ self.currentPrice setAttributedText:[NSString stringWithFormat:@"¥%@",[dic valueForKey:@"retailPrice"]] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"ffffff"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(21)]}];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",[dic valueForKey:@"marketPrice"]] attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleNone)}];
        [attrStr setAttributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
                                 NSBaselineOffsetAttributeName : @0} range:NSMakeRange(0, [NSString stringWithFormat:@"%@",[dic valueForKey:@"marketPrice"]].length+1 )];
        
        self.originalPrice.attributedText = attrStr;
    }else{
        if ([[GVUserDefaults standardUserDefaults].userRole integerValue]<2) {
            [ self.currentPrice setAttributedText:[NSString stringWithFormat:@"¥%@",[dic valueForKey:@"retailPrice"]] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"ffffff"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(21)]}];
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",[dic valueForKey:@"marketPrice"]] attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleNone)}];
            [attrStr setAttributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
                                     NSBaselineOffsetAttributeName : @0} range:NSMakeRange(0, [NSString stringWithFormat:@"%@",[dic valueForKey:@"marketPrice"]].length+1 )];
            
            self.originalPrice.attributedText = attrStr;
        }else{
            [ self.currentPrice setAttributedText:[NSString stringWithFormat:@"¥%@",[dic valueForKey:@"retailPrice"]] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"ffffff"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(21)]}];
            self.originalPrice.text = [NSString stringWithFormat:@" 可赚: ¥%@    ",[dic valueForKey:@"marketPrice"]];
            self.originalPrice.textColor= KColorFromRGB(0xffdf7d);
            self.originalPrice.layer.borderColor =KColorFromRGB(0xffdf7d).CGColor;
            self.originalPrice.layer.borderWidth = 1/ kScreenScale;
            self.originalPrice.layer.masksToBounds =YES;
            self.originalPrice.layer.cornerRadius = kRealValue(11);
        }
    }
    
   //已售
    self.SalelNum.text=  [NSString stringWithFormat:@"已售:%@",[dic valueForKey:@"sellCount"]];
    //商品信息
    NSMutableArray *arr = [dic valueForKey:@"skuList"];
    if (arr.count > 0) {
        self.choseePropertyView.RightitleLabel.text = [arr[0] valueForKey:@"attribute"];
    }
    
    //限时抢购
     if (self.CellrestTimer > 0 ) {
         self.secondelabel.hidden = NO;
         self.minutelabel.hidden = NO;
         self.hourlabel.hidden = NO;
         self.labeltitle.hidden = NO;
         self.maohao1.hidden = NO;
          self.maohao2.hidden = NO;
     }else{
         self.secondelabel.hidden = YES;
         self.minutelabel.hidden = YES;
         self.hourlabel.hidden = YES;
         self.labeltitle.hidden = YES;
         self.maohao1.hidden = YES;
         self.maohao2.hidden = YES;
     }
    
}
-(void)setExpandDic:(NSMutableDictionary *)expandDic
{
    _expandDic  = expandDic;
    if (!klObjectisEmpty(expandDic) ) {
        if (!klObjectisEmpty([expandDic valueForKey:@"userRole"])   ) {
            NSString *str =[NSString stringWithFormat:@"%@",[expandDic valueForKey:@"userRole"]];
            if ( [str integerValue] >1.5) {
                self.likelabel.hidden = NO;
                self.likebt.hidden = NO;
            }else{
                self.likelabel.hidden = YES;
                self.likebt.hidden =YES;
            }
        }
        
    }else{
        self.likelabel.hidden = YES;
        self.likebt.hidden =YES;
    }
}
-(void)setBannerArr:(NSMutableArray *)bannerArr
{
    if (_bannerArr != bannerArr) {
        _bannerArr = bannerArr;
        _pageControl.numberOfPages = self.bannerArr.count;
        [self.headImgScrollview reloadData];
    }
    
}
-(void)createview
{
    // 滑动图
    [self addSubview:self.headImgScrollview];
    //限时抢购
    [self addSubview:self.limitTimeBuy];
    //商品价格显示
    [self addSubview:self.titleImageView];
    [ self addPricelabel];
    //商品规格显示
    [self addSubview:self.titlebgView];
    [ self addTitlelabel];
    UIView *linebg =  [[UIView alloc]initWithFrame:CGRectMake(0, self.titlebgView.frame.size.height + self.titlebgView.frame.origin.y, kScreenWidth, 1/kScreenScale)];
    linebg.backgroundColor = KColorFromRGB(0xF0F1F4);
//    linebg.backgroundColor = [UIColor redColor];
    [self addSubview:linebg];
    //属性和运费
     [self addSubview:self.SizebgView];
    
    UIView *linebg1 =  [[UIView alloc]initWithFrame:CGRectMake(0, self.SizebgView.frame.size.height + self.SizebgView.frame.origin.y, kScreenWidth,  1/kScreenScale)];
    linebg1.backgroundColor = KColorFromRGB(0xF0F1F4);
//    linebg.backgroundColor = [UIColor redColor];
    [self addSubview:linebg1];
    [self addSubview:self.SizebgView];
    UIView *linebg2 =  [[UIView alloc]initWithFrame:CGRectMake(0, self.SizebgView.frame.size.height + self.SizebgView.frame.origin.y, kScreenWidth,  1/kScreenScale)];
    linebg2.backgroundColor = KColorFromRGB(0xF0F1F4);
//    linebg.backgroundColor = [UIColor redColor];
    [self addSubview:linebg2];
    [self addSubview:self.SaledPicView];
    

    
    
}
#pragma mark
-(UIImageView *)headImgView
{
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc]init];
//        _headImgView.backgroundColor = kRandomColor;
        
    }
    return _headImgView;
}
-(TYCyclePagerView *)headImgScrollview
{
    if (!_headImgScrollview) {
        _headImgScrollview = [[TYCyclePagerView alloc]init];
        _headImgScrollview.frame =CGRectMake(0,0, kScreenWidth, kScreenWidth);
        
        _headImgScrollview.isInfiniteLoop = YES;
        _headImgScrollview.autoScrollInterval = 5;
        _headImgScrollview.dataSource = self;
        _headImgScrollview.delegate = self;
        // registerClass or registerNib
        [_headImgScrollview registerClass:[MHBannerProductItem class] forCellWithReuseIdentifier:@"cellId"];
        TYPageControl *pageControl = [[TYPageControl alloc]init];
        pageControl.frame = CGRectMake(0, CGRectGetHeight(_headImgScrollview.frame) - 26, CGRectGetWidth(_headImgScrollview.frame), 26);
        //pageControl.numberOfPages = _datas.count;
        pageControl.currentPageIndicatorSize = CGSizeMake(12, 3);
        pageControl.pageIndicatorSize = CGSizeMake(8, 3);
        pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"000000" andAlpha:.4];
        //    pageControl.pageIndicatorImage = [UIImage imageNamed:@"Dot"];
        //    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"DotSelected"];
        //    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
        //    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
        [_headImgScrollview addSubview:pageControl];
        _pageControl = pageControl;

    }
    return _headImgScrollview;
}
-(UIView *)limitTimeBuy
{
    if (!_limitTimeBuy) {
        if (self.CellrestTimer > 0 ) {
            _limitTimeBuy =[[UIView alloc]initWithFrame:CGRectMake(0, self.headImgScrollview.frame.size.height, kScreenWidth,kRealValue(0))];
        }else{
            _limitTimeBuy =[[UIView alloc]initWithFrame:CGRectMake(0, self.headImgScrollview.frame.size.height, kScreenWidth,0)];
        }
        
        
        _limitTimeBuy.backgroundColor = [UIColor colorWithHexString:@"#3298FF"];
        UILabel *labeltitle = [[UILabel alloc]init];
        labeltitle.text = @"活动进行中";
        labeltitle.textColor = [UIColor whiteColor];
        labeltitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        labeltitle.textAlignment = NSTextAlignmentCenter;
        labeltitle.frame = CGRectMake(kRealValue(16), 0, kRealValue(70), self.limitTimeBuy.frame.size.height);
        [_limitTimeBuy addSubview:labeltitle];
        self.labeltime = [[UILabel alloc]init];
        self.labeltime .text = @"";
        self.labeltime .textColor = [UIColor whiteColor];
        self.labeltime.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        self.labeltime.textAlignment = NSTextAlignmentCenter;
        self.labeltime.frame = CGRectMake(labeltitle.frame.size.width + labeltitle.frame.origin.x, 0, kScreenWidth-self.labeltime.frame.origin.x - kRealValue(16), self.limitTimeBuy.frame.size.height);
        [_limitTimeBuy addSubview:self.labeltime];
        
    }
    return _limitTimeBuy;
}


-(UIImageView *)titleImageView
{
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]init];
        _titleImageView.frame = CGRectMake(0, self.limitTimeBuy.frame.origin.y +self.limitTimeBuy.frame.size.height, kScreenWidth, kRealValue(60));
        _titleImageView.image = kGetImage(@"timebg");
//        _titleImageView.backgroundColor = KColorFromRGB(0xFE5432);
    }
    
    return _titleImageView;
}
-(void)addPricelabel
{
    self.currentPrice = [[RichStyleLabel alloc]init];
    self.currentPrice.textAlignment = NSTextAlignmentLeft;
    self.currentPrice.textColor = [UIColor whiteColor];
    self.currentPrice.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
//    self.currentPrice.textAlignment = NSTextAlignmentCenter;
    [self.titleImageView addSubview:self.currentPrice];
    [self.currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImageView.mas_left).offset(kRealValue(16));
        make.top.equalTo(self.titleImageView.mas_top).offset(kRealValue(5));
    }];


    self.originalPrice = [[UILabel alloc]init];
    self.originalPrice.textColor = KColorFromRGB(0xffffff);
    self.originalPrice.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    self.originalPrice.textAlignment = NSTextAlignmentCenter;
    [self.titleImageView addSubview:self.originalPrice];
    [self.originalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentPrice.mas_right).offset(kRealValue(10));
        make.centerY.equalTo(self.currentPrice.mas_centerY);
        make.height.mas_equalTo(kRealValue(22));
    }];

    
    
    self.SalelNum = [[UILabel alloc]init];
    self.SalelNum.textColor = KColorFromRGB(0xf6c0a4);
    self.SalelNum.text = @"已售:444";
    self.SalelNum.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.SalelNum.textAlignment = NSTextAlignmentRight;
    [self.titleImageView addSubview:self.SalelNum];
    [self.SalelNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImageView.mas_left).offset(kRealValue(16));
        make.top.equalTo(self.originalPrice.mas_bottom).offset(kRealValue(5));
    }];

    
    self.labeltitle = [[UILabel alloc]init];
    self.labeltitle.text = @"距离活动结束还剩";
    self.labeltitle.textColor = [UIColor whiteColor];
    self.labeltitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.labeltitle.textAlignment = NSTextAlignmentCenter;
//    labeltitle.frame = CGRectMake(kRealValue(16), 0, kRealValue(70), self.limitTimeBuy.frame.size.height);
    [self.titleImageView addSubview:self.labeltitle];
    [self.labeltitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleImageView.mas_right).offset(-kRealValue(16));
        make.centerY.equalTo(self.currentPrice.mas_centerY);
    }];
    
    
    self.secondelabel  = [[UILabel alloc]init];
    self.secondelabel.text = @"00";
    self.secondelabel.textColor = KColorFromRGB(0xf74916);
    self.secondelabel.backgroundColor = [UIColor whiteColor];
    self.secondelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    self.secondelabel.textAlignment = NSTextAlignmentCenter;
    //    labeltitle.frame = CGRectMake(kRealValue(16), 0, kRealValue(70), self.limitTimeBuy.frame.size.height);
    [self.titleImageView addSubview:self.secondelabel];
    [self.secondelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleImageView.mas_right).offset(-kRealValue(16));
        make.bottom.equalTo(self.SalelNum.mas_bottom).offset(-kRealValue(4));
        make.width.mas_equalTo(kRealValue(20));
        make.height.mas_equalTo(kRealValue(18));
    }];
    self.secondelabel.layer.masksToBounds = YES;
    self.secondelabel.layer.cornerRadius = kRealValue(4);
    
    self.maohao1  = [[UILabel alloc]init];
    self.maohao1.text = @":";
    self.maohao1.textColor = KColorFromRGB(0xffffff);
    self.maohao1.backgroundColor = KColorFromRGB(0xFE8619);
    self.maohao1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    self.maohao1.textAlignment = NSTextAlignmentCenter;
    [self.titleImageView addSubview:self.maohao1];
    [self.maohao1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.secondelabel.mas_left).offset(kRealValue(0));
        make.bottom.equalTo(self.SalelNum.mas_bottom).offset(-kRealValue(5));
        make.width.mas_equalTo(kRealValue(12));
        make.height.mas_equalTo(kRealValue(18));
    }];
  
    self.minutelabel  = [[UILabel alloc]init];
    self.minutelabel.text = @"00";
    self.minutelabel.textColor = KColorFromRGB(0xf74916);
    self.minutelabel.backgroundColor = [UIColor whiteColor];
    self.minutelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    self.minutelabel.textAlignment = NSTextAlignmentCenter;
    //    labeltitle.frame = CGRectMake(kRealValue(16), 0, kRealValue(70), self.limitTimeBuy.frame.size.height);
    [self.titleImageView addSubview:self.minutelabel];
    [self.minutelabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.equalTo(self.maohao1.mas_left).offset(kRealValue(0));
        make.bottom.equalTo(self.SalelNum.mas_bottom).offset(-kRealValue(4));
        make.width.mas_equalTo(kRealValue(20));
        make.height.mas_equalTo(kRealValue(18));
    }];
    self.minutelabel.layer.masksToBounds = YES;
    self.minutelabel.layer.cornerRadius = kRealValue(4);
    self.maohao2  = [[UILabel alloc]init];
    self.maohao2 .text = @":";
    self.maohao2 .textColor = KColorFromRGB(0xffffff);
    self.maohao2 .backgroundColor = KColorFromRGB(0xFE8619);
    self.maohao2 .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    self.maohao2 .textAlignment = NSTextAlignmentCenter;
    [self.titleImageView addSubview:self.maohao2 ];
    [self.maohao2  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.minutelabel.mas_left).offset(kRealValue(0));
        make.bottom.equalTo(self.SalelNum.mas_bottom).offset(-kRealValue(5));
        make.width.mas_equalTo(kRealValue(12));
        make.height.mas_equalTo(kRealValue(18));
    }];
    self.hourlabel  = [[UILabel alloc]init];
    self.hourlabel .text = @"00";
    self.hourlabel .textColor = KColorFromRGB(0xf74916);
    self.hourlabel .backgroundColor = [UIColor whiteColor];
    self.hourlabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    self.hourlabel .textAlignment = NSTextAlignmentCenter;
    //    labeltitle.frame = CGRectMake(kRealValue(16), 0, kRealValue(70), self.limitTimeBuy.frame.size.height);
    [self.titleImageView addSubview:self.hourlabel ];
    [self.hourlabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.maohao2 .mas_left).offset(kRealValue(0));
        make.bottom.equalTo(self.SalelNum.mas_bottom).offset(-kRealValue(4));
        make.width.mas_equalTo(kRealValue(20));
        make.height.mas_equalTo(kRealValue(18));
    }];
    self.hourlabel .layer.masksToBounds = YES;
    self.hourlabel .layer.cornerRadius = kRealValue(4);
    
    
    
    
    self.labeltime = [[UILabel alloc]init];
    self.labeltime.text = @"";
    self.labeltime.textColor = [UIColor whiteColor];
    self.labeltime.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    self.labeltime.textAlignment = NSTextAlignmentCenter;
    self.labeltime.frame = CGRectMake(self.labeltitle.frame.size.width + self.labeltitle.frame.origin.x, 0, kScreenWidth-self.labeltime.frame.origin.x - kRealValue(16), self.limitTimeBuy.frame.size.height);
//    [self.titleImageView addSubview:self.labeltime];
    
    
}
-(UIView *)titlebgView
{
    if (!_titlebgView) {
        _titlebgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.titleImageView.frame.size.height +self.titleImageView.frame.origin.y, kScreenWidth, kRealValue(76))];
        _titlebgView.backgroundColor = [UIColor whiteColor];
//        Anessa安热沙资生堂小金瓶防晒乳60ml (防晒霜 小金瓶 防水防汗 资生堂防晒) w:594*h:68
       
    }
    return _titlebgView;
}
-(void)addTitlelabel
{
    
    
    self.sharebt = [UIButton buttonWithType:UIButtonTypeCustom];
    [ self.sharebt setImage:kGetImage(@"share") forState:UIControlStateNormal];
    [ self.sharebt setImage:kGetImage(@"share") forState:UIControlStateSelected];
    [self.sharebt addTarget:self action:@selector(shareAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.titlebgView addSubview: self.sharebt];
    [ self.sharebt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titlebgView.mas_top).offset(kRealValue(19));
        make.right.equalTo(self.titlebgView.mas_right).offset(kRealValue(-16));
        make.width.mas_equalTo(kRealValue(22));
        make.height.mas_equalTo(kRealValue(22));
    }];
    
    self.likebt = [UIButton buttonWithType:UIButtonTypeCustom];
    [ self.likebt setImage:kGetImage(@"share") forState:UIControlStateNormal];
    [ self.likebt setImage:kGetImage(@"share") forState:UIControlStateSelected];
    [self.likebt addTarget:self action:@selector(shopAddproduct:) forControlEvents:UIControlEventTouchUpInside];
//    [self.titlebgView addSubview: self.likebt];
//    [ self.likebt mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.titlebgView.mas_top).offset(kRealValue(19));
//        make.right.equalTo(self.titlebgView.mas_right).offset(kRealValue(-16));
//        make.width.mas_equalTo(kRealValue(22));
//        make.height.mas_equalTo(kRealValue(22));
//    }];

    self.likelabel = [[UILabel alloc]init];
    self.likelabel.textColor = KColorFromRGB(0x666666);
    self.likelabel.text = @"上架";
    self.likelabel.userInteractionEnabled =YES;
    self.likelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.likelabel.textAlignment = NSTextAlignmentRight;

//    [self.titlebgView addSubview:self.likelabel];
//    UITapGestureRecognizer *labeluptap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labeluptapAct)];
//    [self.likelabel addGestureRecognizer:labeluptap];
//
//    [self.likelabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo( self.likebt.mas_bottom).offset(kRealValue(5));
//        make.right.equalTo(self.titlebgView.mas_right).offset(kRealValue(-16));
//        make.width.mas_equalTo(kRealValue(50));
//    }];
    
    self.titlelabel = [[YYLabel alloc]init];
    self.titlelabel.textColor = [UIColor blackColor];
  //  self.titlelabel.text = @"Anessa安热沙资生堂小金瓶防晒乳60ml (防晒霜 小金瓶 防水防汗 资生堂防晒) w:594*h:68";
    self.titlelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(17)];
    self.titlelabel.textAlignment = NSTextAlignmentLeft;
    self.titlelabel.numberOfLines = 2;
    [self.titlebgView addSubview:self.titlelabel];
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.sharebt.mas_left).offset(-kRealValue(16));
        make.centerY.equalTo(self.titlebgView.mas_centerY);
        make.left.equalTo(self.titlebgView.mas_left).offset(kRealValue(16));
        make.height.mas_equalTo(self.titlebgView.mas_height);
    }];
   
}
-(void)shareAct:(UIButton *)sender
{
    if (self.ShowshareAlert) {
        self.ShowshareAlert();
    }
}
-(void)shopAddproduct:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected == NO) {
        if (self.productUpAct) {
            self.productUpAct(0);
        }
    }else{
        if (self.productUpAct) {
            self.productUpAct(1);
        }
    }
    

}
-(void)labeluptapAct
{
    if (self.productUpAct) {
        self.productUpAct(!self.likebt.selected);
    }
}
-(UIView *)SizebgView
{
    if (!_SizebgView) {
        _SizebgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.titlebgView.frame.size.height +self.titlebgView.frame.origin.y+ kRealValue(1), kScreenWidth,kRealValue(98))];
        _SizebgView.backgroundColor = [UIColor whiteColor];

        self.choseePropertyView = [[MHProductDetailCellHead alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(47)) title:@"规格参数" rightTitle:@"请选择" isShowRight:YES];
        self.choseePropertyView.selectact = ^(NSString *productID, NSString *brandID) {
            self.chooseSizeAct(@"", @"");
            
        };
        [_SizebgView addSubview:self.choseePropertyView];
        
        UIView *linebg1 =  [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), 0, kScreenWidth, 1/kScreenScale)];
        linebg1.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        [self.choseePropertyView addSubview:linebg1];

        MHProductDetailCellHead *GoodtrasportView = [[MHProductDetailCellHead alloc]initWithFrame:CGRectMake(0, kRealValue(47), kScreenWidth, kRealValue(48)) title:@"商品运费" rightTitle:@"免运费" isShowRight:NO];
        [_SizebgView addSubview:GoodtrasportView];
        
        UIView *linebg =  [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), 1/kScreenScale, kScreenWidth, 1/kScreenScale)];
        linebg.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        [GoodtrasportView addSubview:linebg];
        
//        UIView *linebg2 =  [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(47), kScreenWidth, 1/kScreenScale)];
//        linebg2.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
//        [GoodtrasportView addSubview:linebg2];
       
        
    }
    return _SizebgView;
}
-(UIImageView *)SaledPicView
{
    if (!_SaledPicView) {
        _SaledPicView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.SizebgView.frame.size.height +self.SizebgView.frame.origin.y +kRealValue(10), kScreenWidth, kRealValue(69))];
//        _SaledPicView.backgroundColor = kRandomColor;
        _SaledPicView.image = kGetImage(@"img_product_safety");
    }
    return _SaledPicView;
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.bannerArr.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    MHBannerProductItem *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    //    cell.backgroundColor = kRandomColor;
    cell.img.height = kScreenWidth;
    MHProductPicModel *model = self.bannerArr[index];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.filePath]  placeholderImage:kGetImage(@"img_bitmap_white")];
    
    
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake( kScreenWidth , kScreenWidth);
    layout.layoutType=TYCyclePagerTransformLayoutNormal;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
    MHLog(@"%ld ->  %ld",fromIndex,toIndex);
}

@end
