//
//  DownSpeed.h
//  HLTestToolsDemo
//
//  Created by LiHongli on 15/3/25.
//  Copyright (c) 2015年 lhl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^DownSpeedSuccess)(NSString *downSpeed);

@interface DownSpeed : NSObject

+ (instancetype)sharedInstance;

/*! 开始测试下载速度
 Start the test for the speed of the connection
 */
- (void)downloadSpeedInKbPerSecWithDownSpeedSuccess:(DownSpeedSuccess)downSpeedSuccess;


@end
