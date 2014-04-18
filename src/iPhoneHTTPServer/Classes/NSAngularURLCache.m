//
//  NSAngularURLCache.m
//  iPhoneHTTPServer
//
//  Created by Alexander Lozovan on 14/04/14.
//
//

#import "NSAngularURLCache.h"

@implementation NSAngularURLCache

- (NSCachedURLResponse *)cachedResponseForRequest: (NSURLRequest*)request {
    NSLog(@"hook: {%@}", [[request URL] absoluteString]);
    
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
