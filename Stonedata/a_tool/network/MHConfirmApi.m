//
//  MHConfirmApi.m
//  mohu
//
//  Created by AllenQin on 2018/9/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHConfirmApi.h"
#import "NSString+WZXSSLTool.h"
#import "CTUUID.h"

@implementation MHConfirmApi{
    NSArray          *_prodArr;
}

- (instancetype)initWithArr:(NSArray *)prodArr{
    self = [super init];
    if (self) {
        _prodArr = prodArr;
    }
    return self;
}


-(NSURLRequest *)buildCustomUrlRequest{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:_prodArr forKey:@"products"];
    NSData*jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
     NSString *timeStap = [CTUUID getTimeStamp];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?appId=a2&appVer=%@&deviceId=%@&ts=%@&key=%@",kMHHost,kConfirm,[CTUUID getAppVersion],[CTUUID getIDFA],timeStap,[[NSString stringWithFormat:@"5IHqGdRBc0WxDZ%@%@",[CTUUID getIDFA],timeStap] do16MD5]]]];
    [request setHTTPMethod:@"POST"];
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        [request addValue:[GVUserDefaults standardUserDefaults].accessToken forHTTPHeaderField:@"accessToken"];
    }
    [request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:MHConfigServerVersion forHTTPHeaderField:@"version"];
    [request setHTTPBody:jsonData];
    return request;
}

@end
