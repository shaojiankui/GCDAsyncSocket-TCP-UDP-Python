//
//  ViewController.h
//  udp
//
//  Created by jakey on 14-2-26.
//  Copyright (c) 2014年 jakey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"
#import "GCDAsyncUdpSocket.h"
@interface TCPViewController : UIViewController<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket     *_asyncSocket;
}
@property (retain, nonatomic) IBOutlet UITextField *submitText;
- (IBAction)connectTCPTest:(id)sender;
- (IBAction)sendTCPTouched:(id)sender;


@end
