//
//  AsyncDownloader.h
//
//  Created by Derrick Walker on 2/8/12.
//  Copyright (c) 2012 Derrick Walker. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ CompletionHandler)(NSData *apData);
typedef void (^ FailureHandler)(NSError *apError);
typedef void (^ ProgressHandler)(NSUInteger aDownloadedBytes, NSUInteger aTotalBytes);

@interface AsyncDownloader : NSObject <NSURLConnectionDelegate>
{
    // handlers
    CompletionHandler mCompletion;
    FailureHandler mFailure;
    ProgressHandler mProgressBlock;
    
    // data
    NSMutableData *mpConnectionData;
    NSUInteger mTotalDownloaded;
    NSUInteger mTotalBytes;
}

@property (nonatomic, strong) NSURLConnection *connection;

// Class Initializer
+ (id)downloadFromURL:(NSString *)apURLString
       withCompletion:(CompletionHandler)aCompletion
          withFailure:(FailureHandler)aFailure;

+ (id)downloadFromURL:(NSString *)apURLString
       withCompletion:(CompletionHandler)aCompletion
          withFailure:(FailureHandler)aFailure
  withProgressHandler:(ProgressHandler)aProgressBlock;

// Instance Initializer
- (id)initWithRequestURL:(NSString *)apURLString
          withCompletion:(CompletionHandler)aCompletion
             withFailure:(FailureHandler)aFailure;

- (id)initWithRequestURL:(NSString *)apURLString
          withCompletion:(CompletionHandler)aCompletion
             withFailure:(FailureHandler)aFailure
     withProgressHandler:(ProgressHandler)aProgressBlock;

// Public Methods
- (void)cancelRequest;

@end
