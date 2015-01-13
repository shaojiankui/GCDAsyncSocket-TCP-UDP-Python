//
//  UDPViewController.m
//  udp
//
//  Created by Jakey on 15/1/12.
//  Copyright (c) 2015年 jakey. All rights reserved.
//

#define HOST @"127.0.0.1"
#define PORT  8888

#import "UDPViewController.h"

@interface UDPViewController ()

@end

@implementation UDPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)connectUDPTest:(id)sender{
    int nPort = 2346;

    NSError *error = nil;
    if (!_udpSocket)
    {
        _udpSocket=nil;
    }
    _udpSocket = [[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    
    if (error!=nil) {
        NSLog(@"连接失败：%@",error);
    }else{
        NSLog(@"连接成功");
    }
    if (![_udpSocket bindToPort:nPort error:&error]) {
        NSLog(@"Error starting server (bind): %@", error);
        return;
    }
    if (![_udpSocket enableBroadcast:YES error:&error]) {
        NSLog(@"Error enableBroadcast (bind): %@", error);
        return;
    }
    if (![_udpSocket joinMulticastGroup:@"224.0.0.1"  error:&error]) {
        NSLog(@"Error joinMulticastGroup (bind): %@", error);
        return;
    }
    if (![_udpSocket beginReceiving:&error]) {
        [_udpSocket close];
        NSLog(@"Error starting server (recv): %@", error);
        return;
    }


    
}
- (IBAction)sendUDPTouched:(id)sender{

    [_udpSocket sendData:[_submitText.text dataUsingEncoding:NSUTF8StringEncoding] toHost:HOST port:PORT withTimeout:-1 tag:1];
    //NSLog(@"Udp Echo server started on port %hu", [_udpSocket localPort]);

}


-(void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address
{
    NSError *error = nil;
    NSLog(@"Message didConnectToAddress: %@",[[NSString alloc]initWithData:address encoding:NSUTF8StringEncoding]);
    [_udpSocket beginReceiving:&error];
   // [sock readDataWithTimeout:-1 tag:0];
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didNotConnect:(NSError *)error
{
    NSLog(@"Message didNotConnect: %@",error);
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    NSLog(@"Message didNotSendDataWithTag: %@",error);
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
    NSLog(@"filterContext is %@",filterContext);
    NSLog(@"Message didReceiveData :%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
   // [sock sendData:data toAddress:address withTimeout:-1 tag:0]; //一直监听
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
   // NSLog(@"Message didSendDataWithTag");
}

-(void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error
{
    NSLog(@"Message withError: %@",error);
}


@end
