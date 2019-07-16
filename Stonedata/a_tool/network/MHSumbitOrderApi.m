//
//  MHSumbitOrderApi.m
//  mohu
//
//  Created by AllenQin on 2018/10/10.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHSumbitOrderApi.h"
#import "CTUUID.h"
#import "NSString+WZXSSLTool.h"

@implementation MHSumbitOrderApi{
    NSDictionary          *_prod;
}

-(instancetype)initWithDict:(NSDictionary *)prod{
    self = [super init];
    if (self) {
        _prod = prod;
    }
    return self;
}


-(NSURLRequest *)buildCustomUrlRequest{
    
    NSData*jsonData = [NSJSONSerialization dataWithJSONObject:_prod options:0 error:nil];
    NSString *timeStap = [CTUUID getTimeStamp];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?appId=a2&appVer=%@&deviceId=%@&ts=%@&key=%@",kMHHost,ksumbit,[CTUUID getAppVersion],[CTUUID getIDFA],timeStap,[[NSString stringWithFormat:@"5IHqGdRBc0WxDZ%@%@",[CTUUID getIDFA],timeStap] do16MD5]]]];
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
