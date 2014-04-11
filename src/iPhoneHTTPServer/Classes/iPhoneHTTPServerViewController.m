#import "iPhoneHTTPServerViewController.h"



@interface iPhoneHTTPServerViewController () < UIWebViewDelegate >
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, strong) NSDateFormatter* df;
@end


@implementation iPhoneHTTPServerViewController

@synthesize port;

UIWebView *webView;

- (NSDateFormatter*)df {
    if( nil == _df ){
        _df = [[NSDateFormatter alloc] init];
        [_df setDateFormat: @"HH:mm:ss"];
    }
    return _df;
}

- (NSString*)documents {
    id result = nil;
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if( 0 < [paths count] ){
        result = [paths lastObject];
    }
    return result;
}

- (void)viewDidLoad
{
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 600)];
    webView.delegate = self;
    
    NSLog(@"%u", port);

//    NSURL *url  = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:%u", port]];
    
    NSString* documents = [[NSBundle mainBundle] resourcePath];
    NSString* webPath = [documents stringByAppendingPathComponent: @"Web"];
    NSString* filePath = [webPath stringByAppendingPathComponent: @"index.html"];

    NSURL *url = [NSURL fileURLWithPath: filePath];
    NSURL* webURL = [NSURL fileURLWithPath: webPath];
    
    NSError* error = nil;
    NSString* htmlContent = [NSString stringWithContentsOfURL: url
                                                     encoding: 4
                                                        error: &error];

//    NSURLRequest *req =  [NSURLRequest requestWithURL: url];
//    [webView loadRequest: req];
    [webView loadHTMLString: htmlContent
                    baseURL: webURL];

    
    [self.view addSubview:webView];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"%@", request);
    
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {

    if( YES == [self.timer isValid] ){
        [self.timer invalidate];
    }

    @autoreleasepool {
        self.timer = [NSTimer scheduledTimerWithTimeInterval: 2.0f
                                                      target: self
                                                    selector: @selector(updateTimer:)
                                                    userInfo: webView
                                                     repeats: YES];
    }
}

-(void)updateTimer:(NSTimer*)theTimer {
    
    NSString *date = [self.df stringFromDate: [NSDate date]];
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