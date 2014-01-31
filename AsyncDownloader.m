//
//  AsyncDownloader.m
//
//  Created by Derrick Walker on 2/8/12.
//  Copyright (c) 2012 Derrick Walker. All rights reserved.
//

#import "AsyncDownloader.h"

static const float gcMegabytes = 1048576.f;

@implementation AsyncDownloader

@synthesize connection = mpConnection;

#pragma mark -
#pragma mark Public Methods

- (void)cancelRequest
{
    [ mpConnection cancel ];
    
    if ( mpConnectionData != nil )
    {
        mpConnectionData = nil;
    }
}

#pragma mark -
#pragma mark Initializers

+ (id)downloadFromURL:(NSString *)apURLString
       withCompletion:(CompletionHandler)aCompletion
          withFailure:(FailureHandler)aFailure
{
    return [[self alloc] initWithRequestURL:apURLString withCompletion:aCompletion withFailure:aFailure];
}

+ (id)downloadFromURL:(NSString *)apURLString
       withCompletion:(CompletionHandler)aCompletion
          withFailure:(FailureHandler)aFailure
  withProgressHandler:(ProgressHandler)aProgressBlock
{
    return [[self alloc] initWithRequestURL:apURLString withCompletion:aCompletion withFailure:aFailure withProgressHandler:aProgressBlock];
}

- (id)initWithRequestURL:(NSString *)apURLString
          withCompletion:(CompletionHandler)aCompletion
             withFailure:(FailureHandler)aFailure
{
    if ( self = [super init] )
    {
        // copy blocks to heap memory
        mCompletion = [aCompletion copy];
        mFailure = [aFailure copy];
        mProgressBlock = nil;
        
        // init mutable data container
        mpConnectionData = [[NSMutableData alloc] initWithLength:0];
    }
    
    NSURL *vpURL = [ NSURL URLWithString:apURLString ];
    NSURLRequest *vpRequest = [ NSURLRequest requestWithURL:vpURL ];
    
    self.connection = [ NSURLConnection connectionWithRequest:vpRequest delegate:self ];
    
    return self;
}

- (id)initWithRequestURL:(NSString *)apURLString
          withCompletion:(CompletionHandler)aCompletion
             withFailure:(FailureHandler)aFailure
     withProgressHandler:(ProgressHandler)aProgressBlock
{
    if ( self = [super init] )
    {
        // copy blocks to heap memory
        mCompletion = [aCompletion copy];
        mFailure = [aFailure copy];
        mProgressBlock = [aProgressBlock copy];

        // init mutable data container
        mpConnectionData = [[NSMutableData alloc] initWithLength:0];
    }
    
    NSURL *vpURL = [ NSURL URLWithString:apURLString ];
    NSURLRequest *vpRequest = [ NSURLRequest requestWithURL:vpURL ];
    
    self.connection = [ NSURLConnection connectionWithRequest:vpRequest delegate:self ];
    
    return self;
}

#pragma mark -
#pragma mark NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
{
#ifdef DEBUG
    //NSLog(@"Expected Size: %f MB", (double)response.expectedContentLength/gcMegabytes);
#endif
    
    mTotalBytes = response.expectedContentLength;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    assert(mpConnectionData);
    [ mpConnectionData appendData:data ];
    
    mTotalDownloaded += data.length;
    
    if ( mProgressBlock )
    {
        mProgressBlock(mTotalDownloaded, mTotalBytes);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
#ifdef DEBUG
    NSLog(@"Download did fail with error: %@", [error localizedDescription]);
#endif
    
    [ mpConnection cancel ];
    
    if ( mFailure )
    {
        mFailure(error);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if ( mCompletion )
    {
        mCompletion(mpConnectionData);
    }
}

@end

