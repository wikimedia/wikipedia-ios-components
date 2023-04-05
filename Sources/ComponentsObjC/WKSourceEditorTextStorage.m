//
//  WKSourceEditorTextStorage.m
//  
//
//  Created by Toni Sevener on 4/5/23.
//

#import "WKSourceEditorTextStorage.h"

@interface WKSourceEditorTextStorage ()

@property (nonatomic, strong) NSMutableAttributedString *backingStore;

@end

@implementation WKSourceEditorTextStorage

- (instancetype)init {
    if (self = [super init]) {
        _backingStore = [[NSMutableAttributedString alloc] init];
    }
    return self;
}

- (NSString *)string {
    return self.backingStore.string;
}

- (NSDictionary<NSAttributedStringKey, id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range {
    return [self.backingStore attributesAtIndex:location effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    [self beginEditing];
    [self.backingStore replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:str.length - range.length];
    [self endEditing];
}

- (void)setAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range {
    [self beginEditing];
    [self.backingStore setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}

- (void)removeAttribute:(NSAttributedStringKey)name rangeValues:(NSArray<NSValue *> *)rangeValues {
    [self beginEditing];
    for (NSValue *rangeValue in rangeValues) {
        [self.backingStore removeAttribute:name range:rangeValue.rangeValue];
        [self edited:NSTextStorageEditedAttributes range:rangeValue.rangeValue changeInLength:0];
    }
    
    [self endEditing];
}

- (void)addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs rangeValues:(NSArray<NSValue *> *)rangeValues {
    [self beginEditing];
    for (NSValue *rangeValue in rangeValues) {
        [self.backingStore addAttributes:attrs range:rangeValue.rangeValue];
        [self edited:NSTextStorageEditedAttributes range:rangeValue.rangeValue changeInLength:0];
    }
    
    [self endEditing];
}

- (void)processEditing {
    [super processEditing];
}

@end
