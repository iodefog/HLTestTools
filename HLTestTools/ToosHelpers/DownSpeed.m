//
//  DownSpeed.m
//  HLTestToolsDemo
//
//  Created by LiHongli on 15/3/25.
//  Copyright (c) 2015年 lhl. All rights reserved.
//

#import "DownSpeed.h"

#define TEST_NUMBER 0
//#define URL @"https://www.google.com/images/icons/product/chrome-48.png" //This file size is 2kb, so if the test is performed 8 times the total size will be 16kb, acceptable
#define URL @"http://f.cl.ly/items/2j1N3k1u2h0D3R2o3k1h/Schermata_2013-09-04_alle_10.31.46.png" // This file size is 65kb
//#define URL @"http://f.cl.ly/items/2M1F2W3G2s0s203R2U3T/2013-09-12%2017.58.06.jpg" // This file size is 2.4mb

@interface DownSpeed(){
    DownSpeedSuccess speedSuccessBlock;
}

@property (nonatomic, strong) NSMutableData *loadData;
@property CGFloat downloadSpeed;
@property NSTimeInterval timeIntervalAtStart, timeIntervalAtEnd, timeForDownload;
@property NSURLConnection *urlConnection;
@property BOOL requestStarted, requestFinished;
@property NSInteger testCount;
@property CGFloat sumOfDownloadSpeedForAverage;

@end

@implementation DownSpeed

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}


#pragma mark - Instance methods

- (void)downloadSpeedInKbPerSec{
    self.timeForDownload = 0.0f;
    self.timeIntervalAtStart = 0.0;
    self.timeIntervalAtEnd = 0.0;
    self.loadData = [NSMutableData new];
    if (!self.requestStarted)
        [self startConnectionSpeedTest];
}

- (void)downloadSpeedInKbPerSecWithDownSpeedSuccess:(DownSpeedSuccess)downSpeedSuccess{
    speedSuccessBlock = downSpeedSuccess;
    [self downloadSpeedInKbPerSec];
}

- (void)startConnectionSpeedTest {
    self.requestStarted = YES;
    self.requestFinished = NO;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:URL]];
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [urlConnection start];
    self.timeIntervalAtStart = [[NSDate date] timeIntervalSince1970];
;
//    [NSDate timeIntervalSinceReferenceDate];
}

#pragma mark - NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.loadData appendData:data];
    self.requestFinished = NO;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    self.timeIntervalAtEnd = [[NSDate date] timeIntervalSince1970];
//    [NSDate timeIntervalSinceReferenceDate];
    
    self.timeForDownload = (self.timeIntervalAtEnd - self.timeIntervalAtStart);
    self.downloadSpeed = ((self.loadData.length/ 1024.0) / self.timeForDownload) ; //in Kb/s
    self.sumOfDownloadSpeedForAverage += self.downloadSpeed;
    self.requestFinished = YES;
    self.requestStarted = NO;
    if (self.testCount == TEST_NUMBER) {
        CGFloat avgDownloadSpeed = self.sumOfDownloadSpeedForAverage / ++self.testCount;
        
        if (avgDownloadSpeed > 1024)   {
            speedSuccessBlock([NSString stringWithFormat:@"%.2f Mb/s",avgDownloadSpeed/1024.0]);
        } else {
            speedSuccessBlock([NSString stringWithFormat:@"%.2f Kb/s",avgDownloadSpeed]);
        }
        self.loadData = nil;
        self.sumOfDownloadSpeedForAverage = 0;
        self.testCount = 0;
        
    } else {
        NSLog(@"[ALNetwork] DOWNLOAD SPEED = %f",self.downloadSpeed);
        self.testCount++;

        [self downloadSpeedInKbPerSec];
    }
}


@end
