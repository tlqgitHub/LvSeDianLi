//
//  LSDMsgDesViewController.m
//  LvSeDianLi
//
//  Created by TianLinqiang on 15/8/29.
//  Copyright (c) 2015年 TianLinqiang. All rights reserved.
//

#import "LSDMsgDesViewController.h"

@interface LSDMsgDesViewController ()
@property (weak, nonatomic) IBOutlet UITextView *ib_textView;

@end

@implementation LSDMsgDesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:[self.parmsDic stringForKey:@"title"]];
    
    [self.ib_textView setText:[self.parmsDic stringForKey:@"content"]];
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
