//
//  NSAngularURLCache.m
//  iPhoneHTTPServer
//
//  Created by Alexander Lozovan on 14/04/14.
//
//

#import "NSAngularURLCache.h"

NSString* const kNSAngularNotification = @"angular.url.request";

@implementation NSAngularURLCache

- (NSCachedURLResponse *)cachedResponseForRequest: (NSURLRequest*)request {
    
    NSLog(@"hook: {%@}", [[request URL] absoluteString]);
    
    id url = [[request URL] absoluteString];
    id userInfo = @{
                    @"url" : url,
                    };
    
    [[NSNotificationCenter defaultCenter] postNotificationName: kNSAngularNotification
                                                        object: self
                                                      userInfo: userInfo];
    
    /*
     * note:
     * here must be supplied valid response data according to [request URL].
     */
    NSString* responceText = @"__some_fake_response__";
    NSData* responceData = [responceText dataUsingEncoding: NSUTF8StringEncoding];
    
    /*
     * compose HTTP-response
     */
    NSURLResponse* result = [[NSURLResponse alloc] initWithURL: [request URL]
                                                      MIMEType: @"text/html"
                                         expectedContentLength: [responceData length]
                                              textEncodingName: @"utf-8"];
    /*
     * compose cache response
     */
    return [[NSCachedURLResponse alloc] initWithResponse: result
                                                    data: responceData];
}

@end
