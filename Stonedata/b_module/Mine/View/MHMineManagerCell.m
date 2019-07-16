


//
//  MHMineManagerCell.m
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineManagerCell.h"
#import "MHMineitemViewTwo.h"
@implementation MHMineManagerCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createview];
    }
    return self;
}
-(void)createview
{
    
    [self addSubview:self.bgimageview];
    self.bgview = [[UIView alloc] init];
    self.bgview.frame = CGRectMake(kRealValue(0),kRealValue(10),kScreenWidth,kRealValue(148));
    self.bgview.backgroundColor= [UIColor whiteColor];
//    self.bgview.layer.cornerRadius = kRealValue(6);
    [self.bgimageview addSubview:self.bgview];
    
   NSArray *imageArr = [NSArray arrayWithObjects:@"ic_my_coupon",@"ic_my_map",@"ic_my_store",@"ic_my_collection",@"ic_my_set",nil];
    NSArray *titleArr = [NSArray arrayWithObjects:@"我的消息",@"意见反馈",@"我的店铺",@"邀请有奖",@"帮助中心",nil];
    NSArray * subtitleArr ;
    if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"1"]) {
    subtitleArr  = [NSArray arrayWithObjects:@"暂未开放",@"修改收货地址",@"升级店主立得陌币",@"管理您喜欢的商品",@"解答您的疑难问题",nil];

    }else{
     subtitleArr  = [NSArray arrayWithObjects:@"暂未开放",@"修改收货地址",@"管理您的店铺",@"管理您喜欢的商品",@"解答您的疑难问题",nil];
    
    }
//
    NSInteger pading = kRealValue(5);
    for (int i = 0; i < 3; i ++) {
        if (i == 0) {
            self.itemview  = [[MHMineitemViewTwo alloc]initWithFrame:CGRectMake(0, kRealValue(48) *i+pading, kScreenWidth, kRealValue(48)) title:titleArr[i] subtitle:subtitleArr[i] imageStr:imageArr[i] righttitle:subtitleArr[i] isline:YES isRighttitle:YES];
            self.itemview.tag = 15000+i;
            [self.bgview addSubview:self.itemview];
        }else{
            if (i == 2) {
                self.itemview= [[MHMineitemViewTwo alloc]initWithFrame:CGRectMake(0, kRealValue(48) *i+pading, kScreenWidth, kRealValue(48)) title:titleArr[i] subtitle:subtitleArr[i] imageStr:imageArr[i] righttitle:subtitleArr[i] isline:NO isRighttitle:YES];
                self.itemview.tag = 15000+i;
                [self.bgview addSubview:self.itemview];
            }
            else{
                self.itemview = [[MHMineitemViewTwo alloc]initWithFrame:CGRectMake(0, kRealValue(48) *i+pading, kScreenWidth, kRealValue(48)) title:titleArr[i] subtitle:subtitleArr[i] imageStr:imageArr[i] righttitle:subtitleArr[i] isline:YES isRighttitle:YES];
                self.itemview.tag = 15000+i;
                [self.bgview addSubview:self.itemview];
         
            }
        }
        UITapGestureRecognizer *tapact = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewtapAct:)];
        [ self.itemview addGestureRecognizer:tapact];
       
       
    }
    
   
    
}
-(void)viewtapAct:(UITapGestureRecognizer *)sender
{
    if (self.tapAct) {
        self.tapAct(sender.view.tag);
    }
}

-(UIImageView *)bgimageview
{
    if (!_bgimageview) {
        _bgimageview = [[UIImageView alloc]init];
        _bgimageview.userInteractionEnabled =YES;
        _bgimageview.backgroundColor = KColorFromRGB(0xF1F2F1);
        _bgimageview.frame = CGRectMake(0, 0, kScreenWidth, kRealValue(159));
//        _bgimageview.image= kGetImage(@"back_shadow_my_function");
    }
    return _bgimageview;
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
