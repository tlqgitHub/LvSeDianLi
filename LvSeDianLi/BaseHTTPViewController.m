//
//  HTTPViewController.m
//  Vcooline
//
//  Created by TianLinqiang on 15/1/22.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "BaseHTTPViewController.h"

#import "NSData+Encrypt.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"
#import "NSDictionary+SafeAccess.h"
#import "NSString+DictionaryValue.h"

#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

#import "HTTPClient.h"

#import "NSDictionary+JSONString.h"
#import "NSDictionary+SafeAccess.h"
#import "NSString+UUID.h"
#import "NSString+hash.h"
#import "NSString+UrlEncode.h"
#import "NSDate+Addition.h"

#import "ACMacros.h"

#import "XMLDictionary.h"

#import "LSDHost.h"

@interface BaseHTTPViewController ()

@end

@implementation BaseHTTPViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

//http get
- (void)httpGetUrl:(NSString*)urlStr
          WithData:(NSDictionary*)data
 completionHandler:(SuccessfulBlock)completionBlock
      errorHandler:(FailureBlock) errorBlock
{
    NSString *URLStr = [NSString stringWithFormat:@"%@%@%@", [[LSDHost sharedClient] getHost], @"iosService.asmx/", urlStr];
    
    DLog(@"URLStr：%@\nparameters : %@",URLStr, data);
    
    [[HTTPClient sharedClient] GET:URLStr parameters:data success:^(NSURLSessionDataTask *task, id responseObject) {

        if (task.error) {
            errorBlock(LocalString(@"请求出错!"));
            return ;
        }
        
        NSDictionary * object = [NSDictionary dictionaryWithXMLParser:responseObject];
        
        DLog(@"responseObject : %@",object);
        completionBlock(object);
        
//        if ([object boolForKey:@"success"]) {
//            completionBlock(object);
//        }else{
//            errorBlock([object stringForKey:@"msg"]);
//        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"Error: %@", error);
        [self dissMBProgressHUD];
//        [self showTextErrorDialog:error.description];
        [self showTextErrorDialog0:@"network or server error!"];
    }];
}

//http post
- (void)httpPostUrl:(NSString*)urlStr
           WithData:(NSDictionary*)data
  completionHandler:(SuccessfulBlock)completionBlock
       errorHandler:(FailureBlock) errorBlock
{
    DLog(@"parameters : %@",data);
    [[HTTPClient sharedClient] POST:urlStr parameters:data success:^(NSURLSessionDataTask *task, id responseObject) {
        
        DLog(@"responseObject : %@",responseObject);
        NSDictionary * object=(NSDictionary *)responseObject;
        
        DLog(@"responseObject : %@",object);
        
        if ([object boolForKey:@"success"]) {
            completionBlock(object);
        }else{
            errorBlock([object stringForKey:@"msg"]);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"response error: %@",error);
        [self showTextErrorDialog:error.description];
    }];

}

@end
