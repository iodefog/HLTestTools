//
//  BatteryViewController.m
//  HLTestToolsDemo
//
//  Created by lhl on 15/3/31.
//  Copyright (c) 2015年 lhl. All rights reserved.
//

#import "BatteryViewController.h"
#import "MBBatteryMonitor.h"

@interface BatteryViewController ()

@end

@implementation BatteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *battery = [[UILabel alloc] initWithFrame:self.view.bounds];
    battery.textAlignment = NSTextAlignmentCenter;
    battery.numberOfLines = 0;
    battery.textColor = [UIColor blueColor];
    [self.view addSubview:battery];
    
    MBBatteryMonitor *monitor =  [[MBBatteryMonitor alloc] init];
    [monitor startService];
    MBBatteryState *batteryState = [monitor currentBatteryState];
    NSString *barreryInfo = [NSString stringWithFormat:@"手机插电:%@\n正在充电:%@\n完全充电:%@\n正在放电:%@\n电池电量:%@%%",
                             batteryState.isPluggedIn?@"YES":@"NO",
                             batteryState.isCharging?@"YES":@"NO",
                             batteryState.isFullyCharged?@"YES":@"NO",
                             batteryState.isDraining?@"YES":@"NO",
                             @(batteryState.batteryLevel*100)];
    battery.text = barreryInfo;
    [monitor stopService];
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
