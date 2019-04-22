//
//  HTTPViewController.h
//  Vcooline
//
//  Created by TianLinqiang on 15/1/22.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "BaseViewController.h"

/**
 *  数据返回
 *
 *  @param data 返回的数据
 */
typedef void (^SuccessfulBlock)(NSDictionary *data);
/**
 *  数据返回
 *
 *  @param errMsg 返回的err数据
 */
typedef void (^FailureBlock)(NSString *errMsg);


@interface BaseHTTPViewController : BaseViewController

//http post
- (void)httpPostUrl:(NSString*)urlStr
           WithData:(NSDictionary*)data
  completionHandler:(SuccessfulBlock)completionBlock
       errorHandler:(FailureBlock) errorBlock;

//http get
- (void)httpGetUrl:(NSString*)urlStr
          WithData:(NSDictionary*)data
 completionHandler:(SuccessfulBlock)completionBlock
      errorHandler:(FailureBlock) errorBlock;

@end


