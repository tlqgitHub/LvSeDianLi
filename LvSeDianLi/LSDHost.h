//
//  LSDHost.h
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/16.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LSDHostMode) {
    LSDHostMode_Global,
    
    LSDHostMode_ZH,
    LSDHostMode_JP,
    LSDHostMode_DE,
    LSDHostMode_DK,
    
    LSDHostMode_US,
    LSDHostMode_AU,
    LSDHostMode_UK,
    LSDHostMode_FR,
    
    LSDHostMode_IT,
    LSDHostMode_MY,
    LSDHostMode_NL,
    LSDHostMode_SG,
    
    LSDHostMode_TH,
    
    LSDHostMode_KR,
    LSDHostMode_BR,
    LSDHostMode_ID,
    LSDHostMode_PH,
};

@interface LSDHost : NSObject
{
    NSString* baseHost;
}


+ (instancetype)sharedClient;

//切换域名
-(void)changeHost:(LSDHostMode)lsdHostMode;

//获取当前域名
-(NSString*)getHost;

@end
