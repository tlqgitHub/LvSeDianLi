//
//  BaseViewController.h
//  Vcooline
//
//  Created by TianLinqiang on 15/1/22.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSDAPI.h"
#import "ACMacros.h"
#import "NSDictionary+SafeAccess.h"

@interface BaseViewController : UIViewController
{
    
}

@property (strong, nonatomic) NSDictionary *parmsDic;

-(id)initWithParmsDic:(NSDictionary *)parm;

//HUD Dialog
-(void)addMBProgressHUD;
-(void)dissMBProgressHUD;

//show dialog 2s
- (void)showTextInfoDialog:(NSString*)text;
- (void)showTextErrorDialog:(NSString*)text;
- (void)showTextErrorDialog0:(NSString*)text;

//nav title
- (void)setNavBarWithText:(NSString*)title;


/**
 *  事件回调
 *
 *  @param errMsg 返回的err数据
 */
typedef void (^ActionNavBlock)();

//nav bar
- (void)addLeftNavBarWithText:(NSString*)title block:(ActionNavBlock)navAction;
- (void)addLeftNavBarWithImage:(UIImage*)image block:(ActionNavBlock)navAction;

- (void)addLeftNavBarWithText:(NSString*)title;
- (void)addLeftNavBarWithImage:(UIImage*)image;

- (void)addRightNavBarWithText:(NSString*)title block:(ActionNavBlock)navAction;
- (void)addRightNavBarWithImage:(UIImage*)image block:(ActionNavBlock)navAction;

- (void)addRightNavBarWithText:(NSString*)title;
- (void)addRightNavBarWithImage:(UIImage*)image;

- (void)addRightNavBarWithImage:(UIImage*)image text:(NSString*)text;

//action
- (void)navLeftAction;
- (void)navRightAction;

//nav null
- (void)setLeftNavBarNull;
- (void)setRightNavBarNull;

-(NSArray*)isNoArr:(NSDictionary*)data key:(NSString*)key;

@end
