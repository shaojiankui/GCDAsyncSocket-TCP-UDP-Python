//
//  UDPViewController.h
//  udp
//
//  Created by Jakey on 15/1/12.
//  Copyright (c) 2015年 jakey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncUdpSocket.h"
#import "AsyncUdpSocket.h"
@interface UDPViewController : UIViewController<GCDAsyncUdpSocketDelegate>
{
    GCDAsyncUdpSocket *_udpSocket;
}
@property (retain, nonatomic) IBOutlet UITextField *submitText;
- (IBAction)connectUDPTest:(id)sender;
- (IBAction)sendUDPTouched:(id)sender;
@end
