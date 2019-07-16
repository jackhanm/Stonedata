//
//  STItemTableViewCell.m
//  Stonedata
//
//  Created by yuhao on 2019/7/15.
//  Copyright © 2019 hf. All rights reserved.
//

#import "STItemTableViewCell.h"
#import "MHOrderItemView.h"
@implementation STItemTableViewCell
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
    NSInteger widthW = kScreenWidth/4;
    NSArray *Arr = [NSArray arrayWithObjects:@"99+",@"8",@"9",@"0" ,nil];
    NSArray *imageArr = [NSArray arrayWithObjects:@"收藏",@"关注",@"粉丝",@"动态",nil];
    for (int i = 0 ; i < 4; i++) {
        
        CGRect frame = CGRectMake(widthW *i, 0, widthW, kRealValue(64));
        MHOrderItemView *btnView = [[MHOrderItemView alloc] initWithFrame:frame title:Arr[i] subtitle:imageArr[i]  imageHeight:kRealValue(18)];
        btnView.tag = 160000+i;
        //        btnView.backgroundColor = kRandomColor;
        [self addSubview:btnView];
        
        UITapGestureRecognizer *tapAct = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(orderType:)];
        [btnView addGestureRecognizer:tapAct];
        
    }
    
}
-(void)orderType:(UITapGestureRecognizer *)sender
{
    if (self.seeorderWithtype) {
        self.seeorderWithtype(sender.view.tag);
    }
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
