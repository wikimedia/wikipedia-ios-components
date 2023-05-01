//
//  WKSourceEditorTextStorage.h
//  
//
//  Created by Toni Sevener on 4/5/23.
//

#import <UIKit/UIKit.h>
@class WKSourceEditorFormatter;

NS_ASSUME_NONNULL_BEGIN

@interface WKSourceEditorTextStorage : NSTextStorage
@property (nonatomic, copy) NSMutableArray<WKSourceEditorFormatter *> *formatters;
@end

NS_ASSUME_NONNULL_END
