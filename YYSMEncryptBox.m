//
//  YYSMEncryptBox.m
//  Smartfinance
//
//  Created by ddsoul on 2021/5/18.
//  Copyright © 2021 zw z. All rights reserved.
//

#import "YYSMEncryptBox.h"

@implementation YYSMEncryptBox

+ (NSString *)sm4_creatKey {
    return [GMSm4Utils createSm4Key];
}

+ (NSString *)sm4_encryptString:(NSString *)encryStr key:(NSString *)key{
    return [GMSm4Utils ecbEncryptText:encryStr key:key];
}

+ (NSString *)sm4_decryptString:(NSString *)decryStr key:(NSString *)key{
    return [GMSm4Utils ecbDecryptText:decryStr key:key];
}

/// 加密数据流
/// @param encryData  需要加密的
+ (NSData *)sm4_encryptData:(NSData *)encryData key:(NSString *)key{
    return [GMSm4Utils ecbEncryptData:encryData key:key];
}

/// 解密数据流
/// @param decryData  需要解密的
+ (NSData *)sm4_decryptData:(NSData *)decryData key:(NSString *)key{
    return [GMSm4Utils ecbDecryptData:decryData key:key];
}

#pragma mark - SM2
+ (NSArray <NSString *>*)sm2_createKeyPair {
    NSArray <NSString *>*keys = [GMSm2Utils createKeyPair];
    return keys;
}

+ (NSString *)sm2_encryptString:(NSString *)encryptStr publicKey:(NSString *)publicKey {
    return [GMSm2Utils encryptText:encryptStr publicKey:publicKey];
}

+ (NSString *)sm2_decryptString:(NSString *)decryptStr privateKey:(NSString *)privateKey {
    return [GMSm2Utils decryptToText:decryptStr privateKey:privateKey];
}

+ (NSString *)sm2_signText:(NSString *)plaintext
                privateKey:(NSString *)privateKey
                    userID:(NSString *)userID {
    return [GMSm2Utils signText:plaintext privateKey:privateKey userID:userID];
}

+ (BOOL)sm2_verifyText:(NSString *)plaintext
                signRS:(NSString *)signRS
             publicKey:(NSString *)pubKey
                userID:(nullable NSString *)userID {
    return [GMSm2Utils verifyText:plaintext signRS:signRS publicKey:pubKey userID:userID];
}

+ (NSString *)base64_encode:(NSString *)encodeStr {

    if (!encodeStr) {
        return nil;
    }
    NSData *sData = [encodeStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [sData base64EncodedDataWithOptions:0];
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    return baseString;

}
+ (NSString *)base64_decode:(NSString *)decodeStr {

    if (!decodeStr) {
        return nil;
    }
    NSData *sData = [[NSData alloc] initWithBase64EncodedString:decodeStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *dataString = [[NSString alloc]initWithData:sData encoding:NSUTF8StringEncoding];
    return dataString;

}

//hex 转 bas464
+ (NSString *)toBase64_hex:(NSString *)hex {
    NSData *toData = [self dataWithHexString:hex];
    NSString *base64_str = [self base64Encode:toData];
    return base64_str;
}

//hex 转 data
+ (NSData *)dataWithHexString:(NSString *)hexString {

    const char* ch = [[hexString lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* data = [NSMutableData data];
    while (*ch) {
        char byte = 0;
        if ('0' <= *ch && *ch <= '9') {
            byte = *ch - '0';
        } else if ('a' <= *ch && *ch <= 'f') {
            byte = *ch - 'a' + 10;
        }
        ch++;
        byte = byte << 4;
        if (*ch) {
            if ('0' <= *ch && *ch <= '9') {
                byte += *ch - '0';
            } else if ('a' <= *ch && *ch <= 'f') {
                byte += *ch - 'a' + 10;
            }
            ch++;
        }
        [data appendBytes:&byte length:1];
    }
    return data;
}

// hex 2 byte
+ (NSData *)dataFromHexString:(NSString *)hexStr {
    if (hexStr.length%2 != 0) {
        return nil;
    }
    NSMutableData *data = [[NSMutableData alloc] init];
    for (int i = 0 ; i<hexStr.length/2; i++) {
        NSString *str = [hexStr substringWithRange:NSMakeRange(i*2,2)];
        NSScanner *scanner = [NSScanner scannerWithString:str];
        int intValue;
        [scanner scanInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

+ (NSString*)base64Encode:(NSData *)data
{
    NSData *formaterData = [data base64EncodedDataWithOptions:0];
    NSString *resultStrinng = [[NSString alloc]initWithData:formaterData encoding:NSUTF8StringEncoding];
    return resultStrinng;
    
}

+ (NSString *)stringFromByte:(Byte)byteVal {
    NSMutableString *str = [NSMutableString string];
    
    //取高四位
    Byte byte1 = byteVal>>4;
    //取低四位
    Byte byte2 = byteVal & 0xf;
    //拼接16进制字符串
    [str appendFormat:@"%x",byte1];
    [str appendFormat:@"%x",byte2];
    return str;
}


#pragma mark - base64 -> hexx
//base64 转 hex
+ (NSString *)toHex_base64:(NSString *)base64 {
    NSData *toData = [GMUtils base64Decode:base64];
    NSString *hex = [self hexStringFromData:toData];
    return hex;
}

+ (NSString *)hexStringFromData:(NSData *)data {
    NSMutableString *str = [NSMutableString string];
    Byte *byte = (Byte *)[data bytes];
    for (int i = 0; i<[data length]; i++) {
        // byte+i为指针
        [str appendString:[self stringFromByte:*(byte+i)]];
    }
    return str;
}

@end
