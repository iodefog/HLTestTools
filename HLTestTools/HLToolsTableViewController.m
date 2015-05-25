//
//  HLToolsTableViewController.m
//  HLTestToolsDemo
//
//  Created by lhl on 15/3/25.
//  Copyright (c) 2015年 lhl. All rights reserved.
//

#import "HLToolsTableViewController.h"
#import "Ubertesters.h"

@interface HLToolsTableViewController ()

@property (nonatomic, strong) NSArray *toolsTitleArray;
@property (nonatomic, strong) NSArray *toolsClassArray;


@end

@implementation HLToolsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[Ubertesters shared] playSystemSound:1003];

    
    self.toolsTitleArray = @[@"测网速",
                             @"电池info",
                             @"ping IP"];
    
    self.toolsClassArray = @[@"DownloadSpeedViewController",
                             @"BatteryViewController",
                             @"HLPingViewController"];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ToolsTableCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.toolsTitleArray count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToolsTableCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.toolsTitleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *class = [[NSClassFromString(self.toolsClassArray[indexPath.row]) alloc] initWithNibName:nil bundle:nil];
    class.title = self.toolsTitleArray[indexPath.row];
    [self.navigationController pushViewController:class animated:YES];
}

@end
