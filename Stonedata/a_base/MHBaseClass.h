//
//  MHBaseClass.h
//  mohu
//
//  Created by AllenQin on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHBaseClass : NSObject

+ (MHBaseClass*)sharedInstance;

-(void)loginOut;

-(void)removeAppCatch;

-(NSUInteger)isErrorNetWork;


-(NSString *)createParamUrl:(NSString *)url param:(NSDictionary *)dict;


#pragma mark 弹窗展现
-(void)presentAlertWithtitle:(NSString *)title message:(NSString *)message leftbutton:(NSString *)leftbutton rightbutton:(NSString *)rightbutton leftAct:(void(^)(void))leftAction rightAct:(void(^)(void))rightAction;
@end
