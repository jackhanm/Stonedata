//
//  MHCommentDetailCellHeadCell.m
//  mohu
//
//  Created by 余浩 on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHCommentDetailCellHeadCell.h"
#import "MHProductDetailCellHeadTwo.h"
@implementation MHCommentDetailCellHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createview];
    }
    return self;
}
-(void)createview
{
    UIView *linebg1 =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1/kScreenScale)];
    linebg1.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    [self addSubview:linebg1];
    self.CellHead = [[MHProductDetailCellHeadTwo alloc]initWithFrame:CGRectMake(0, kRealValue(1), kScreenWidth, kRealValue(49)) title:@"用户评价" rightTitle:@"98%" isShowRight:NO];
    [self addSubview:self.CellHead];
    UIView *linebg =  [[UIView alloc]initWithFrame:CGRectMake(0,  self.CellHead.frame.size.height, kScreenWidth,1/kScreenScale)];
    linebg.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    [self addSubview:linebg];
    
    
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
