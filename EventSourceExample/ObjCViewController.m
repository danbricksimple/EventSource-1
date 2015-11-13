//
//  ObjCViewController.m
//  EventSource
//
//  Created by Dan Wood on 11/13/15.
//  Copyright © 2015 Inaka. All rights reserved.
//

#import "ObjCViewController.h"
#import "EventSource-Swift.h"

@interface ObjCViewController ()

@property(strong, nonatomic) EventSource *eventSource;

@end

@implementation ObjCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *server = @"http://127.0.0.1:8080/sse";
    NSString *username = @"fe8b0af5-1b50-467d-ac0b-b29d2d30136b";
    NSString *password = @"ae10ff39ca41dgf0a8";
    
    NSString *basicAuthAuthorization = [EventSource basicAuth:username password:password];
    
    
    self.eventSource = [[EventSource alloc]initWithUrl:server headers:@{@"Authorization" : basicAuthAuthorization}];
    
    [self.eventSource onOpen:^{
        NSLog(@"Connection was opened");
    }];
    
    [self.eventSource onError:^(NSError *error) {
        NSLog(@"Connection Error: %@", error.localizedDescription);
    }];
    
    [self.eventSource onMessage:^(NSString *messageId, NSString *event, NSString *data) {
        NSLog(@"Message Received: %@", data);
    }];
    
    [self.eventSource addEventListener:@"user-connected" handler:^(NSString *messageId, NSString *event, NSString *data) {
        NSLog(@"User Connected: %@", data);
    }];
}

@end
