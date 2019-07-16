//
//  MHManagementCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/30.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHManagementCell.h"

@implementation MHManagementCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(5), kScreenWidth - kRealValue(32), kRealValue(182))];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = kRealValue(5);
        [self addSubview:_bgView];
        [_bgView shadowPathWith:[UIColor colorWithHexString:@"756A4B" andAlpha:.15] shadowOpacity:1 shadowRadius:kRealValue(5) shadowSide:MHShadowPathMohu shadowPathWidth:2];
        
        
        UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(34), kScreenWidth - kRealValue(32), 1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        [_bgView addSubview:lineView];
        
        
        //            _leftImageView = [[UIImageView alloc] init];
        //            _leftImageView.backgroundColor = kRandomColor;
        //            [_bgView addSubview:_leftImageView];
        //            [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //                make.size.mas_equalTo(CGSizeMake(kRealValue(60), kRealValue(60)));
        //                make.top.equalTo(_bgView.mas_top).with.offset(kRealValue(44));
        //                make.left.equalTo(_bgView.mas_left).with.offset(kRealValue(10));
        //            }];
        
        //            _titlesLabel = [[UILabel alloc]init];
        //            _titlesLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
        //            _titlesLabel.textColor =[UIColor colorWithHexString:@"000000"];
        //            _titlesLabel.text  = @"美妆蛋beautyblender化妆海绵";
        //            _titlesLabel.numberOfLines = 1;
        //            [bgView addSubview:_titlesLabel];
        //            [_titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //                make.top.equalTo(self.leftImageView.mas_top).with.offset(-kRealValue(2));
        //                make.left.equalTo(self.leftImageView.mas_right).with.offset(kRealValue(9));
        //                make.width.mas_equalTo(kRealValue(285));
        //            }];
        //
        
        
        
        _dingdanLabel = [[UILabel alloc]init];
        _dingdanLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _dingdanLabel.textColor =[UIColor colorWithHexString:@"#333333"];
        
        _dingdanLabel.numberOfLines = 1;
        [_bgView addSubview:_dingdanLabel];
        [_dingdanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bgView.mas_top).with.offset(kRealValue(12));
            make.left.equalTo(_bgView.mas_left).with.offset(kRealValue(10));
            make.width.mas_equalTo(kRealValue(210));
        }];
        
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _stateLabel.textColor =[UIColor colorWithHexString:@"#FF5100"];
        //            _stateLabel.text  = @"待发货";
        _stateLabel.textAlignment = NSTextAlignmentRight;
        [_bgView addSubview:_stateLabel];
        [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bgView.mas_top).with.offset(kRealValue(10));
            make.right.equalTo(_bgView.mas_right).with.offset(-kRealValue(10));
            make.width.mas_equalTo(kRealValue(100));
        }];
        
        
        _priceLabel = [[RichStyleLabel alloc]init];
        _priceLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _priceLabel.textColor =[UIColor colorWithHexString:@"#6E6E6E"];
        //            _priceLabel.text  = @"¥171";
        _priceLabel.textAlignment = NSTextAlignmentRight;
        [_bgView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bgView.mas_top).with.offset(kRealValue(114));
            make.right.equalTo(_bgView.mas_right).with.offset(-kRealValue(10));
        }];
        //
        //            _numberLabel = [[UILabel  alloc]init];
        //            _numberLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        //            _numberLabel.text = @"x4";
        //            _numberLabel.textColor =[UIColor colorWithHexString:@"#666666"];
        //            [bgView addSubview:_numberLabel];
        //            [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //                make.bottom.equalTo(self.leftImageView.mas_bottom).with.offset(0);
        //                make.right.equalTo(bgView.mas_right).with.offset(-kRealValue(15));
        //            }];
        
        
        
        _alllabel = [[UILabel alloc]init];
        _alllabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _alllabel.textColor =[UIColor colorWithHexString:@"666666"];
        //            _alllabel.text  = @"共2件，实付：";
        [_bgView addSubview:_alllabel];
        [_alllabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bgView.mas_top).with.offset(kRealValue(115));
            make.left.equalTo(_bgView.mas_left).with.offset(kRealValue(10));
        }];
        
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _moneyLabel.textColor =[UIColor colorWithHexString:@"000000"];
        //            _moneyLabel.text  = @"995元";
        [_bgView addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bgView.mas_top).with.offset(kRealValue(114));
            make.left.equalTo(self.alllabel.mas_right).with.offset(kRealValue(1));
        }];
        
        
        
        UILabel *lineView2 = [[UILabel alloc] init];
        lineView2.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        [_bgView addSubview:lineView2];
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bgView.mas_top).with.offset(kRealValue(141));
            make.left.equalTo(_bgView.mas_left).with.offset(0);
            make.right.equalTo(_bgView.mas_right).with.offset(0);
            make.height.mas_equalTo(1/kScreenScale);
        }];
        
        
        _dataLabel = [[UILabel alloc]init];
        _dataLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _dataLabel.textColor =[UIColor colorWithHexString:@"#666666"];
        //            _dataLabel.text  = @"25ml/白色";
        [_bgView addSubview:_dataLabel];
        [_dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_bgView.mas_bottom).with.offset(-kRealValue(13));
            make.left.equalTo(_bgView.mas_left).with.offset(kRealValue(7));
        }];
        
        
        
        
        
        
        
        
    }
    
    return self;
}


-(void)createModel:(MHMyOrderListModel *)model{
    self.ActivityArr = model.products;
    _dingdanLabel.text  = [NSString stringWithFormat:@"订单号：%@",model.orderCode];
    _alllabel.text = [NSString stringWithFormat:@"共%d件，实付：",model.totalProducts];
    _moneyLabel.text = [NSString stringWithFormat:@"%@元",model.orderTruePrice];
    _dataLabel.text = [NSString stringWithFormat:@"%@  %@",model.createDate,model.createTime];
    [_priceLabel setAttributedText:[NSString stringWithFormat:@"可赚¥%@",model.commissionProfit] withRegularPattern:@"[0-9.,¥]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#FB3131"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(14)]}];
    if ([model.orderTradeState isEqualToString:@"CLOSED"]) {
        _stateLabel.text = @"已关闭";
    }else{
        if ([model.orderState isEqualToString:@"UNPAID"]) {
            _stateLabel.text = @"待付款";
        }else if ([model.orderState isEqualToString:@"UNDELIVER"]){
            _stateLabel.text = @"待发货";
        }else if ([model.orderState isEqualToString:@"UNRECEIPT"]){
            _stateLabel.text = @"待收货";
        }else if ([model.orderState isEqualToString:@"UNEVALUATED"]){
            _stateLabel.text = @"待评价";
        }else if ([model.orderState isEqualToString:@"COMPLETED"]){
            if ([model.orderTradeState isEqualToString:@"ON_GOING"]) {
              _stateLabel.text = @"待结算";
            }else{
              _stateLabel.text = @"已完成";
            }
        }else if ([model.orderState isEqualToString:@"RETURN_GOOD"]){
            _stateLabel.text = @"退换货";
        }
    }
}

-(UIScrollView *)activityScroll
{
    if (!_activityScroll) {
        _activityScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kRealValue(44), kScreenWidth - kRealValue(32), kRealValue(60))];
        _activityScroll.backgroundColor = [UIColor whiteColor];
        _activityScroll.showsHorizontalScrollIndicator = NO;
        _activityScroll.showsVerticalScrollIndicator = NO;
        for (int i = 0; i < _ActivityArr.count; i++) {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(70) * i + kRealValue(10), 0, kRealValue(60), kRealValue(60))];
            [img sd_setImageWithURL:[NSURL URLWithString:_ActivityArr[i][@"productSmallImage"]] placeholderImage:nil];
            [_activityScroll addSubview:img];
        }
         _activityScroll.contentSize = CGSizeMake(kRealValue(70) * _ActivityArr.count, kRealValue(60));
    }
    return _activityScroll;
}


-(void)setActivityArr:(NSMutableArray *)ActivityArr
{
    _ActivityArr = ActivityArr;
    [self.activityScroll removeAllSubviews];
    self.activityScroll = nil;
    [_bgView addSubview:self.activityScroll];
    
}


@end
