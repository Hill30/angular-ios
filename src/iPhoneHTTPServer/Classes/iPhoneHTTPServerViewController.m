#import "iPhoneHTTPServerViewController.h"



@interface iPhoneHTTPServerViewController ()

@end


@implementation iPhoneHTTPServerViewController

@synthesize port;

UIWebView *webView;

- (void)viewDidLoad
{
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 600)];
    webView.delegate = self;
    
    NSLog(@"%u", port);

    NSURL *url  = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:%u", port]];

    NSURLRequest *req =  [NSURLRequest requestWithURL: url];
    [webView loadRequest: req];

    
    [self.view addSubview:webView];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"%@", request);
    
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {

    NSTimer* timer = [NSTimer timerWithTimeInterval:2.0f target:self selector:@selector(updateTimer:) userInfo:webView repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //[webView stringByEvaluatingJavaScriptFromString: @"testing()"];
    
}

-(void)updateTimer:(NSTimer*)theTimer {
    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
    [dformat setDateFormat:@"HH:mm:ss"];
    NSDate* currentDate = [NSDate date];
    
    NSString *date = [dformat stringFromDate:currentDate];
    NSLog(@"%@", date);
    
    //NSString *updateWatchFunc =[[NSString alloc]initWithFormat:@"javascript:if (WebApi.NotificationService) WebApi.NotificationService.updateWatch(\"%@\")", date];
    //NSString *updateWatchFunc =[[NSString alloc]initWithFormat:@"WebApi.NotificationService.updateWatch(\"%@\")", date];
    NSString *updateWatchFunc =[[NSString alloc]initWithFormat:@"testing(\"%@\")", date];
    //@"WebApi.NotificationService.updateWatch((\"%@\"))"
    //NSLog(@"%@", updateWatchFunc);
    
    [[theTimer userInfo] stringByEvaluatingJavaScriptFromString: updateWatchFunc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@", error);
}

@end