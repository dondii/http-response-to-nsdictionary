//
//  BaseHttpAPI.m
//  Greyjoy
//
//  Created by Dondi Sasmita on 23/10/12.
//  Copyright (c) 2012 donsdai. All rights reserved.
//

#import "BaseHttpAPI.h"
#import "XMLReader.h"

@implementation BaseHttpAPI

@synthesize delegate = delegate_,
responseData = responseData_, connection = connection_;

- (id)initWithDictionary:(NSDictionary *)reqDict
                delegate:(id<BaseHttpAPIDelegate>)delegate{
    if (self = [super init]){
        self.delegate = delegate;
        responseData_ = [[NSMutableData alloc]init];
    }
    return self;
}

- (void)callAPI:(NSMutableURLRequest*)request
 expectResponse:(BaseAPIResponseFormat)respFormat{
    
    responseFormat_ = respFormat;
    connection_ = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

- (void)cancel{
    [connection_ cancel];
}

#pragma mark -
#pragma mark NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response{
    [responseData_ setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [responseData_ appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    switch (responseFormat_) {
        case baseAPIFormatJSON:{
            NSError *parseJSONError = nil;
            NSDictionary *jsonDictionary =
            [NSJSONSerialization JSONObjectWithData:responseData_
                                            options:NSJSONReadingMutableLeaves
                                              error:&parseJSONError];
            [delegate_ baseHttpAPIDidReturnSuccessfully:jsonDictionary];
            break;
        }
            
        case baseAPIFormatXML:{
            NSString *responseXML =
            [[NSString alloc] initWithData:responseData_
                                  encoding:NSUTF8StringEncoding];
            NSError *parseError = nil;
            NSDictionary *xmlDictionary =
            [XMLReader dictionaryForXMLString:responseXML error:parseError];
            
            [delegate_ baseHttpAPIDidReturnSuccessfully:xmlDictionary];
            
            break;
        }
            
    }
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error{
    [delegate_ baseHttpAPIDidReturnWithError:error];
}

@end
