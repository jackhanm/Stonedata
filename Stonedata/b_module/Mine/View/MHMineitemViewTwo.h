//
//  MHMineitemViewTwo.h
//  mohu
//
//  Created by yuhao on 2019/1/16.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHMineitemViewTwo : UIView
@property (nonatomic, strong)UIImageView *leftIcon;
@property (nonatomic, strong)UIImageView *rightIcon;
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *subtitle;
@property (nonatomic, strong)UILabel *righttitle;

-(id)initWithFrame:(CGRect)frame title:(NSString *)title subtitle:(NSString *)subtitle imageStr:(NSString *)imageStr righttitle:(NSString *)righttitle
            isline:(BOOL)isline isRighttitle:(BOOL)isRight;
@end

NS_ASSUME_NONNULL_END
