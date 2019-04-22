//
//  HTTPClient.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/14.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "HTTPClient.h"
#import "LSDHost.h"
#import "ACMacros.h"

@implementation HTTPClient

+ (instancetype)sharedClient {
    static HTTPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        DLog(@"[[LSDHost sharedClient] getHost]---::%@",[[LSDHost sharedClient] getHost]);
        _sharedClient = [[HTTPClient alloc] init];
        _sharedClient.responseSerializer = [AFXMLParserResponseSerializer serializer];
    });
    
    return _sharedClient;
}

@end
