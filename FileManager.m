//
//  FileManager.m
//
//  Created by Derrick Walker on 12/29/11.
//  Copyright (c) 2011 Derrick Walker. All rights reserved.
//

#import "FileManager.h"

@implementation NSFileManager (FileManager)

#pragma mark -
#pragma mark Paths

+ (NSString *)FileSharingPath
{
    return [ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0 ];
}

+ (NSString *)PrivatePath
{
    NSString *vpSupportPath = [ NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0 ];
    
    return [vpSupportPath stringByAppendingPathComponent:@"Private/"];
}

+ (NSString *)MoviePath
{
    return [ NSSearchPathForDirectoriesInDomains(NSMoviesDirectory, NSUserDomainMask, YES) objectAtIndex:0 ];
}

+ (NSString *)PicturesPath
{
    return [ NSSearchPathForDirectoriesInDomains(NSPicturesDirectory, NSUserDomainMask, YES) objectAtIndex:0 ];
}

+ (NSString *)MusicPath
{
    return [ NSSearchPathForDirectoriesInDomains(NSMusicDirectory, NSUserDomainMask, YES) objectAtIndex:0 ];
}

+ (NSString *)TemporaryPath
{
    return NSTemporaryDirectory();
}

+ (NSString *)DocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

#pragma mark -
#pragma mark Attributes

+ (NSArray *)contentsOfDirectoryAtPath:(NSString *)apDirectoryPath
{
    if ( [NSFileManager directoryExistsAtPath:apDirectoryPath] )
    {
        NSError *vpError = nil;
        NSArray *vpContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:apDirectoryPath error:&vpError];
        
        if ( vpError )
        {
#ifdef DEBUG
            NSLog(@"Error: %@", vpError);
#endif
            
            return nil;
        }
        
        return vpContents;
    }
    
    return nil;
}

+ (NSInteger)numberOfFilesInDirectoryAtPath:(NSString *)apDirectoryPath
{
    NSArray *vpContents = [NSFileManager contentsOfDirectoryAtPath:apDirectoryPath];
    
    if ( vpContents )
    {
        return vpContents.count;
    }
    
    return 0;
}

+ (NSDictionary *)attributesForFileAtPath:(NSString *)apFilePath
{
    if ( [[NSFileManager defaultManager] fileExistsAtPath:apFilePath] )
    {
        NSError *vpError = nil;
        
        NSDictionary *vpAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:apFilePath error:&vpError];
        
        if ( vpError )
        {
            NSLog(@"Error viewing attributes of file: %@", vpError);
        }
        
        return vpAttributes;
    }
    
    return [NSDictionary dictionary];
}

+ (NSDate *)dateCreatedForFileAtPath:(NSString *)apFilePath
{
    return [(NSDictionary *)[self attributesForFileAtPath:apFilePath] valueForKey:NSFileCreationDate];
}

+ (NSDate *)dateModifiedForFileAtPath:(NSString *)apFilePath
{
    return [(NSDictionary *)[self attributesForFileAtPath:apFilePath] valueForKey:NSFileModificationDate];
}

+ (NSString *)fileTypeForFileAtPath:(NSString *)apFilePath
{
    return [(NSDictionary *)[self attributesForFileAtPath:apFilePath] valueForKey:NSFileType];
}

#pragma mark -
#pragma mark Helper Methods

+ (void)setupPrivateDirectory
{
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^ 
    {
        NSString* vpPath = [NSFileManager PrivatePath];		
          
        NSLog(@"Private application path is: %@", vpPath);
          
        [ NSFileManager createDirectoryAtPath:vpPath ]; 
    });
}

+ (void)createDirectoryAtPath:(NSString *)apPath
{
    NSError* vpError = nil;
    BOOL isDir = NO;
    
    if ( [[NSFileManager defaultManager] fileExistsAtPath:apPath isDirectory:&isDir] == NO )
    {
#ifdef DEBUG
        NSLog(@"File didn't exist");
#endif
    }
    
    if ( isDir == NO )
    {
        if ( [ [ NSFileManager defaultManager ] createDirectoryAtPath:apPath withIntermediateDirectories:YES attributes:nil error:&vpError ] )
        {
#ifdef DEBUG
            NSLog(@"Created directory at path: %@", apPath);
#endif
        }
    }
    
    if ( vpError )
    {
        NSLog(@"Creating directory at path %@, failed with error: %@", apPath, vpError);
    }
}

+ (BOOL)directoryExistsAtPath:(NSString *)apPath
{
    BOOL vIsDirectory = NO;
    
    BOOL vFileExists = [[NSFileManager defaultManager] fileExistsAtPath:apPath isDirectory:&vIsDirectory];
    
    return vFileExists && vIsDirectory;
}

+ (BOOL)removeFileAtPath:(NSString *)apDestPath
{
    NSError *vpError = nil;
    
    if ( [ [NSFileManager defaultManager] fileExistsAtPath:apDestPath ] == NO )
    {
        NSLog(@"No file found destination path to remove");
        
        return NO;
    }
    
    BOOL vStatus = [ [NSFileManager defaultManager] removeItemAtPath:apDestPath error:&vpError ];
    
    if ( vpError )
    {
        NSLog(@"Error removing destination file for copy operation");
    }
    
    return vStatus;
}

+ (BOOL)copyFromPath:(NSString *)apOriginPath toPath:(NSString *)apDestPath removeOriginFile:(BOOL)aRemove
{
    NSError *vpError = nil;
    BOOL vStatus = YES;
    
    if ( [ [NSFileManager defaultManager] fileExistsAtPath:apDestPath ] )
    {
        vStatus = [ [NSFileManager defaultManager] removeItemAtPath:apDestPath error:&vpError ];
        
        NSLog(@"File existed and was removed at destination path: %@", apDestPath);
        
        if ( vpError )
        {
            NSLog(@"Error removing destination file for copy operation");
        }
    }
    
    vpError = nil;
    
    vStatus &= [ [NSFileManager defaultManager] copyItemAtPath:apOriginPath toPath:apDestPath error:&vpError ];
    
    if ( vpError )
    {
        NSLog(@"Copy failed with error message: %@", vpError);
    }
    
    return vStatus;
}

+ (BOOL)moveFromPath:(NSString *)apOriginPath toPath:(NSString *)apDestPath
{
    NSError *vpError = nil;
    BOOL vStatus = YES;
    
    if ( [ [NSFileManager defaultManager] fileExistsAtPath:apDestPath ] )
    {
        vStatus = [ [NSFileManager defaultManager] removeItemAtPath:apDestPath error:&vpError ];
        
        NSLog(@"File existed and was removed at destination path: %@", apDestPath);
        
        if ( vpError )
        {
            NSLog(@"Error removing destination file for copy operation");
        }
    }
    
    vpError = nil;
    
    vStatus &= [ [NSFileManager defaultManager] moveItemAtPath:apOriginPath toPath:apDestPath error:&vpError ];
    
    if ( vpError )
    {
        NSLog(@"Copy failed with error message: %@", vpError);
    }
    
    return vStatus;
}

+ (double)sizeOfFileAtPath:(NSString *)apFilePath inMegaBytes:(BOOL)aMegaBytes
{
    NSDictionary *vpFileAttributes = [self attributesForFileAtPath:apFilePath];
    
    BOOL vIsDirectory = NO;
    if ( [[NSFileManager defaultManager] fileExistsAtPath:apFilePath isDirectory:&vIsDirectory] )
    {
        unsigned long long vFileSize = 0;
        
        if ( vIsDirectory )
        {
            NSDirectoryEnumerator *vpEnumerator = [ [NSFileManager defaultManager] enumeratorAtPath:apFilePath ];
            NSString *vpFileName = nil;
            
            while ( vpFileName = [vpEnumerator nextObject] )
            {
                NSDictionary *vpFileDictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:[apFilePath stringByAppendingPathComponent:vpFileName] error:nil];

                vFileSize += [vpFileDictionary fileSize];
            }
        }
        else
        {
            vFileSize = [vpFileAttributes fileSize];
        }
        
        if ( aMegaBytes )
        {
            return (double)(vFileSize/1048576.f);
        }
        
        return (double)vFileSize;
    }
    
    return 0.f;
}

@end
