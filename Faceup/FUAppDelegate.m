//
//  FUAppDelegate.m
//  Faceup
//
//  Created by Matthew Holden on 8/13/13.
//  Copyright (c) 2013 OGD. All rights reserved.
//

#import "FUAppDelegate.h"
#import <AFNetworking/AFNetworking.h>

@implementation FUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    AFHTTPClient *c = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:@"https://rogerils-face1.p.mashape.com/"]];
    [c setDefaultHeader:@"X-Mashape-Authorization"
                  value:@"seQjZFom9KVBTJVL4wDjIFyRVWaGRmLO"];
    
    NSMutableURLRequest *r = [c multipartFormRequestWithMethod:@"POST" path:@"fused" parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *file1 = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"a" withExtension:@"jpg"]];
        NSData *file2 = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"b" withExtension:@"jpg"]];
        [formData appendPartWithFileData:file1 name:@"image1" fileName:@"a.jpg" mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:file2 name:@"image2" fileName:@"a.jpg" mimeType:@"image/jpeg"];
    }];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:r];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"completion: %@", responseObject);
        NSLog(@"image?: %@", [UIImage imageWithData:responseObject]);
        UIImage *img = [UIImage imageWithData:responseObject];
        NSLog(@"foo", img);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure: %@", error);
    }];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
    }];
    [c enqueueHTTPRequestOperation:operation];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
