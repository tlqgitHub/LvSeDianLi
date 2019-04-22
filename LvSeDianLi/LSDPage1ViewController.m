//
//  LSDPage1ViewController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/16.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDPage1ViewController.h"
#import "LSDPage2ViewController.h"
#import "LSDPage3ViewController.h"

#import "NSTimer+Blocks.h"

@interface LSDPage1ViewController ()
{
    NSTimer *timer;
}

@property (weak, nonatomic) IBOutlet UILabel *ib_appName;
@property (weak, nonatomic) IBOutlet UIButton *ib_btnGo;

@property (weak, nonatomic) IBOutlet UILabel *ib_userName;
@property (weak, nonatomic) IBOutlet UILabel *ib_versionStr;
@property (weak, nonatomic) IBOutlet UIButton *ib_btnSetting;
@end

@implementation LSDPage1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self initViewData];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:10.0 block:^{
        [self goAction:nil];
    } repeats:NO];
    
    //    [timer fire]; 立即启动
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if ([timer isValid]) {
        [timer invalidate];
    }
}


-(void)initViewData
{
    NSString *userName = [USER_DEFAULT stringForKey:KEY_USERNAME];
    if (userName && userName.length>0) {
        self.ib_userName.text = userName;
    }else{
        self.ib_userName.text = @"";
    }

    [self.ib_btnGo setTitle:LocalString(@"p1_hit_me_go") forState:UIControlStateNormal];
    
    self.ib_versionStr.text = [NSString stringWithFormat:@"Ver %@", APPVersion];
    self.ib_appName.text = LocalString(@"p1_app_name");
}

-(IBAction)goAction:(id)sender
{
    NSString* userId = [USER_DEFAULT stringForKey:KEY_USERID];
    if (userId) {
        if (userId.length>0) {
            LSDPage3ViewController *contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LSDPage3ViewController"];
            ;
            [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:contentViewController] animated:YES completion:^{
                
            }];
        }
    }else{
        LSDPage2ViewController *contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LSDPage2ViewController"];
        ;
        [self.navigationController pushViewController:contentViewController animated:YES];
    }
    
}

-(IBAction)goToPage2Action:(id)sender
{
    LSDPage2ViewController *contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LSDPage2ViewController"];
    ;
    [self.navigationController pushViewController:contentViewController animated:YES];
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
