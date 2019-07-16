//
//  MHCommentDetailCell.m
//  mohu
//
//  Created by 余浩 on 2018/9/19.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHCommentDetailCell.h"

@implementation MHCommentDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createview];
    }
    return self;
}
-(void)setModel:(MHProductCommentModel *)model
{
    //头像
    [self.head sd_setImageWithURL:[NSURL URLWithString:model.userImage] placeholderImage:kGetImage(@"user_pic")];
    //名字
    self.namelabel.text =[NSString stringWithFormat:@"%@",model.userNickname] ;
    if (klStringisEmpty( model.userNickname)) {
        self.namelabel.text  = @"匿名用户";
    }
    //时间
  
    self.timelabel.text = [NSString stringWithFormat:@"%@",model.evaluateTime];
    //评分
    
   

    
    //星星
    for (int i =0 ; i< [model.evaluateScore1 integerValue]; i++) {
        self.starImageview = [[UIImageView alloc]init];
        self.starImageview.image =kGetImage(@"ic_evaluate_bright");
        [self addSubview:self.starImageview];
        [self.starImageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.head.mas_bottom).offset(kRealValue(10));
            make.left.equalTo(self.mas_left).offset(kRealValue(56)+i*kRealValue(16));
            make.width.mas_equalTo(kRealValue(16));
            make.height.mas_equalTo(kRealValue(16));
        }];
    }
    //评价
    self.commetlabel.text = model.evaluateContent;
   
    //图片
    
    if (klStringisEmpty(model.evaluateImages) ) {
        
    }else{
        [self.commetPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commetlabel.mas_bottom).offset(kRealValue(10));
            make.left.equalTo(self.mas_left).offset(kRealValue(50));
            make.width.mas_equalTo(kRealValue(57));
            make.height.mas_equalTo(kRealValue(57));
        }];
        self.commetPic.image = kGetImage(kfailImage);
       
    }
    
    //
    
    self.productSize = [[UILabel alloc]init];
    self.productSize.text =model.productStandard;
    self.productSize.textColor = KColorFromRGB(0x989898);
    self.productSize.numberOfLines = 1;
    self.productSize.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    [self addSubview:self.productSize];
    [self.productSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).offset(-kRealValue(30));
        make.left.equalTo(self.mas_left).offset(kRealValue(50));
        make.right.equalTo(self.mas_right).offset(-kRealValue(16));
        make.height.mas_equalTo(kRealValue(20));
    }];
    
    //线
    UIView *bottomline = [[UIView alloc]init];
    bottomline.backgroundColor = KColorFromRGB(0xf1f1f2);
    [self addSubview:bottomline];
    [bottomline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.width.equalTo(self.mas_width).offset(0);
        make.height.mas_equalTo(1/kScreenScale);
    }];
    
    
    
}
-(void)createview
{
    self.head = [[UIImageView alloc]init];
    self.head.backgroundColor = kRandomColor;
    [self addSubview:self.head];
    
    self.namelabel = [[UILabel alloc]init];
    self.namelabel.text = @"Joseph Brown";
    self.namelabel.textColor = KColorFromRGB(0x666666);
    self.namelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    [self addSubview:self.namelabel];
    
    self.timelabel = [[UILabel alloc]init];
    self.timelabel.text = @"2018/3/8";
    self.timelabel.textColor = KColorFromRGB(0x666666);
    self.timelabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
     [self addSubview:self.timelabel];
    
    
    UILabel *evalabel = [[UILabel alloc]init];
    evalabel.textAlignment = NSTextAlignmentLeft;
    evalabel.text = @"评分: ";
    evalabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    evalabel.textColor = KColorFromRGB(0x989898);
    [self addSubview:evalabel];
  
    
    self.commetlabel = [[UILabel alloc]init];
    self.commetlabel.text =@"";
    self.commetlabel.textColor = KColorFromRGB(0x000000);
    self.commetlabel.numberOfLines = 0;
    self.commetlabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    [self addSubview:self.commetlabel];
    
    self.commetPic = [[UIImageView alloc]init];
    self.commetPic.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.commetPic];
    
    [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kRealValue(10));
        make.left.equalTo(self.mas_left).offset(kRealValue(16));
        make.width.mas_equalTo(kRealValue(24));
        make.height.mas_equalTo(kRealValue(24));
    }];
    self.head.layer.masksToBounds = YES;
    self.head.layer.cornerRadius = kRealValue(12);
    [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kRealValue(13));
        make.left.equalTo(self.head.mas_right).offset(kRealValue(16));
        make.height.mas_equalTo(kRealValue(15));
    }];
   
    [self.timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kRealValue(13));
        make.right.equalTo(self.mas_right).offset(-kRealValue(16));
        make.height.mas_equalTo(kRealValue(15));
    }];
    [evalabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.head.mas_bottom).offset(kRealValue(10));
        make.left.equalTo(self.mas_left).offset(kRealValue(16));
        make.height.mas_equalTo(kRealValue(15));
        make.width.mas_equalTo(kRealValue(40));
    }];

    [self.commetlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(evalabel.mas_bottom).offset(kRealValue(10));
        make.left.equalTo(self.mas_left).offset(kRealValue(50));
        make.right.equalTo(self.mas_right).offset(-kRealValue(16));
    }];
    
   
   

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
