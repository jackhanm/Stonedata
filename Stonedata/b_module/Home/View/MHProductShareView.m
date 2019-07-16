//
//  MHProductShareView.m
//  mohu
//
//  Created by 余浩 on 2018/9/22.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHProductShareView.h"
#import "MHGoodsKindsBtnView.h"
#import "UIImage+Common.h"
#import "HMScannerController.h"
#import "UMSocialWechatHandler.h"
#import "RichStyleLabel.h"
#import "CTUUID.h"
#import <Photos/PHPhotoLibrary.h>
@interface MHProductShareView()

@property (nonatomic, strong)UIView *smallbgview;
@property (nonatomic, strong)UIView *SavebgView;
@property (nonatomic, strong)UIView *sharebtnbgview;
@property (nonatomic, strong)UILabel *sharetitlelabel;
@property (nonatomic, strong)UIImageView *productImageview;
@property (nonatomic, strong)UILabel *productnamelabel;
@property (nonatomic, strong)UILabel *productpricelabel;
@property (nonatomic, strong)UILabel *productsalednumlabel;
@property (nonatomic, strong)UIImageView *sharecodeImage;
@property (nonatomic, strong)UILabel *sharedeslabel;
@property (nonatomic, strong)RichStyleLabel *sharecodelabel;
@property (nonatomic, strong)NSString *codestr;

@end
@implementation MHProductShareView

- (instancetype)initWithFrame:(CGRect)frame dict:(NSMutableDictionary *)dict dic:(NSMutableDictionary *)dic comefrom:(NSString *)comeform shareId:(NSString *)shareId
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createview];
        _dict =  dict;
         _dic  = dic;
        _comefrom = comeform;
        _shareId = shareId;
        [self.productImageview sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"productSmallImage"]] placeholderImage:kGetImage(@"img_bitmap_long")];
        self.productnamelabel.text = [dict valueForKey:@"productName"];
        self.productpricelabel.text = [NSString stringWithFormat:@"¥%@",[dict valueForKey:@"retailPrice"]];
        self.productsalednumlabel.text = [NSString stringWithFormat:@"已售%@件",[dict valueForKey:@"sellCount"]];
        
        
        if ([self.comefrom isEqualToString:@"prizemore"] || [self.comefrom isEqualToString:@"hucai"]) {
            self.productpricelabel.text = [NSString stringWithFormat:@"¥%@",[dict valueForKey:@"productPrice"]];
            self.productsalednumlabel.text = [NSString stringWithFormat:@"活动场次:%@场",[dict valueForKey:@"shareCount"]];
            
            UILabel *EMSlabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(110), kRealValue(330), kRealValue(120), kRealValue(20))];
            EMSlabel.textAlignment = NSTextAlignmentRight;
            
            EMSlabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
            EMSlabel.textColor = KColorFromRGB(0x282828);
            NSMutableArray *userlist = [dict valueForKey:@"userList"];
            NSInteger joincount =  [[dict valueForKey:@"drawNumber"]  integerValue];
            NSString *numpeoplo = [NSString stringWithFormat:@"%ld",  joincount - userlist.count ];
            EMSlabel.text =[NSString stringWithFormat:@"还差%@人即可开奖",numpeoplo];
            NSString *Str = [NSString stringWithFormat:@"还差%@人即可开奖",numpeoplo];
            NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:Str];
            [attstring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"f74916"] range:NSMakeRange(2, numpeoplo.length)];
            [attstring addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFontValue(15)] range:NSMakeRange(2, numpeoplo.length)];
            EMSlabel.attributedText = attstring;
            [self.SavebgView addSubview:EMSlabel];
            self.sharedeslabel.textColor = [UIColor colorWithHexString:@"989898"];
            [self.sharedeslabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.sharecodeImage.mas_right).offset(kRealValue(20));
                make.top.equalTo(self.SavebgView.mas_top).offset(kRealValue(350));
                make.right.equalTo(self.SavebgView.mas_right).offset(-kRealValue(20));
            }];
            if ([self.comefrom isEqualToString:@"prizemore"]) {
                self.sharetitlelabel.text = @"【奖多多活动】";
                self.sharedeslabel.text = @"参与活动 就有机会领好礼！";
            }else{
                self.sharetitlelabel.text = @"【狐猜活动】";
                self.sharedeslabel.text = @"猜中价格 好礼免费拿！";
            }
            
            
        }
       
        if (klObjectisEmpty(dic)) {
            
        }else{
            self.codestr = [NSString stringWithFormat:@"%@",[dic valueForKey:@"userRole"]];
        }
        if ([self.codestr integerValue] <2) {
            self.sharecodelabel.hidden =YES;
        }else{
            [self.sharecodelabel setAttributedText:[NSString stringWithFormat:@"邀请码：%@",[_dic valueForKey:@"inviteCode"]] withRegularPattern:@"[0-9.,¥]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"282828"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(14)]}];
        }
        
        
        if (ValidStr(self.comefrom)) {
            //奖多多
            if ([self.comefrom isEqualToString:@"prizemore"]) {
                [HMScannerController cardImageWithCardName:[[MHBaseClass sharedInstance]createParamUrl:[_dict valueForKey:@"sharePath"] param:@{@"userCode":[_dic valueForKey:@"inviteCode"],@"urlType":@"activity-jdd",@"shareId":self.shareId,@"seqNo":[CTUUID getTimeStamp]}] avatar:nil scale:0.2 completion:^(UIImage *image) {
                    self.sharecodeImage.image = image;
                }];
            }else{
                
                [HMScannerController cardImageWithCardName:[[MHBaseClass sharedInstance]createParamUrl:[_dict valueForKey:@"sharePath"] param:@{@"userCode":[_dic valueForKey:@"inviteCode"],@"urlType":@"activity-hc",@"shareId":self.shareId,@"seqNo":[CTUUID getTimeStamp]}] avatar:nil scale:0.2 completion:^(UIImage *image) {
                    self.sharecodeImage.image = image;
                }];
            }
        }else{
            
            //商品详情
            [HMScannerController cardImageWithCardName:[[MHBaseClass sharedInstance]createParamUrl:[_dict valueForKey:@"productUrl"] param:@{@"userCode":[_dic valueForKey:@"inviteCode"],@"urlType":@"product",@"seqNo":[CTUUID getTimeStamp] ,@"shareId":[NSString stringWithFormat:@"%@",[_dict valueForKey:@"productId"]]}] avatar:nil scale:0.2 completion:^(UIImage *image) {
                self.sharecodeImage.image = image;
            }];
        }
    }
    return self;
}

-(void)setDict:(NSMutableDictionary *)dict
{
    _dict =  dict;
    [self.productImageview sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"productSmallImage"]] placeholderImage:kGetImage(@"img_bitmap_long")];
    self.productnamelabel.text = [dict valueForKey:@"productName"];
    self.productpricelabel.text = [NSString stringWithFormat:@"¥%@",[dict valueForKey:@"retailPrice"]];
    self.productsalednumlabel.text = [NSString stringWithFormat:@"已售%@件",[dict valueForKey:@"sellCount"]];

    
    if ([self.comefrom isEqualToString:@"prizemore"] || [self.comefrom isEqualToString:@"hucai"]) {
          self.productpricelabel.text = [NSString stringWithFormat:@"¥%@",[dict valueForKey:@"productPrice"]];
        self.productsalednumlabel.text = [NSString stringWithFormat:@"活动场次:%@场",[dict valueForKey:@"shareCount"]];
        
        UILabel *EMSlabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(110), kRealValue(330), kRealValue(120), kRealValue(20))];
        EMSlabel.textAlignment = NSTextAlignmentRight;
     
        EMSlabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        EMSlabel.textColor = KColorFromRGB(0x282828);
        NSMutableArray *userlist = [dict valueForKey:@"userList"];
        NSInteger joincount =  [[dict valueForKey:@"drawNumber"]  integerValue];
        NSString *numpeoplo = [NSString stringWithFormat:@"%ld",  joincount - userlist.count ];
        EMSlabel.text =[NSString stringWithFormat:@"还差%@人即可开奖",numpeoplo];
        NSString *Str = [NSString stringWithFormat:@"还差%@人即可开奖",numpeoplo];
        NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:Str];
        [attstring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"f74916"] range:NSMakeRange(2, numpeoplo.length)];
        [attstring addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFontValue(15)] range:NSMakeRange(2, numpeoplo.length)];
        EMSlabel.attributedText = attstring;
        [self.SavebgView addSubview:EMSlabel];
        self.sharedeslabel.textColor = [UIColor colorWithHexString:@"989898"];
        [self.sharedeslabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sharecodeImage.mas_right).offset(kRealValue(20));
            make.top.equalTo(self.SavebgView.mas_top).offset(kRealValue(350));
            make.right.equalTo(self.SavebgView.mas_right).offset(-kRealValue(20));
        }];
        if ([self.comefrom isEqualToString:@"prizemore"]) {
            self.sharetitlelabel.text = @"【奖多多活动】";
            self.sharedeslabel.text = @"参与活动 就有机会领好礼！";
        }else{
            self.sharetitlelabel.text = @"【狐猜活动】";
             self.sharedeslabel.text = @"猜中价格 好礼免费拿！";
        }
        
        
    }
}
-(void)setDic:(NSMutableDictionary *)dic
{
    _dic  = dic;
    if (klObjectisEmpty(_dic)) {
        
    }else{
        self.codestr = [NSString stringWithFormat:@"%@",[_dic valueForKey:@"userRole"]];
    }
    if ([self.codestr integerValue] <2) {
         self.sharecodelabel.hidden =YES;
    }else{
        [self.sharecodelabel setAttributedText:[NSString stringWithFormat:@"邀请码：%@",[_dic valueForKey:@"inviteCode"]] withRegularPattern:@"[0-9.,¥]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"282828"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(14)]}];
    }
    
    
    if (ValidStr(self.comefrom)) {
        //奖多多
        if ([self.comefrom isEqualToString:@"prizemore"]) {
            [HMScannerController cardImageWithCardName:[[MHBaseClass sharedInstance]createParamUrl:[_dict valueForKey:@"sharePath"] param:@{@"userCode":[_dic valueForKey:@"inviteCode"],@"urlType":@"activity-jdd",@"shareId":self.shareId,@"seqNo":[CTUUID getTimeStamp]}] avatar:nil scale:0.2 completion:^(UIImage *image) {
                self.sharecodeImage.image = image;
            }];
        }else{
            
            [HMScannerController cardImageWithCardName:[[MHBaseClass sharedInstance]createParamUrl:[_dict valueForKey:@"sharePath"] param:@{@"userCode":[_dic valueForKey:@"inviteCode"],@"urlType":@"activity-hc",@"shareId":self.shareId,@"seqNo":[CTUUID getTimeStamp]}] avatar:nil scale:0.2 completion:^(UIImage *image) {
                self.sharecodeImage.image = image;
            }];
        }
    }else{

        //商品详情
        [HMScannerController cardImageWithCardName:[[MHBaseClass sharedInstance]createParamUrl:[_dict valueForKey:@"productUrl"] param:@{@"userCode":[_dic valueForKey:@"inviteCode"],@"urlType":@"product",@"seqNo":[CTUUID getTimeStamp] ,@"shareId":[NSString stringWithFormat:@"%@",[_dict valueForKey:@"productId"]]}] avatar:nil scale:0.2 completion:^(UIImage *image) {
            self.sharecodeImage.image = image;
        }];
    }
} 
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        [self createview];
    }
    return self;
}

-(void)createview
{

    //白色区域
    self.smallbgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kRealValue(345), kRealValue(443))];
    self.smallbgview.backgroundColor = [UIColor whiteColor];
    self.smallbgview.layer.cornerRadius = kRealValue(10);
//    self.smallbgview.centerX = self.centerX;
//    self.smallbgview.centerY = self.centerY - kRealValue(58);
    [self addSubview:self.smallbgview];
    //要截图的区域 高度大概370
    self.SavebgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kRealValue(345), kRealValue(443))];
//    self.SavebgView.backgroundColor =kRandomColor;
    [self.smallbgview addSubview:self.SavebgView];
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.SavebgView.bounds     byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight    cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.SavebgView.bounds;
    maskLayer1.path = maskPath1.CGPath;
   self.SavebgView.layer.mask = maskLayer1;
    
    self.sharetitlelabel = [[UILabel alloc]init];
    self.sharetitlelabel.text = @"【未来商视】用心选好货";
    self.sharetitlelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    self.sharetitlelabel.textAlignment = NSTextAlignmentCenter;
    [self.SavebgView addSubview:self.sharetitlelabel];
    [self.sharetitlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.SavebgView.mas_top).offset(kRealValue(20));
        make.centerX.equalTo(self.SavebgView.mas_centerX);
    }];
    
    
    self.productImageview = [[UIImageView alloc]init];
    self.productImageview.contentMode   = UIViewContentModeScaleAspectFill;
    self.productImageview.clipsToBounds = YES;
    self.productImageview.layer.cornerRadius = kRealValue(8);
    [self.SavebgView addSubview:self.productImageview];
    [self.productImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sharetitlelabel.mas_bottom).offset(kRealValue(10));
        make.width.mas_equalTo(kRealValue(300));
        make.height.mas_equalTo(kRealValue(kRealValue(175)));
        make.centerX.equalTo(self.SavebgView.mas_centerX);
    }];
    
    
    self.productnamelabel = [[UILabel alloc]init];
//    self.productnamelabel.text = @"迪奥（Dior）花漾甜心小姐花漾甜心…";
    self.productnamelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    self.productnamelabel.numberOfLines = 2;
    self.productnamelabel.textAlignment = NSTextAlignmentLeft;
    [self.SavebgView addSubview:self.productnamelabel];
    [self.productnamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kRealValue(300));
        make.height.mas_equalTo(kRealValue(40));
        make.left.equalTo(self.SavebgView.mas_left).offset(kRealValue(22));
        make.top.equalTo(self.productImageview.mas_bottom).offset(kRealValue(10));

    }];
    
    
    UILabel *descLabel =[[UILabel alloc]init];
    descLabel.text = @"价格：";
    descLabel.textColor = KColorFromRGB(0x282828);
    descLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    descLabel.textAlignment = NSTextAlignmentLeft;
    [self.SavebgView addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.SavebgView.mas_left).offset(kRealValue(22));
        make.top.equalTo(self.productnamelabel.mas_bottom).offset(kRealValue(10));
    }];
    
    
    
    self.productpricelabel =[[UILabel alloc]init];
    self.productpricelabel.text = @"¥2015465559";
    self.productpricelabel.textColor = KColorFromRGB(0xf74916);
    self.productpricelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.productpricelabel.textAlignment = NSTextAlignmentLeft;
    [self.SavebgView addSubview:self.productpricelabel];
    [self.productpricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(descLabel.mas_right).offset(0);
        make.centerY.equalTo(descLabel.mas_centerY).offset(0);
    }];
    
    
    self.productsalednumlabel =[[UILabel alloc]init];
    self.productsalednumlabel.text = @"已售65677件";
    self.productsalednumlabel.textColor = KColorFromRGB(0x969696);
    self.productsalednumlabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    self.productsalednumlabel.textAlignment = NSTextAlignmentLeft;
    [self.SavebgView addSubview:self.productsalednumlabel];
    [self.productsalednumlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.SavebgView.mas_right).offset(-kRealValue(20));
        make.centerY.equalTo(descLabel.mas_centerY).offset(0);
    }];
    
    
    UILabel *lineView = [[UILabel alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    [self.SavebgView  addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.SavebgView.mas_right).offset(-kRealValue(20));
        make.height.mas_equalTo(1/kScreenScale);
        make.left.equalTo(self.SavebgView.mas_left).offset(kRealValue(20));
        make.top.equalTo(self.productsalednumlabel.mas_bottom).offset(kRealValue(10));
        
    }];
    

    self.sharecodeImage = [[UIImageView alloc]init];
    [self.SavebgView addSubview:self.sharecodeImage];
    [self.sharecodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(kRealValue(6));
        make.width.mas_equalTo(kRealValue(70));
        make.height.mas_equalTo(kRealValue(70));
       make.left.equalTo(self.SavebgView.mas_left).offset(kRealValue(40));
    }];
    
    
    self.sharedeslabel =[[UILabel alloc]init];
    self.sharedeslabel.text = @"我在未来商视帮你挑选了一批好货扫描二维码即可查看";
    self.sharedeslabel.textColor = KColorFromRGB(0x000000);
    self.sharedeslabel.numberOfLines = 3;
    self.sharedeslabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    self.sharedeslabel.textAlignment = NSTextAlignmentLeft;
    [self.SavebgView addSubview:self.sharedeslabel];
    [self.sharedeslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sharecodeImage.mas_right).offset(kRealValue(20));
        make.top.equalTo(lineView.mas_bottom).offset(kRealValue(6));
        make.right.equalTo(self.SavebgView.mas_right).offset(-kRealValue(20));
    }];
    
    
    
    self.sharecodelabel =[[RichStyleLabel alloc]init];
    self.sharecodelabel.numberOfLines = 1;
    self.sharecodelabel.textColor = KColorFromRGB(0x969696);
    self.sharecodelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    self.sharecodelabel.textAlignment = NSTextAlignmentLeft;
    [self.SavebgView addSubview:self.sharecodelabel];
    [self.sharecodelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.SavebgView.mas_left).offset(kRealValue(20));
        make.top.equalTo(self.sharecodeImage.mas_bottom).offset(kRealValue(10));
    }];
    
    

    
    
//
    //分享的按钮区域
    self.sharebtnbgview = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(460), self.smallbgview.frame.size.width, kRealValue(90))];
//    self.sharebtnbgview.backgroundColor =kRandomColor;
    [self addSubview:self.sharebtnbgview];
    NSArray *arrtitle = @[@"微信好友",@"朋友圈",@"保存图片"];
    NSArray *imageArr= @[@"ic_share_wechat",@"ic_share_friend",@"ic_share_pic"];
    NSInteger widthW = kRealValue(60);
    NSInteger locateX= kRealValue(40);
    NSInteger pading =( self.frame.size.width-2*locateX - widthW *3)/2;
    for (int i = 0; i<arrtitle.count; i++) {
        CGRect frame = CGRectMake(widthW *i+ pading*i +locateX, kRealValue(5), kRealValue(60), kRealValue(85));
        MHGoodsKindsBtnView *btnView = [[MHGoodsKindsBtnView alloc] initWithFrame:frame title:arrtitle[i] imageStr:imageArr[i]];
        btnView.titleLable.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        btnView.titleLable.textColor = [UIColor whiteColor];;
        btnView.tag = 12000+i;
        [self.sharebtnbgview addSubview:btnView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
        [btnView addGestureRecognizer:tap];
    }
    
    
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeHide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(kRealValue(550));
        make.centerX.equalTo(self.smallbgview.mas_centerX).offset(-kRealValue(5));
        make.size.mas_equalTo(CGSizeMake(kRealValue(25), kRealValue(25)));
    }];
    

}


-(void)closeHide{
    if (self.hidenClick) {
        self.hidenClick();
    }

}


- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}
-(void)OnTapBtnView:(UITapGestureRecognizer *)sender
{
 
    MHLog(@"%ld",sender.view.tag);
    if (!self.dic)  return;
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    NSString *url = @"";
    NSString *titles = [_dict valueForKey:@"productName"];
    
    if (ValidStr(self.comefrom)){
        if ([self.comefrom isEqualToString:@"prizemore"]) {
            url =   [[MHBaseClass sharedInstance]createParamUrl:[_dict valueForKey:@"sharePath"] param:@{@"userCode":[_dic valueForKey:@"inviteCode"],@"urlType":@"activity-jdd",@"shareId":self.shareId,@"seqNo":[CTUUID getTimeStamp]}];
            titles = [NSString stringWithFormat:@"【奖多多】%@",[_dict valueForKey:@"productName"]];
        }else{
            
            url = [[MHBaseClass sharedInstance]createParamUrl:[_dict valueForKey:@"sharePath"] param:@{@"userCode":[_dic valueForKey:@"inviteCode"],@"urlType":@"activity-hc",@"shareId":self.shareId,@"seqNo":[CTUUID getTimeStamp]}];
             titles = [NSString stringWithFormat:@"【狐猜】%@",[_dict valueForKey:@"productName"]];
        }
    }else{
        url =   [[MHBaseClass sharedInstance]createParamUrl:[_dict valueForKey:@"productUrl"] param:@{@"userCode":[_dic valueForKey:@"inviteCode"],@"urlType":@"product",@"seqNo":[CTUUID getTimeStamp],@"shareId":[_dict valueForKey:@"productId"]}];
        NSLog(@"%@",[_dic valueForKey:@"inviteCode"]);
        titles = [NSString stringWithFormat:@"【未来商视自营】%@",[_dict valueForKey:@"productName"]];
    }
    
    UMShareWebpageObject *WebpageObject = [UMShareWebpageObject shareObjectWithTitle:titles descr:[_dict valueForKey:@"productSubtitle"] thumImage:self.productImageview.image];
    WebpageObject.webpageUrl  = url;
    messageObject.shareObject = WebpageObject;
    
    if (sender.view.tag == 12000) {
        //分享好友
        [[UMSocialManager defaultManager] shareToPlatform:1 messageObject:messageObject currentViewController:self.superVC completion:^(id data, NSError *error) {
            NSString *message = nil;
            if (!error) {
//                message = [NSString stringWithFormat:@"分享成功"];
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
//                                                                message:message
//                                                               delegate:nil
//                                                      cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                      otherButtonTitles:nil];
//                [alert show];
                
            } else {
                message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                if (error.code == 2008) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                    message:@"分享软件未安装"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                
            }
        }];
    }
    if (sender.view.tag == 12001) {
        //分享朋友圈
      
        [[UMSocialManager defaultManager] shareToPlatform:2 messageObject:messageObject currentViewController:self.superVC completion:^(id data, NSError *error) {
            NSString *message = nil;
            if (!error) {
//                message = [NSString stringWithFormat:@"分享成功"];
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
//                                                                message:message
//                                                               delegate:nil
//                                                      cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                      otherButtonTitles:nil];
//                [alert show];
                
            } else {
                message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                if (error.code == 2008) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                    message:@"分享软件未安装"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                
            }
        }];
    }
    if (sender.view.tag == 12002) {
        //保存图片
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
        {
            // 无权限
            // do something...
            KLToast(@"请先打开相册权限设置");
            return;
        }
  
        
        UIImage *image =  [UIImage imageFromView:self.SavebgView];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
        
    }
    

    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    KLToast(@"保存成功");
    MHLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}




@end
