//
//  XMLReader.h
//  Greyjoy
//
//  Created by Dondi Sasmita on 23/10/12.
//  Copyright (c) 2012 donsdai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLReader : NSObject <NSXMLParserDelegate>
{
    NSMutableArray *dictionaryStack;
    NSMutableString *textInProgress;
    NSError *errorPointer;
}

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError*)errorPointer;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError*)errorPointer;

@end
