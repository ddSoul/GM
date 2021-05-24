//
//  GMTestController.m
//  Smartfinance
//
//  Created by ddsoul on 2021/5/21.
//  Copyright © 2021 zw z. All rights reserved.
//

#import "GMTestController.h"
#import "YYSMEncryptBox.h"

@interface GMTestController ()

@end

@implementation GMTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
    
    UIButton *button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 30, 80, 50);
        [button setTitle:@"加密" forState:UIControlStateNormal];
        button.backgroundColor = UIColor.grayColor;
        [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:button];
}

- (void)click {
    NSString *sm4_key_base64 = @"/UuSojQj866snYMZAdPsSw==";
    NSString *sm4_key_hex = [YYSMEncryptBox toHex_base64:sm4_key_base64];
    NSString *testString = @"zhumingze加密测试";
    
    NSString *enString = [YYSMEncryptBox sm4_encryptString:testString key:sm4_key_hex];
    NSString *de_hex_String = [YYSMEncryptBox sm4_decryptString:enString key:sm4_key_hex];
    
    NSString *de_base64_string = [YYSMEncryptBox toBase64_hex:enString];
    
    NSLog(@"%@---%@",de_hex_String,de_base64_string);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
