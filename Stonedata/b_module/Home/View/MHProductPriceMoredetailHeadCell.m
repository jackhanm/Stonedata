//
//  MHProductPriceMoredetailHeadCell.m
//  mohu
//
//  Created by yuhao on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHProductPriceMoredetailHeadCell.h"
#import "MHProductDetailCellHead.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "MHBannerProductItem.h"
#import "MHPageItemModel.h"
#import "MHProductPicModel.h"
@interface MHProductPriceMoredetailHeadCell()<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@end
@implementation MHProductPriceMoredetailHeadCell

-(void)setDic:(NSMutableDictionary *)dic
{
    _dic = dic;
     [self createviewDic:dic];
    //判断上下架状态
    if ([[NSString stringWithFormat:@"%@",[dic valueForKey:@"updown"]] isEqualToString:@"0"]) {
        self.likebt.selected = NO;
        self.likelabel.text =@"上架";
    }else{
        self.likebt.selected = YES;
        self.likelabel.text =@"下架";
    }
    //产品名字
    UIImage *image = [UIImage imageNamed:@"biqan"];
    NSMutableAttributedString *attachment = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeScaleToFill attachmentSize:CGSizeMake(kRealValue(60), kRealValue(18)) alignToFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(17)] alignment:YYTextVerticalAlignmentCenter];
    NSMutableAttributedString *errorDesc = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",[dic valueForKey:@"productName"]]];
    errorDesc.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(17)];
    errorDesc.color = [UIColor colorWithHexString:@"000000"];
    [attachment appendAttributedString: errorDesc];
    self.titlelabel.attributedText = attachment;
    
    [ self.currentPrice setAttributedText:[NSString stringWithFormat:@"¥%@",[dic valueForKey:@"productPrice"]] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"ffffff"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(21)]}];
    
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",[dic valueForKey:@"marketPrice"]] attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleNone)}];
//    [attrStr setAttributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
//                             NSBaselineOffsetAttributeName : @0} range:NSMakeRange(0, [NSString stringWithFormat:@"%@",[dic valueForKey:@"marketPrice"]].length )];
//
//    self.originalPrice.attributedText = attrStr;
    self.SalelNum.text=  [NSString stringWithFormat:@"活动场次 : %@",[dic valueForKey:@"shareCount"]];
    
    
    NSString *str = [self.dic valueForKey:@"status"];
    
    if ([str isEqualToString:@"UNOPENED"]||[str isEqualToString:@"OPENED"]||[str isEqualToString:@"INVALID"]) {
        self.secondelabel.hidden =YES;
        self.minutelabel.hidden =YES;
        self.hourlabel.hidden =YES;
        self.maohao1.hidden = YES;
        self.maohao2.hidden = YES;
        self.labeltitle.hidden = YES;
        
    }
    
    
    
   
    
    
    
}
-(void)setExpandDic:(NSMutableDictionary *)expandDic
{
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
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = KColorFromRGB(0xF0F1F4);
       
    }
    return self;
}
-(void)setBannerArr:(NSMutableArray *)bannerArr
{
    if (_bannerArr != bannerArr) {
        _bannerArr = bannerArr;
        self.pageControl.numberOfPages = bannerArr.count;
        [self.headImgScrollview reloadData];
    }
    
}
-(void)createviewDic:(NSMutableDictionary *)dic
{
    // 滑动图
    [self addSubview:self.headImgScrollview];
    [_headImgScrollview reloadData];
    //限时抢购
    [self addSubview:self.limitTimeBuy];
    //商品价格显示
    [self addSubview:self.titleImageView];
    [ self addPricelabel];
    //商品规格显示
    [self addSubview:self.titlebgView];
    [ self addTitlelabel];
    UIView *linebg =  [[UIView alloc]initWithFrame:CGRectMake(0, self.titlebgView.frame.size.height + self.titlebgView.frame.origin.y, kScreenWidth, kRealValue(10))];
    linebg.backgroundColor = KColorFromRGB(0xF0F1F4);
    [self addSubview:linebg];
    //中奖名单
    [self addSubview:self.prizeView];
    UILabel *prizePersonlabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(10), kRealValue(60), kRealValue(20))];
    prizePersonlabel.text =@"中奖好友";
    prizePersonlabel.textAlignment =NSTextAlignmentLeft;
    prizePersonlabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
    [self.prizeView addSubview:prizePersonlabel];
    
    UIImageView *prizePersonImage = [[UIImageView alloc]init];
//    prizePersonImage.backgroundColor = kRandomColor;
    
    [self.prizeView addSubview:prizePersonImage];
    [prizePersonImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo( prizePersonlabel.mas_bottom).offset(kRealValue(15));
        make.left.equalTo(prizePersonlabel.mas_left).offset(kRealValue(0));
        make.width.height.mas_equalTo(kRealValue(30));
    }];
    prizePersonImage.layer.masksToBounds = YES;
    prizePersonImage.layer.cornerRadius = kRealValue(15);
    [prizePersonImage sd_setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"winnerUserImage"]] placeholderImage:kGetImage(@"user_pic")];
    UILabel *prizePersonNamelabel = [[UILabel alloc]init];
    prizePersonNamelabel.text =[dic valueForKey:@"winnerUserNickName"];
    prizePersonNamelabel.textColor = KColorFromRGB(0x000000);
    prizePersonNamelabel.textAlignment =NSTextAlignmentLeft;
    prizePersonNamelabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
    [self.prizeView addSubview:prizePersonNamelabel];
    [prizePersonNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(prizePersonImage.mas_centerY);
        make.left.equalTo(prizePersonImage.mas_right).offset(kRealValue(10));
        
    }];
    
    UILabel *prizePersonPricelabel = [[UILabel alloc]init];
    prizePersonPricelabel.text =@"竞中价¥201元";
    prizePersonPricelabel.textColor = KColorFromRGB(0x666666);
    prizePersonPricelabel.textAlignment =NSTextAlignmentLeft;
    prizePersonPricelabel.hidden =YES;
    prizePersonPricelabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
    [self.prizeView addSubview:prizePersonPricelabel];
    [prizePersonPricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(prizePersonImage.mas_centerY);
        make.right.equalTo(self.prizeView.mas_right).offset(kRealValue(-16));
        
    }];
    
    
    //参团好友
    
    [self addSubview:self.prizenumView];
    
    UILabel *prizenumViewlabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(10), kRealValue(60), kRealValue(20))];
    prizenumViewlabel.text =@"参团好友";
    prizenumViewlabel.textAlignment =NSTextAlignmentLeft;
    prizenumViewlabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
   
    [self.prizenumView addSubview:prizenumViewlabel];
    
    UILabel *prizenumlabel2 = [[UILabel alloc]init];
//    NSString *prizenumlabel2text =[]
    NSString *drawnumpersion = [NSString stringWithFormat:@"%@",[dic valueForKey:@"drawNumber"]] ;
    NSInteger drawnumpersionnum = [drawnumpersion  integerValue];
    

    if ([[dic valueForKey:@"userList"] count] == 0 ) {
        prizenumlabel2.text =[NSString stringWithFormat:@"0/%ld",drawnumpersionnum];
    }else
    {
        prizenumlabel2.text =[NSString stringWithFormat:@"%ld/%ld",[[dic valueForKey:@"userList"] count],drawnumpersionnum];
    }
    
    prizenumlabel2.textAlignment =NSTextAlignmentLeft;
    prizenumlabel2.textColor = KColorFromRGB(0xFB3131);
    prizenumlabel2.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    if (self.prizenumView.frame.size.height < kRealValue(10)) {
        prizenumViewlabel.hidden =YES;
        prizenumlabel2.hidden =YES;
    }
    [self.prizenumView addSubview:prizenumlabel2];
    
    [prizenumlabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo( self.prizenumView.mas_top).offset(kRealValue(13));
        make.right.equalTo(self.prizenumView.mas_right).offset(kRealValue(-16));
        
    }];
    
    NSInteger locate = kRealValue(15);
    NSInteger pading = kRealValue(8);
    NSInteger Imagewidth = kRealValue(30);
    NSMutableArray  *prizenumImageArr = [dic valueForKey:@"userList"];
    NSInteger count = prizenumImageArr.count>=5?6:prizenumImageArr.count;
    for (int i = 0; i <count ; i ++) {
        UIImageView *prizenumImage = [[UIImageView alloc]init];
//        prizenumImage.backgroundColor = kRandomColor;
        
        prizenumImage.frame= CGRectMake(locate + pading * i + Imagewidth*i, kRealValue(47), Imagewidth, Imagewidth);
        if (i == 5) {
            prizenumImage.image = kGetImage(@"ic _ public _ nuuprize");
        }else{
            
             [prizenumImage sd_setImageWithURL:[NSURL URLWithString:[prizenumImageArr[i] valueForKey:@"userImage"]] placeholderImage:kGetImage(@"user_pic")];
        }
        [self.prizenumView addSubview:prizenumImage];
        prizenumImage.layer.masksToBounds = YES;
        prizenumImage.layer.cornerRadius = kRealValue(15);
    }
    
    UIImageView  *prizenumrightIcon = [[UIImageView alloc]init];
    prizenumrightIcon.image= kGetImage(@"ic_public_more");
    
    [self.prizenumView addSubview:prizenumrightIcon];
    
    
    UILabel  *prizenumrighttitle = [[UILabel alloc]init];
    prizenumrighttitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    prizenumrighttitle.textColor = KColorFromRGB(0x999999);
    prizenumrighttitle.textAlignment = NSTextAlignmentLeft;
    prizenumrighttitle.userInteractionEnabled = YES;
    prizenumrighttitle.text =@"查看全部";
    [self.prizenumView addSubview:prizenumrighttitle];
    
    [prizenumrightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.prizenumView.mas_right).offset(kRealValue(-15));
        make.top.equalTo(self.prizenumView.mas_top).offset(kRealValue(52));
        make.width.mas_equalTo(kRealValue(20));
        make.height.mas_equalTo(kRealValue(20));
    }];
    [prizenumrighttitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(prizenumrightIcon.mas_left).offset(kRealValue(18));
        make.top.equalTo(self.prizenumView.mas_top).offset(kRealValue(52));
        make.width.mas_equalTo(kRealValue(60));
        make.height.mas_equalTo(kRealValue(20));
    }];
    
    UITapGestureRecognizer *seeAlltap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeAllTapAvt)];
    [prizenumrighttitle addGestureRecognizer:seeAlltap];
    
    
    
    
    
    
    //胡猜流程
    [self addSubview:self.hucaibgView];
    UILabel *hucailabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(10), kRealValue(100), kRealValue(20))];
    hucailabel.text =@"奖多多流程";
    hucailabel.textAlignment =NSTextAlignmentLeft;
    hucailabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
    [self.hucaibgView addSubview:hucailabel];
    
    
    UILabel *hucailabel2 = [[UILabel alloc]init];
    hucailabel2.text =[NSString stringWithFormat:@"满%@人开奖",[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"drawNumber"]]];
    hucailabel2.textAlignment =NSTextAlignmentLeft;
    hucailabel2.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    [self.hucaibgView addSubview:hucailabel2];
    
    [hucailabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo( self.hucaibgView.mas_top).offset(kRealValue(13));
        make.right.equalTo(self.hucaibgView.mas_right).offset(kRealValue(-16));
        
    }];
    
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, kRealValue(50), kScreenWidth, kRealValue(69))];
    //        _SaledPicView.backgroundColor = kRandomColor;
    image.image = kGetImage(@"img_activity_guess2");
    [_hucaibgView addSubview:image];
    //属性和运费
    [self addSubview:self.SizebgView];
    
    UIView *linebg1 =  [[UIView alloc]initWithFrame:CGRectMake(0, self.SizebgView.frame.size.height + self.SizebgView.frame.origin.y, kScreenWidth, kRealValue(10))];
    linebg1.backgroundColor = KColorFromRGB(0xF0F1F4);
    [self addSubview:linebg1];
    [self addSubview:self.SizebgView];
    UIView *linebg2 =  [[UIView alloc]initWithFrame:CGRectMake(0, self.SizebgView.frame.size.height + self.SizebgView.frame.origin.y, kScreenWidth, kRealValue(10))];
    linebg2.backgroundColor = KColorFromRGB(0xF0F1F4);
    [self addSubview:linebg2];
    [self addSubview:self.SaledPicView];
    
    
    
    
}
-(void)seeAllTapAvt
{
    if (self.hucaiSeeAll) {
        self.hucaiSeeAll();
    }
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
//        pageControl.backgroundColor = kRandomColor ;
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
        _limitTimeBuy =[[UIView alloc]initWithFrame:CGRectMake(0, self.headImgScrollview.frame.size.height, kScreenWidth,kRealValue(0))];
        _limitTimeBuy.backgroundColor = [UIColor colorWithHexString:@"#3298FF"];
        UILabel *labeltitle = [[UILabel alloc]init];
        labeltitle.text = @"邀请剩余时间";
        labeltitle.textColor = [UIColor whiteColor];
        labeltitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        labeltitle.textAlignment = NSTextAlignmentCenter;
        labeltitle.frame = CGRectMake(kRealValue(16), 0, kRealValue(100), self.limitTimeBuy.frame.size.height);
        [_limitTimeBuy addSubview:labeltitle];
        self.labeltime = [[UILabel alloc]init];
        //        self.labeltime.text = @"限时邀友时间 ";
        self.labeltime.textColor = [UIColor whiteColor];
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
        _titleImageView.backgroundColor = [UIColor redColor];
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
    self.originalPrice.textColor = [UIColor whiteColor];
    self.originalPrice.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.originalPrice.textAlignment = NSTextAlignmentCenter;
    [self.titleImageView addSubview:self.originalPrice];
    [self.originalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentPrice.mas_right);
        make.bottom.equalTo(self.titleImageView.mas_bottom).offset(-kRealValue(14));
        make.height.mas_equalTo(kRealValue(22));
    }];

    self.SalelNum = [[UILabel alloc]init];
    self.SalelNum.textColor = [UIColor whiteColor];
    self.SalelNum.text = @"库存444";
    self.SalelNum.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.SalelNum.textAlignment = NSTextAlignmentRight;
    [self.titleImageView addSubview:self.SalelNum];
    [self.SalelNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImageView.mas_left).offset(kRealValue(16));
        make.top.equalTo(self.currentPrice.mas_bottom).offset(kRealValue(0));
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
    
    self.likebt = [UIButton buttonWithType:UIButtonTypeCustom];
    [ self.likebt setImage:kGetImage(@"ic_action_on") forState:UIControlStateNormal];
    [ self.likebt setImage:kGetImage(@"ic_action_low") forState:UIControlStateSelected];
    [self.likebt addTarget:self action:@selector(shopAddproduct:) forControlEvents:UIControlEventTouchUpInside];
    [self.titlebgView addSubview: self.likebt];
    [ self.likebt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titlebgView.mas_top).offset(kRealValue(19));
        make.right.equalTo(self.titlebgView.mas_right).offset(kRealValue(-16));
        make.width.mas_equalTo(kRealValue(0));
        make.height.mas_equalTo(kRealValue(0));
    }];
    
    self.likelabel = [[UILabel alloc]init];
    self.likelabel.textColor = KColorFromRGB(0x666666);
    self.likelabel.text = @"";
    self.likelabel.userInteractionEnabled =YES;
    self.likelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.likelabel.textAlignment = NSTextAlignmentCenter;
    
    [self.titlebgView addSubview:self.likelabel];
    UITapGestureRecognizer *labeluptap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labeluptapAct)];
    [self.likelabel addGestureRecognizer:labeluptap];
    
    [self.likelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo( self.likebt.mas_bottom).offset(kRealValue(5));
        //        make.right.equalTo(self.titlebgView.mas_right).offset(kRealValue(-16));
        make.width.mas_equalTo(kRealValue(0));
        
    }];
    
    self.titlelabel = [[YYLabel alloc]init];
    self.titlelabel.textColor = [UIColor blackColor];
    //  self.titlelabel.text = @"Anessa安热沙资生堂小金瓶防晒乳60ml (防晒霜 小金瓶 防水防汗 资生堂防晒) w:594*h:68";
    self.titlelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(17)];
    self.titlelabel.textAlignment = NSTextAlignmentLeft;
    self.titlelabel.numberOfLines = 2;
    [self.titlebgView addSubview:self.titlelabel];
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titlebgView.mas_right).offset(-kRealValue(16));
        make.centerY.equalTo(self.titlebgView.mas_centerY);
        make.left.equalTo(self.titlebgView.mas_left).offset(kRealValue(16));
        make.height.mas_equalTo(self.titlebgView.mas_height);
    }];
}

-(UIView *)prizeView
{
    if (!_prizeView) {
        _prizeView = [[UIView alloc]initWithFrame:CGRectMake(0, self.titlebgView.frame.size.height +self.titlebgView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(93))];
        _prizeView.backgroundColor = [UIColor whiteColor];
        if (klStringisEmpty([GVUserDefaults standardUserDefaults].accessToken) ) {
            // 未登录
           self.prizeView.frame = CGRectMake(0, self.titlebgView.frame.size.height +self.titlebgView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(0));
            //参团好友

            
        }else{
            NSString *str = [self.dic valueForKey:@"status"];
            if ([str isEqualToString:@"PENDING"]) {
                self.prizeView.frame = CGRectMake(0, self.titlebgView.frame.size.height +self.titlebgView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(0));
            }
            if ([str isEqualToString:@"INITIATE"]) {
                self.prizeView.frame = CGRectMake(0, self.titlebgView.frame.size.height +self.titlebgView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(0));
            }
            if ([str isEqualToString:@"ACTIVE"]) {
                self.prizeView.frame = CGRectMake(0, self.titlebgView.frame.size.height +self.titlebgView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(0));
            }
            if ([str isEqualToString:@"UNOPENED"]) {
                self.prizeView.frame = CGRectMake(0, self.titlebgView.frame.size.height +self.titlebgView.frame.origin.y, kScreenWidth,kRealValue(0));
            }
            if ([str isEqualToString:@"OPENED"]) {
                self.prizeView.frame = CGRectMake(0, self.titlebgView.frame.size.height +self.titlebgView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(93));
            }
            if ([str isEqualToString:@"INVALID"]) {
                self.prizeView.frame = CGRectMake(0, self.titlebgView.frame.size.height +self.titlebgView.frame.origin.y, kScreenWidth,kRealValue(0));
            }
        }

    }
    return _prizeView;
}
-(UIView *)prizenumView
{
    
    if (!_prizenumView) {
        _prizenumView = [[UIView alloc]initWithFrame:CGRectMake(0, self.prizeView.frame.size.height +self.prizeView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(93))];
        if (klStringisEmpty([GVUserDefaults standardUserDefaults].accessToken) ) {
            // 未登录

            self.prizenumView.frame = CGRectMake(0, self.prizeView.frame.size.height +self.prizeView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(0));
            
        }else{
                //普通用户
                //店主用户
                NSString *str = [self.dic valueForKey:@"status"];
                if ([str isEqualToString:@"PENDING"]) {
                    self.prizenumView.frame = CGRectMake(0, self.prizeView.frame.size.height +self.prizeView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(0));
                }
                if ([str isEqualToString:@"INITIATE"]) {
                    self.prizenumView.frame = CGRectMake(0, self.prizeView.frame.size.height +self.prizeView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(0));
                }
                if ([str isEqualToString:@"ACTIVE"]) {
                    self.prizenumView.frame = CGRectMake(0, self.prizeView.frame.size.height +self.prizeView.frame.origin.y, kScreenWidth,kRealValue(93));
                }
                if ([str isEqualToString:@"UNOPENED"]) {
                    self.prizenumView.frame = CGRectMake(0, self.prizeView.frame.size.height +self.prizeView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(93));
                }
                if ([str isEqualToString:@"OPENED"]) {
                    self.prizenumView.frame = CGRectMake(0, self.prizeView.frame.size.height +self.prizeView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(93));
                }
                if ([str isEqualToString:@"INVALID"]) {
                    self.prizenumView.frame = CGRectMake(0, self.prizeView.frame.size.height +self.prizeView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(0));
                }

           
        }
        
        
        
        
        
        _prizenumView.backgroundColor = [UIColor whiteColor];
        
        
    }
    return _prizenumView;
}
-(UIView *)hucaibgView
{
    if (!_hucaibgView) {
        _hucaibgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.prizenumView.frame.size.height +self.prizenumView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(117))];
        if (klStringisEmpty([GVUserDefaults standardUserDefaults].accessToken) ) {
            // 未登录
            _hucaibgView.frame= CGRectMake(0, self.titlebgView.frame.size.height +self.titlebgView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(117));

            
        }else{
            //店主用户
            NSString *str = [self.dic valueForKey:@"status"];
            if ([str isEqualToString:@"PENDING"]) {
                _hucaibgView.frame= CGRectMake(0, self.titlebgView.frame.size.height +self.titlebgView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(117));
            }
            if ([str isEqualToString:@"INITIATE"]) {
                _hucaibgView.frame= CGRectMake(0, self.titlebgView.frame.size.height +self.titlebgView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(117));
            }
            if ([str isEqualToString:@"ACTIVE"]) {
                _hucaibgView.frame= CGRectMake(0, self.prizenumView.frame.size.height +self.prizenumView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(117));
            }
            if ([str isEqualToString:@"UNOPENED"]) {
                _hucaibgView.frame= CGRectMake(0, self.prizenumView.frame.size.height +self.prizenumView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(117));
            }
            if ([str isEqualToString:@"OPENED"]) {
                _hucaibgView.frame= CGRectMake(0, self.prizenumView.frame.size.height +self.prizenumView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(117));
            }
            if ([str isEqualToString:@"INVALID"]) {
                _hucaibgView.frame= CGRectMake(0, self.titlebgView.frame.size.height +self.titlebgView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(117));
            }

        }
        
        
        _hucaibgView.backgroundColor = [UIColor whiteColor];
        

        
    }
    return _hucaibgView;
}

-(UIView *)SizebgView
{
    if (!_SizebgView) {
        _SizebgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hucaibgView.frame.size.height +self.hucaibgView.frame.origin.y+ kRealValue(10), kScreenWidth,kRealValue(98))];
        _SizebgView.backgroundColor = [UIColor whiteColor];
        
        self.choseePropertyView = [[MHProductDetailCellHead alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(47)) title:@"规格参数" rightTitle:[NSString stringWithFormat:@"已选%@",[self.dic valueForKey:@"productStandard"]] isShowRight:NO];
        self.choseePropertyView.selectact = ^(NSString *productID, NSString *brandID) {
           
            
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


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
