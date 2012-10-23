//
//  BaseHttpAPI.h
//  Greyjoy
//
//  Created by Dondi Sasmita on 23/10/12.
//  Copyright (c) 2012 donsdai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    baseAPIFormatJSON,
    baseAPIFormatXML
}BaseAPIResponseFormat;

@protocol BaseHttpAPIDelegate <NSObject>

- (void)baseHttpAPIDidReturnSuccessfully:(NSDictionary*)result;
- (void)baseHttpAPIDidReturnWithError:(NSError*)error;

@end

@interface BaseHttpAPI : NSObject <NSURLConnectionDelegate>
{
    @private
    __unsafe_unretained id<BaseHttpAPIDelegate> delegate_;
    
    NSMutableData *responseData_;
    NSURLConnection *connection_;
    NSDictionary *requestDictionary_;
    BaseAPIResponseFormat responseFormat_; // weak
}

@property (nonatomic, assign) id<BaseHttpAPIDelegate> delegate;

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *connection;

// Initialize
- (id)initWithDictionary:(NSDictionary*)reqDict
                delegate:(id<BaseHttpAPIDelegate>) delegate;

// Start calling the URL
- (void)callAPI:(NSMutableURLRequest*)request
 expectResponse:(BaseAPIResponseFormat)respFormat;

// Cancelling the current connection
- (void)cancel;

@end
