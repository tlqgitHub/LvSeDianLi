//
//  LSDPage2ViewController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/7/16.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDPage2ViewController.h"
#import "LSDPage3ViewController.h"

#import "ActionSheetStringPicker.h"
#import "LSDHost.h"

#import "AppDelegate.h"

@interface LSDPage2ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ib_chioceTitle;
@property (weak, nonatomic) IBOutlet UIButton *ib_btnChioce;

@property (weak, nonatomic) IBOutlet UILabel *ib_lbUserNameTitle;
@property (weak, nonatomic) IBOutlet UITextField *ib_edUserName;
@property (weak, nonatomic) IBOutlet UILabel *ib_lbUserPwdTitle;
@property (weak, nonatomic) IBOutlet UITextField *ib_edUserPwd;
@property (weak, nonatomic) IBOutlet UIButton *ib_btnCanel;
@property (weak, nonatomic) IBOutlet UIButton *ib_btnLogin;
@end

@implementation LSDPage2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initViewData];
}

//本地化
-(void)initViewData
{
    self.ib_chioceTitle.text = LocalString(@"请选择国家");
    self.ib_lbUserNameTitle.text = LocalString(@"用户名");
    self.ib_lbUserPwdTitle.text = LocalString(@"密码");
    
    self.ib_edUserName.placeholder = LocalString(@"用户名");
    self.ib_edUserPwd.placeholder = LocalString(@"密码");
    
    self.ib_edUserName.text = [USER_DEFAULT stringForKey:@"username"];
    
    [self.ib_btnCanel setTitle:LocalString(@"退出") forState:UIControlStateNormal];
    [self.ib_btnLogin setTitle:LocalString(@"登录") forState:UIControlStateNormal];
    
    NSArray *icons = [NSArray arrayWithObjects:
                      @"page_icon_gl.png",
                      
                      @"page_icon_zh.png",
                      @"page_icon_jp.png",
                      @"page_icon_de.png",
                      @"page_icon_dk.png",
                      
                      @"page_icon_us.png",
                      @"page_icon_au.png",
                      @"page_icon_uk.png",
                      @"page_icon_fr.png",
                      
                      @"page_icon_it.png",
                      @"page_icon_my.png",
                      @"page_icon_nl.png",
                      @"page_icon_sg.png",
                      
                      @"page_icon_th.png",
                      @"page_icon_kr.png",
                      @"page_icon_br.png",
                      @"page_icon_id.png",
                      
                      @"page_icon_ph.png",
                      nil];
    
    NSInteger selectedIndex = [USER_DEFAULT integerForKey:@"selectedIndex"];
    [self.ib_btnChioce setBackgroundImage:[UIImage imageNamed:icons[selectedIndex]] forState:UIControlStateNormal];
}

-(IBAction)LoginAction:(id)sender
{
    if([self checkValue])return;
    
    [self addMBProgressHUD];
    NSDictionary *pram = @{@"username":self.ib_edUserName.text,
                           @"password":self.ib_edUserPwd.text,
                           @"type":@"iOS",
                           @"device_token":[App deviceToken]};
    
    NSString* urlStr = [NSString stringWithFormat:@"%@", API_URL_GetUser2];
    
    [self httpGetUrl:urlStr WithData:pram completionHandler:^(NSDictionary *data) {
        [self dissMBProgressHUD];
        
        if ([[data stringForKey:KEY_USERID] integerValue]<0) {
            
            [self showTextErrorDialog0:LocalString(@"page2_dialog_userInfoError", @"用户名或密码错误")];
            return ;
        } 
        
        [USER_DEFAULT setObject:self.ib_edUserName.text forKey:@"username"];
        
        [USER_DEFAULT setObject:[data stringForKey:KEY_USERID] forKey:KEY_USERID];
        [USER_DEFAULT setObject:[data stringForKey:KEY_USERNAME] forKey:KEY_USERNAME];
        [USER_DEFAULT synchronize];
        
        [self.navigationController popViewControllerAnimated:YES];
    } errorHandler:^(NSString *errMsg) {
        [self dissMBProgressHUD];
    }];
}

-(BOOL)checkValue
{
    if (self.ib_edUserName.text.length<1) {
        [self showTextErrorDialog0:LocalString(@"page2_dialog_userNameNull", @"填写用户名")];
        return YES;
    }
    
    if (self.ib_edUserPwd.text.length<1) {
        [self showTextErrorDialog0:LocalString(@"page2_dialog_userPwdNull", @"填写密码")];
        return YES;
    }
    
    return NO;
}


-(IBAction)exitAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)chioceHost:(id)sender
{
    if ([self.ib_edUserName isFirstResponder]) {
        [self.ib_edUserName resignFirstResponder];
    }
    
    if ([self.ib_edUserPwd isFirstResponder]) {
        [self.ib_edUserPwd resignFirstResponder];
    }
    
    NSArray *chioces = [NSArray arrayWithObjects:
                      LocalString(@"全球"),
                        
                      LocalString(@"中国"),
                      LocalString(@"日本"),
                      LocalString(@"德国"),
                      LocalString(@"丹麦"),
                        
                      LocalString(@"美国"),
                      LocalString(@"澳大利亚"),
                      LocalString(@"英国"),
                      LocalString(@"法国"),
                        
                      LocalString(@"意大利"),
                      LocalString(@"马来西亚"),
                      LocalString(@"荷兰"),
                      LocalString(@"新加坡"),
                        
                      LocalString(@"泰国"),
                      LocalString(@"韩国"),
                      LocalString(@"巴西"),
                      LocalString(@"印尼"),
                        
                      LocalString(@"菲律宾"),
                      nil];

//    "韩国"="韩国";
//    "巴西"="巴西";
//    "印尼"="印尼";
//    "菲律宾" = "菲律宾";
    NSArray *icons = [NSArray arrayWithObjects:
                      @"page_icon_gl.png",
                      
                      @"page_icon_zh.png",
                      @"page_icon_jp.png",
                      @"page_icon_de.png",
                      @"page_icon_dk.png",
                      
                      @"page_icon_us.png",
                      @"page_icon_au.png",
                      @"page_icon_uk.png",
                      @"page_icon_fr.png",
                      
                      @"page_icon_it.png",
                      @"page_icon_my.png",
                      @"page_icon_nl.png",
                      @"page_icon_sg.png",
                      
                      @"page_icon_th.png",
                      @"page_icon_kr.png",
                      @"page_icon_br.png",
                      @"page_icon_id.png",
                      
                      @"page_icon_ph.png",
                        nil];
    
    NSInteger selectedIndex = [USER_DEFAULT integerForKey:@"selectedIndex"];
    
    [ActionSheetStringPicker showPickerWithTitle:LocalString(@"请选择国家")
                                            rows:chioces
                                initialSelection:selectedIndex
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
    
                                           [self.ib_btnChioce setBackgroundImage:[UIImage imageNamed:icons[selectedIndex]] forState:UIControlStateNormal];
                                           
                                           [USER_DEFAULT setInteger:selectedIndex forKey:@"selectedIndex"];
                                           
                                           [[LSDHost sharedClient] changeHost:selectedIndex];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    // 将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
    //    - (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
    //    frame = [textField convertRect:frame toView:self.view];
    frame = [self.view convertRect:frame fromView:textField.superview];
    
    int offset = frame.origin.y + frame.size.height - (self.view.frame.size.height - 216.0-35);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, 0-offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
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
