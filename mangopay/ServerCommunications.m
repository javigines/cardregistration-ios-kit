//
//  ServerCommunications.m
//  mangopay
//
//  Copyright © 2016 mangopay. All rights reserved.
//

#import "ServerCommunications.h"

@implementation ServerCommunications

+ (void)executeMethod:(NSString*)method withBody:(NSData*)body withURL:(NSURL*)URL completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error)) completionHandler
{
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    [urlRequest setHTTPMethod:method];
    
    if (body) {
        
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [urlRequest setHTTPBody: body];
    }
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
//    if ([hasToken]) {
//        
//        sessionConfiguration.HTTPAdditionalHeaders = @{ @"X-Authorization" : [[User userManager] user_token], };
//    }
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask* dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
//                                          [self saveToken:response withData:data];
                                          
                                          if (completionHandler == nil) return;
                                          
                                          if (error)
                                          {
                                              completionHandler(nil, response, error);
                                              return;
                                          }
                                          
                                          completionHandler(data, response, nil);
                                      }];
    [dataTask resume];
}


+ (void)sampleMethod:(NSString*)sampleString completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error)) completionHandler
{    
    NSMutableDictionary *projectDictionary = [NSMutableDictionary new];
    [projectDictionary setObject:sampleString forKey:@"sampleString"];

    
    NSError *jsonSerializationError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:projectDictionary options:NSJSONWritingPrettyPrinted error:&jsonSerializationError];
    
    NSString* base_url = nil;
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/v1/auth", base_url]];
    [self executeMethod:@"POST" withBody:jsonData withURL:URL completion:completionHandler];
}

@end
