//
//  WKSourceEditorFormatter.h
//  
//
//  Created by Toni Sevener on 5/1/23.
//

#import <Foundation/Foundation.h>
@class WKSourceEditorTextStorageColors, WKSourceEditorTextStorageFonts;

NS_ASSUME_NONNULL_BEGIN

@interface WKSourceEditorFormatter : NSObject
@property (nonatomic, strong) WKSourceEditorTextStorageColors *colors;
@property (nonatomic, strong) WKSourceEditorTextStorageFonts *fonts;

- (instancetype)initWithColors:(WKSourceEditorTextStorageColors *)colors andFonts:(WKSourceEditorTextStorageFonts *)fonts;
- (void)applySyntaxHighlightingInString:(NSMutableAttributedString *)string toRange:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
