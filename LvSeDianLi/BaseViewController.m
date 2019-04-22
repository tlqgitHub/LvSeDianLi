//
//  BaseViewController.m
//  Vcooline
//
//  Created by TianLinqiang on 15/1/22.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "BaseViewController.h"

#import "MMProgressHUD.h"
#import "AFMInfoBanner.h"

#import "ACMacros.h"
#import "UIImage+Color.h"
//#import <UMMobClick/MobClick.h>

@interface BaseViewController ()
{
    ActionNavBlock backBlock;
}

@end

@implementation BaseViewController

-(NSArray*)isNoArr:(NSDictionary*)data key:(NSString*)key
{
    NSArray * dataArr = [NSArray new];
  
    dataArr = [data arrayForKey:key];
    
    if(!dataArr){
        NSDictionary *tmd = [data dictionaryForKey:key];
        if (tmd) {
            dataArr = @[tmd];
        }
    }
    
    return dataArr;
}


-(id)initWithParmsDic:(NSDictionary *)parm
{
    self = [super init];
    if (self) {
        
        self.parmsDic = parm;
        return self;
    }
    return nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //set NavigationBar 背景颜色&title 颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:48/255.0 green:168/255.0 blue:145/255.0 alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    }
    
    self.view.backgroundColor = [UIColor colorWithRed:48/255.0 green:168/255.0 blue:145/255.0 alpha:1.0];
    
    [self addLeftNavBarWithImage:[UIImage imageNamed:@"back.png"]];
    
    [self setTitle:LocalString(@"p1_app_name")];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:NSStringFromClass([self class])];
    
    NSLog(@"当前VC :  %@", NSStringFromClass([self class]));
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:NSStringFromClass([self class])];
}

-(void)addMBProgressHUD
{
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleExpand];
    [MMProgressHUD showWithTitle:@"" status:@"..."];
}

-(void)dissMBProgressHUD
{
    [MMProgressHUD dismissWithSuccess:@""];
}

- (void)showTextInfoDialog:(NSString*)text
{
    [AFMInfoBanner showAndHideWithText:text style:AFMInfoBannerStyleInfo];
}

- (void)showTextErrorDialog:(NSString*)text
{
    [AFMInfoBanner showAndHideWithText:text style:AFMInfoBannerStyleError];
}

- (void)showTextErrorDialog0:(NSString*)text
{
    [MMProgressHUD showWithTitle:text];
    
    double delayInSeconds = 1.5;
//    __block ViewController* bself = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MMProgressHUD dismiss];
    });
}

- (void)setNavBarWithText:(NSString*)title
{
    if (self.navigationItem) {
        self.title = title;
    }
}

- (void)addLeftNavBarWithText:(NSString*)title block:(ActionNavBlock)navAction
{
    backBlock = nil;
    backBlock = navAction;
    
    if (self.navigationItem.leftBarButtonItem)
    {
        self.navigationItem.leftBarButtonItem= nil;
    }
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]
                                 initWithTitle:title
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(navLeftAction)];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
}

- (void)addLeftNavBarWithText:(NSString*)title
{
    if (self.navigationItem.leftBarButtonItem)
    {
        self.navigationItem.leftBarButtonItem= nil;
    }
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]
                                 initWithTitle:title
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(navLeftAction)];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
}

- (void)addLeftNavBarWithImage:(UIImage*)image block:(ActionNavBlock)navAction
{
    backBlock = nil;
    backBlock = navAction;
    
    if (self.navigationItem.leftBarButtonItem)
    {
        self.navigationItem.leftBarButtonItem= nil;
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(navLeftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBtn;
}

- (void)addLeftNavBarWithImage:(UIImage*)image
{
    if (self.navigationItem.leftBarButtonItem)
    {
        self.navigationItem.leftBarButtonItem= nil;
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(navLeftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBtn;
}


- (void)addRightNavBarWithText:(NSString*)title block:(ActionNavBlock)navAction
{
    backBlock = nil;
    backBlock = navAction;
    
    if (self.navigationItem.rightBarButtonItem)
    {
        self.navigationItem.rightBarButtonItem= nil;
    }
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]
                                     initWithTitle:title
                                     style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(navRightAction)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)addRightNavBarWithText:(NSString*)title
{
    if (self.navigationItem.rightBarButtonItem)
    {
        self.navigationItem.rightBarButtonItem= nil;
    }
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]
                                     initWithTitle:title
                                     style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(navRightAction)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)addRightNavBarWithImage:(UIImage*)image block:(ActionNavBlock)navAction
{
    backBlock = nil;
    backBlock = navAction;
    
    if (self.navigationItem.rightBarButtonItem)
    {
        self.navigationItem.rightBarButtonItem= nil;
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(navRightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)addRightNavBarWithImage:(UIImage*)image
{
    if (self.navigationItem.rightBarButtonItem)
    {
        self.navigationItem.rightBarButtonItem= nil;
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(navRightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)addRightNavBarWithImage:(UIImage*)image text:(NSString*)text
{
    if (self.navigationItem.rightBarButtonItem)
    {
        self.navigationItem.rightBarButtonItem= nil;
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width+8, image.size.height+8)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(navRightAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (text&&text.length>0)
    {
        UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(image.size.width-5, 0, 16, 16)];
        num.font = [UIFont systemFontOfSize:10];
        num.backgroundColor = [UIColor redColor];
        num.textColor = [UIColor whiteColor];
        num.textAlignment = NSTextAlignmentCenter;
        num.text = text;
        
        ViewRadius(num, 8);
        
        [button addSubview:num];
    }
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)navLeftAction
{
    if (backBlock) {
        backBlock();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navRightAction
{
    if (backBlock) {
        backBlock();
    }
}

- (void)setLeftNavBarNull
{
    if (self.navigationItem.leftBarButtonItem)
    {
        self.navigationItem.leftBarButtonItem= nil;
    }
}

- (void)setRightNavBarNull
{
    if (self.navigationItem.rightBarButtonItem)
    {
        self.navigationItem.rightBarButtonItem= nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
