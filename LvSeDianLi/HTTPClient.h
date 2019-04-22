//
//  HTTPClient.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/14.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "LSDAPI.h"


@interface HTTPClient : AFHTTPSessionManager

+ (instancetype)sharedClient;


@end
