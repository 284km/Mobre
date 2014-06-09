//
//  DetailViewController.m
//  Mobre
//
//  Created by kazuma on 6/9/14.
//  Copyright (c) 2014 kazuma. All rights reserved.
//

#import "DetailViewController.h"
#import "Models/EFRDefine.h"

@interface DetailViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
// ブラウザの戻る、進むボタン
@property (strong, nonatomic) UIButton *prevButton;
@property (strong, nonatomic) UIButton *nextButton;

@end


@implementation DetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.articleDic[TITLE];
    
    NSURL *url = [NSURL URLWithString:self.articleDic[LINK]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    int footerHeight = 46;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height-footerHeight)];
    self.webView.delegate = self;
    [self.webView loadRequest:req];
    [self.view addSubview:self.webView];

    // 進む戻るボタン
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.webView.frame.origin.y+self.webView.frame.size.height, WINSIZE.width, footerHeight)];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerView];

    self.prevButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.prevButton.frame = CGRectMake(0, 0, 46, footerHeight);
    [self.prevButton setTitle:@"←" forState:UIControlStateNormal];
    [self.prevButton addTarget:self action:@selector(prevButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:self.prevButton];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.nextButton.frame = CGRectMake(self.prevButton.frame.origin.x+self.prevButton.frame.size.width, self.prevButton.frame.origin.y, self.prevButton.frame.size.width, self.prevButton.frame.size.height);
    [self.nextButton addTarget:self action:@selector(nextButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextButton setTitle:@"→" forState:UIControlStateNormal];
    [footerView addSubview:self.nextButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// 通信が発生するタイミングでステータスバーにくるくるを表示させる
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// webページの読み込み中に画面を戻る際読み込みを中止させる
- (void)viewWillDisappear:(BOOL)animated {
    if (self.webView.isLoading) {
        [self.webView stopLoading];
    }
    
    [super viewWillDisappear:animated];
}

@end
