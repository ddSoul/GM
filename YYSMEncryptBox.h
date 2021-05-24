//
//  YYSMEncryptBox.h
//  Smartfinance
//
//  Created by ddsoul on 2021/5/18.
//  Copyright © 2021 zw z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMObjC.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYSMEncryptBox : NSObject

#pragma mark - sm4

/// 创建SM4秘钥
+ (NSString *)sm4_creatKey;

/// 加密字符串
/// @param encryStr  需要加密的串
/// @param key 秘钥
+ (NSString *)sm4_encryptString:(NSString *)encryStr key:(NSString *)key;

/// 解密字符串
/// @param key 秘钥
+ (NSString *)sm4_decryptString:(NSString *)decryStr key:(NSString *)key;


/// 加密数据流
/// @param encryData  需要加密的
+ (NSData *)sm4_encryptData:(NSData *)encryData key:(NSString *)key;

/// 解密数据流
/// @param decryData  需要解密的
+ (NSData *)sm4_decryptData:(NSData *)decryData key:(NSString *)key;

#pragma mark - SM2
/// 创建公私钥  【0】公钥 【1】私钥
+ (NSArray <NSString *>*)sm2_createKeyPair;

//加密传入待加密明文和公钥，解密传入密文和私钥即可
+ (NSString *)sm2_encryptString:(NSString *)encryptStr publicKey:(NSString *)publicKey;
+ (NSString *)sm2_decryptString:(NSString *)decryptStr privateKey:(NSString *)privateKey;

/// 返回签名后的串
/// @param signText t
/// @param privateKey key
/// @param userID usrid
+ (NSString *)sm2_signText:(NSString *)signText
                privateKey:(NSString *)privateKey
                    userID:(NSString *)userID;


/// 验证签名结果
/// @param plaintext 传入明文
/// @param signRS 签名后的串
/// @param pubKey pubkey
/// @param userID userid
+ (BOOL)sm2_verifyText:(NSString *)plaintext
                signRS:(NSString *)signRS
             publicKey:(NSString *)pubKey
                userID:(nullable NSString *)userID;

//+ (NSString *)sm2_derEncodeString:(NSString *)signString;

#pragma mark - base64
//+ (NSString *)base64_encode:(NSString *)encodeStr;
//+ (NSString *)base64_decode:(NSString *)decodeStr;

//hex 转 bas464
+ (NSString *)toBase64_hex:(NSString *)hex;

//base64 转 hex
+ (NSString *)toHex_base64:(NSString *)base64;

@end

NS_ASSUME_NONNULL_END
