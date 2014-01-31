//
//  FileManager.h
//
//  Created by Derrick Walker on 12/29/11.
//  Copyright (c) 2011 Derrick Walker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (FileManager)

// paths
+ (NSString *)FileSharingPath;
+ (NSString *)PrivatePath;
+ (NSString *)MoviePath;
+ (NSString *)PicturesPath;
+ (NSString *)MusicPath;
+ (NSString *)TemporaryPath;
+ (NSString *)DocumentsDirectory;

// attributes
+ (NSArray *)contentsOfDirectoryAtPath:(NSString *)apDirectoryPath;
+ (NSInteger)numberOfFilesInDirectoryAtPath:(NSString *)apDirectoryPath;
+ (NSDictionary *)attributesForFileAtPath:(NSString *)apFilePath;
+ (NSDate *)dateCreatedForFileAtPath:(NSString *)apFilePath;
+ (NSDate *)dateModifiedForFileAtPath:(NSString *)apFilePath;
+ (NSString *)fileTypeForFileAtPath:(NSString *)apFilePath;

// public methods
+ (void)setupPrivateDirectory;
+ (void)createDirectoryAtPath:(NSString *)apPath;
+ (BOOL)directoryExistsAtPath:(NSString *)apPath;
+ (BOOL)removeFileAtPath:(NSString *)apDestPath;
+ (BOOL)copyFromPath:(NSString *)apOriginPath toPath:(NSString *)apDestPath removeOriginFile:(BOOL)aRemove;
+ (BOOL)moveFromPath:(NSString *)apOriginPath toPath:(NSString *)apDestPath;
+ (double)sizeOfFileAtPath:(NSString *)apFilePath inMegaBytes:(BOOL)aMegaBytes;

@end
