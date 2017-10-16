//
//  ViewController.m
//  IPDemo
//
//  Created by dev on 2017/10/16.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ViewController.h"

#import "Utils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)clickBtn:(UIButton *)sender {

//    NSString *ipStr =  [Utils localIPAddress];
//
//    NSLog(@"------ipStr:%@----",ipStr);

    [self fetchWANIPAddressWithCompletion:^(NSString *ipAddress) {
        NSLog(@"-----ipAddress:%@----",ipAddress);
    }];
    
}

- (void)fetchWANIPAddressWithCompletion:(void(^)(NSString *ipAddress))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@"http://ifconfig.me/ip"];
        NSError *error = nil;
        NSString *ipString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(@"fetch WAN IP Address failed:%@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(ipString);
            });
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
