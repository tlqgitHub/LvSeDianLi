//
//  LSDHost.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/16.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDHost.h"

//中国：www.lvsedianli.com
//全球：www.smart-pv.net （Global）
//日本服务器主域名：jp.smart-pv.net
//德国服务器主域名：de.smart-pv.net
//丹麦服务器主域名：dk.smart-pv.net
//美国服务器主域名：us.smart-pv.net
//澳大利亚服务器主域名：au.smart-pv.net
//英国服务器主域名：uk.smart-pv.net
//法国服务器主域名：fr.smart-pv.net
//意大利服务器主域名：it.smart-pv.net
//马来西亚服务器主域名：my.smart-pv.net
//荷兰服务器主域名：nl.smart-pv.net
//新加坡服务器主域名：sg.smart-pv.net
//泰国域名：th.smart-pv.net
NSString *const LSDHostBaseURLString_TEST = @"https://app.lvsedianli.com:8084/";

NSString *const LSDHostBaseURLString_OTHER = @"https://app.smart-pv.net:8084/";

NSString *const LSDHostBaseURLString_Global = @"https://www.smart-pv.net:8080/";

NSString *const LSDHostBaseURLString_ZH = @"https://app.lvsedianli.com:8084/";

NSString *const LSDHostBaseURLString_JP = @"https://jp.smart-pv.net:8080/";
NSString *const LSDHostBaseURLString_DE = @"https://de.smart-pv.net:8080/";
NSString *const LSDHostBaseURLString_DK = @"https://dk.smart-pv.net:8080/";

NSString *const LSDHostBaseURLString_US = @"https://us.smart-pv.net:8080/";
NSString *const LSDHostBaseURLString_AU = @"https://au.smart-pv.net:8080/";
NSString *const LSDHostBaseURLString_UK = @"https://uk.smart-pv.net:8080/";
NSString *const LSDHostBaseURLString_FR = @"https://fr.smart-pv.net:8080/";

NSString *const LSDHostBaseURLString_IT = @"https://it.smart-pv.net:8080/";
NSString *const LSDHostBaseURLString_MY = @"https://my.smart-pv.net:8080/";
NSString *const LSDHostBaseURLString_NL = @"https://nl.smart-pv.net:8080/";
NSString *const LSDHostBaseURLString_SG = @"https://sg.smart-pv.net:8080/";

NSString *const LSDHostBaseURLString_TH = @"https://th.smart-pv.net:8080/";

NSString *const LSDHostBaseURLString_KR = @"https://Kr.smart-pv.net:8080/";
NSString *const LSDHostBaseURLString_BR = @"https://br.smart-pv.net:8080/";
NSString *const LSDHostBaseURLString_ID = @"https://id.smart-pv.net:8080/";
NSString *const LSDHostBaseURLString_PH = @"https://ph.smart-pv.net:8080/";




@implementation LSDHost

+ (instancetype)sharedClient
{
    static LSDHost* _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[LSDHost alloc] init];
        
        NSInteger selectedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"selectedIndex"];
        [_sharedClient changeHost:selectedIndex];
    });

    return _sharedClient;
}

//切换域名
- (void)changeHost:(LSDHostMode)lsdHostMode
{
    
    baseHost = lsdHostMode == LSDHostMode_ZH ? LSDHostBaseURLString_ZH:LSDHostBaseURLString_OTHER;
    
    return;
    
    switch (lsdHostMode) {
        case LSDHostMode_Global:
            baseHost = LSDHostBaseURLString_Global;
            break;
            
        case LSDHostMode_ZH:
            baseHost = LSDHostBaseURLString_ZH;
            break;
        case LSDHostMode_JP:
            baseHost = LSDHostBaseURLString_JP;
            break;
        case LSDHostMode_DE:
            baseHost = LSDHostBaseURLString_DE;
            break;
        case LSDHostMode_DK:
            baseHost = LSDHostBaseURLString_DK;
            break;
            
        case LSDHostMode_US:
            baseHost = LSDHostBaseURLString_US;
            break;
        case LSDHostMode_AU:
            baseHost = LSDHostBaseURLString_AU;
            break;
        case LSDHostMode_UK:
            baseHost = LSDHostBaseURLString_UK;
            break;
        case LSDHostMode_FR:
            baseHost = LSDHostBaseURLString_FR;
            break;
            
        case LSDHostMode_IT:
            baseHost = LSDHostBaseURLString_IT;
            break;
        case LSDHostMode_MY:
            baseHost = LSDHostBaseURLString_MY;
            break;
        case LSDHostMode_NL:
            baseHost = LSDHostBaseURLString_NL;
            break;
        case LSDHostMode_SG:
            baseHost = LSDHostBaseURLString_SG;
            break;
            
        case LSDHostMode_TH:
            baseHost = LSDHostBaseURLString_TH;
            break;
        case LSDHostMode_KR:
            baseHost = LSDHostBaseURLString_KR;
            break;
        case LSDHostMode_BR:
            baseHost = LSDHostBaseURLString_BR;
            break;
        case LSDHostMode_ID:
            baseHost = LSDHostBaseURLString_ID;
            
            break;
        case LSDHostMode_PH:
            baseHost = LSDHostBaseURLString_PH;
            break;
            
        default:
            baseHost = LSDHostBaseURLString_Global;
            break;
    }
    
}

//获取当前域名
- (NSString*)getHost
{
    return baseHost?baseHost:LSDHostBaseURLString_TEST;
}

@end
