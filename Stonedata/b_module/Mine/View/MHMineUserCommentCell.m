//
//  MHMineUserCommentCell.m
//  mohu
//
//  Created by yuhao on 2018/10/10.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineUserCommentCell.h"
#import "TggStarEvaluationView.h"
#import "MHOrderCommenetSingerModel.h"

@interface MHMineUserCommentCell()
@property(nonatomic, strong)TggStarEvaluationView *tggStarEvaView;
@end


@implementation MHMineUserCommentCell

-(void)setModel:(MHOrderCommentList *)model
{
    _model = model;
    [self createviewModel:model];
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:model.productSmallImage] placeholderImage:kGetImage(kfailImage)];
    self.productname.text = [NSString stringWithFormat:@"%@",model.productName];
    self.productsize.text = [NSString stringWithFormat:@"%@",model.productStandard];
    self.productPrice.text = [NSString stringWithFormat:@"¥%@",model.productPrice];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor= [UIColor whiteColor];
       
    }
    return self;
}
-(void)createviewModel:(MHOrderCommentList *)model
{
    [self addSubview:self.bgViewImage];
    [self.bgViewImage addSubview:self.productImage];
    [self.bgViewImage addSubview:self.productname];
    [self.bgViewImage addSubview:self.productsize];
    [self.bgViewImage addSubview:self.productPrice];
    [self.bgViewImage addSubview:self.productCommentTitle];
    
    
    
    [self.productImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.bgViewImage.mas_top).offset(kRealValue(10));
        make.left.equalTo(self.bgViewImage.mas_left).offset(kRealValue(10));
        make.width.height.mas_offset(kRealValue(80));
        
    }];
    
    [self.productname mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.bgViewImage.mas_top).offset(kRealValue(10));
        make.left.equalTo(self.productImage.mas_right).offset(kRealValue(10));
       
        
    }];
    
    [self.productsize mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.productname.mas_bottom).offset(kRealValue(10));
        make.left.equalTo(self.productImage.mas_right).offset(kRealValue(10));
        
        
    }];
    [self.productPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.productsize.mas_bottom).offset(kRealValue(10));
        make.left.equalTo(self.productImage.mas_right).offset(kRealValue(10));

    }];
    [self.productCommentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.productImage.mas_bottom).offset(kRealValue(25));
         make.left.equalTo(self.bgViewImage.mas_left).offset(kRealValue(10));
    }];
//
//    NSInteger lox = kRealValue(74);
//    NSInteger xingxingwidth = kRealValue(26);
//    NSInteger pading = kRealValue(2);
//    for ( int i = 0; i < 5; i++) {
//        UIButton *evbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [evbtn setImage:kGetImage(@"ic _ product _ evaluate") forState:UIControlStateSelected];
//        [evbtn setImage:kGetImage(@"ic_evaluate_grade") forState:UIControlStateNormal];
//        evbtn.selected = YES;
//        evbtn.frame =CGRectMake(lox +pading *i + xingxingwidth*i, kRealValue(110), xingxingwidth, xingxingwidth);
//        [self.bgViewImage addSubview:evbtn];
//    }
    // 注意weakSelf
    __weak __typeof(self)weakSelf = self;
    // 初始化
    self.tggStarEvaView = [TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
        // 做评星后点处理
        MHLog(@"选择了%ld个星星",count);
        [weakSelf something:count];
    }];
    self.tggStarEvaView.frame = (CGRect){kRealValue(74),kRealValue(110),kRealValue(26) * 6,kRealValue(30)};
    [self.bgViewImage addSubview:self.tggStarEvaView];
    
    // 设置展示的星星数量
     self.tggStarEvaView.starCount = 5;
    
    // 星星之间的间距，默认0.5
     self.tggStarEvaView.spacing = 0;
    
    // 星星的点击事件使能,默认YES
    // self.tggStarEvaView.tapEnabled = NO;
    
    
    NSInteger bgviewloy = kRealValue(142);
    NSInteger bgviewHeight = kRealValue(41);
    NSInteger bgviewpading = kRealValue(8);
//    NSArray *Arr = [NSArray arrayWithObjects:@"商品质量好，配送快，我很满意",@"价格实在，性价比高，我比较满意" ,@"陌狐的品质放心，速度一流。这两天被一些套路，#有点郁闷，一直支持你。#，加油＾０＾~",@"商品质量一般",nil];
    
    NSMutableArray *Arr = [NSMutableArray arrayWithArray:model.comments];
    for (int i = 0; i < 4; i ++ ) {
        MHOrderCommenetSingerModel *model = Arr[i];
        UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(10), bgviewloy + bgviewpading * i+ bgviewHeight *i, kRealValue(323), bgviewHeight)];
        bgview.userInteractionEnabled = YES;
        bgview.backgroundColor = KColorFromRGBA(0xFAFBFC, 0.98);
        [self.bgViewImage addSubview:bgview];
        
        UIButton *selelctbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selelctbtn setTitle:model.msg forState:UIControlStateNormal];
        [selelctbtn setTitleColor:KColorFromRGB(0x666666) forState:UIControlStateNormal];
        [selelctbtn setTitleColor:KColorFromRGB(0x000000) forState:UIControlStateSelected];
        [selelctbtn setImage:kGetImage(@"ic_choice_select") forState:UIControlStateSelected];
        [selelctbtn setImage:kGetImage(@"ic_choice_unselect_border") forState:UIControlStateNormal];
        selelctbtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
         selelctbtn.titleLabel.numberOfLines = 0;
        selelctbtn.frame =CGRectMake(0, 0, kRealValue(323), kRealValue(41));
        [selelctbtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
        selelctbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        selelctbtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
        selelctbtn.tag = 40000 + i;
        [selelctbtn addTarget:self action:@selector(selectAct:) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:selelctbtn];
        selelctbtn.selected = model.isselelct;
    }
    
    
    
    
}
-(void)something:(NSInteger)count
{
    if (self.Choosescrollnum) {
        self.Choosescrollnum(count);
    }
}
-(void)selectAct:(UIButton *)sender
{

    MHLog(@"%ld",sender.tag);
    if (self.Choosetext) {
        self.Choosetext(sender.tag- 40000);
    }
}
-(UIImageView *)bgViewImage
{
    if (!_bgViewImage) {
        
        _bgViewImage = [[UIImageView alloc]init];
        _bgViewImage.frame = CGRectMake(kRealValue(16), kRealValue(13), kScreenWidth-2*kRealValue(16), kRealValue(352));
        _bgViewImage.backgroundColor = [UIColor whiteColor];
        _bgViewImage.layer.masksToBounds = YES;
        _bgViewImage.layer.cornerRadius = 5;
        _bgViewImage.userInteractionEnabled =YES;
//        _bgViewImage.image = kGetImage(@"back_shadow_evaluate");
        
    }
    return _bgViewImage;
}
-(UIImageView *)productImage
{
    if (!_productImage) {
        
        _productImage = [[UIImageView alloc]init];
        _productImage.backgroundColor = kRandomColor;
        
    }
    return _productImage;
}
-(UILabel *)productname
{
    if (!_productname) {
        _productname = [[UILabel alloc]init];
        _productname.text = @"SUBLIMAGE香奈儿奢华精萃精华液";
        _productname.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
        _productname.textAlignment = NSTextAlignmentLeft;
        _productname.textColor = KColorFromRGB(0x000000);
        
    }
    return _productname;
}
-(UILabel *)productsize
{
    if (!_productsize) {
        _productsize = [[UILabel alloc]init];
        _productsize.text = @"";
        _productsize.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
        _productsize.textAlignment = NSTextAlignmentLeft;
        _productsize.textColor = KColorFromRGB(0x666666);
        
    }
    return _productsize;
}
-(UILabel *)productPrice
{
    if (!_productPrice) {
        _productPrice = [[UILabel alloc]init];
        _productPrice.text = @"¥103";
        _productPrice.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
        _productPrice.textAlignment = NSTextAlignmentLeft;
        _productPrice.textColor = KColorFromRGB(0x000000);
        
    }
    return _productPrice;
}
-(UILabel *)productCommentTitle
{
    if (!_productCommentTitle) {
        _productCommentTitle = [[UILabel alloc]init];
        _productCommentTitle.text = @"评分";
        _productCommentTitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _productCommentTitle.textAlignment = NSTextAlignmentLeft;
        _productCommentTitle.textColor = KColorFromRGB(0x000000);
        
    }
    return _productCommentTitle;
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
