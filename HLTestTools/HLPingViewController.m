//
//  HLPingViewController.m
//  HLTestToolsDemo
//
//  Created by lhl on 15/5/25.
//  Copyright (c) 2015年 lhl. All rights reserved.
//

#import "HLPingViewController.h"
#import "SPLPing.h"

@interface HLPingViewController ()

@property (nonatomic, strong) UITextField *ipTextField;

@property (nonatomic, strong) UITextView  *pingTextView;

@property (nonatomic, strong) NSString    *ip;


@end

@implementation HLPingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    
   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
    [timer fire];
}

- (void)createUI{
    
    self.ipTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 84, 300, 44)];
    self.ipTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.ipTextField.userInteractionEnabled = YES;
    self.ipTextField.text = @"baidu.com";
    self.ip = self.ipTextField.text;
    self.ipTextField.placeholder = @"your ip address or host name";
    [self.view addSubview:self.ipTextField];
    
    self.pingTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64+88, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 88-64)];
    self.pingTextView.backgroundColor = [UIColor blackColor];
    self.pingTextView.editable = NO;
    self.pingTextView.textColor = [UIColor greenColor];
    self.pingTextView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.pingTextView];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"ping" style:UIBarButtonItemStylePlain target:self action:@selector(startPing:)];
    self.view.userInteractionEnabled = YES;

}

- (void)startPing:(UIBarButtonItem *)barItem{
    self.pingTextView.text = [NSString stringWithFormat:@"%@%@", @"---------------------------\n",self.pingTextView.text];
        self.ip = self.ipTextField.text;
    [self.pingTextView scrollsToTop];
    [self.ipTextField resignFirstResponder];
}


- (void)startTimer{
    SPLPingConfiguration *configuration = [[SPLPingConfiguration alloc] initWithPingInterval:1000];
    
    [SPLPing pingOnce:self.ip configuration:configuration completion:^(SPLPingResponse * response) {
        NSString *result = nil;
        if (response.error) {
            result = [NSString stringWithFormat:@"%@",response.error ? response.error : @""];
        } else {
            result = [NSString stringWithFormat:@"64 bytes from %@ :  time=%.3f ms \n", response.ipAddress, response.duration*1000];
        }
        
        self.pingTextView.text = [NSString stringWithFormat:@"%@%@", result,self.pingTextView.text];
        [self.pingTextView scrollsToTop];
    }];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self.ipTextField resignFirstResponder];
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
