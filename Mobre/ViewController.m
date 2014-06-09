//
//  ViewController.m
//  Mobre
//
//  Created by kazuma on 6/9/14.
//  Copyright (c) 2014 kazuma. All rights reserved.
//

#import "ViewController.h"
#import "EFRHatenaParser.h"
#import "Models/EFRDefine.h"
#import "DetailViewController.h"

// @interface ViewController ()
@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *articles;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [EFRHatenaParser parseResultWithCategoryName:@"it"];
//    NSLog(@"%@", [EFRHatenaParser parseResultWithCategoryName:@"it"]);

    self.title = @"はてぶホットエントリーIT";
    self.articles = [EFRHatenaParser parseResultWithCategoryName:@"it"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"ArticleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.articles[indexPath.row][TITLE];

    // cell color
    if (indexPath.row%2) {
        cell.backgroundColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:0.05];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // ハイライトを解除
    
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.articleDic = self.articles[indexPath.row]; // 追加
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
