//
//  ViewController.m
//  udp
//
//  Created by jakey on 14-2-26.
//  Copyright (c) 2014年 jakey. All rights reserved.
//
#define HOST @"127.0.0.1"
#define PORT  8808

#import "TCPViewController.h"

@interface TCPViewController ()

@end

@implementation TCPViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)connectTCPTest:(id)sender{
    if (!_asyncSocket)
    {
        _asyncSocket=nil;
    }
    
    _asyncSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    _asyncSocket.delegate = self;
   
    NSError *error = nil;
    [_asyncSocket connectToHost:HOST onPort:PORT withTimeout:-1 error:&error];
    if (error!=nil) {
        NSLog(@"连接失败：%@",error);
    }else{
        NSLog(@"连接成功");
    }
}
- (IBAction)sendTCPTouched:(id)sender{
    [_asyncSocket writeData:[_submitText.text dataUsingEncoding:NSUTF8StringEncoding] withTimeout:3 tag:0];
}



- (void)socket:(GCDAsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"willDisconnectWithError");
    //[self logInfo:FORMAT(@"Client Disconnected: %@:%hu", [sock connectedHost], [sock connectedPort])];
    if (err) {
        NSLog(@"错误报告：%@",err);
    }else{
        NSLog(@"连接工作正常");
    }
    _asyncSocket = nil;
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"didConnectToHost");
    NSData *writeData = [@"connected\r\n" dataUsingEncoding:NSUTF8StringEncoding];
    [sock writeData:writeData withTimeout:-1 tag:0];
    [sock readDataWithTimeout:0.5 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"didReadData");
    NSData *strData = [data subdataWithRange:NSMakeRange(0, [data length])];
    NSString *msg = [[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding];
    if(msg)
    {
        NSLog(@"%@",msg);
    }
    else
    {
        NSLog(@"错误");
    }
    [sock readDataWithTimeout:-1 tag:0]; //一直监听网络
    
}

- (void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

@end