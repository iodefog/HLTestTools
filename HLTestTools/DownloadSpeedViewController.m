//
//  DownloadSpeedViewController.m
//  HLTestToolsDemo
//
//  Created by lhl on 15/3/25.
//  Copyright (c) 2015年 lhl. All rights reserved.
//

#import "DownloadSpeedViewController.h"
#import "DownSpeed.h"

//#import "AFNetworking.h"
//#import "AFURLConnectionOperation+AFURLConnectionByteSpeedMeasure.h"
@interface DownloadSpeedViewController ()

@property (nonatomic, strong) UILabel     *downSpeedLabel;

@end

@implementation DownloadSpeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.downSpeedLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    self.downSpeedLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.downSpeedLabel];
    
    [self startUpdateDownSpeed:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"重测" style:UIBarButtonItemStylePlain target:self action:@selector(startUpdateDownSpeed:)];
}

- (void)startUpdateDownSpeed:(UIBarButtonItem *)barItem{
    
//    [[DownSpeed sharedInstance] downloadSpeedInKbPerSecWithDownSpeedSuccess:^(NSString *downSpeed) {
////        NSLog(@"%@", downSpeed);
//        self.downSpeedLabel.text = [NSString stringWithFormat:@"当前下载速度%@", downSpeed];
//    }];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://download.thinkbroadband.com/1GB.zip"]];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.downloadSpeedMeasure.active = YES;
//    
//    // to avoid a retain cycle one has to pass a weak reference to operation into the progress block.
//    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//        double speedInBytesPerSecond = operation.downloadSpeedMeasure.speed;
//        NSString *humanReadableSpeed = operation.downloadSpeedMeasure.humanReadableSpeed;
//        
//        NSTimeInterval remainingTimeInSeconds = [operation.downloadSpeedMeasure remainingTimeOfTotalSize:totalBytesExpectedToRead numberOfCompletedBytes:totalBytesRead];
//        NSString *humanReadableRemaingTime = [operation.downloadSpeedMeasure humanReadableRemainingTimeOfTotalSize:totalBytesExpectedToRead numberOfCompletedBytes:totalBytesRead];
//    }];
//    [operation start];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
