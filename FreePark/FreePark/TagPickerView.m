//
//  TagPickerView.m
//  FreePark
//
//  Created by zhangwx on 15/12/14.
//  Copyright © 2015年 zhangwx. All rights reserved.
//

#import "TagPickerView.h"
#import "ParkTagCell.h"

@interface TagPickerView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation TagPickerView

+ (instancetype)instanceFromNib
{
    TagPickerView *view = [[NSBundle mainBundle] loadNibNamed:@"TagPickerView" owner:nil options:nil][0];
    view.readyPickTags = [[NSMutableArray alloc] init];
    view.pickedTags = [[NSMutableArray alloc] init];
    
    [view.readySelectList registerNib:[UINib nibWithNibName:@"ParkTagCell" bundle:nil] forCellWithReuseIdentifier:@"ParkTagCell"];
    
    return view;
}

- (void)setReadyPickTags:(NSMutableArray *)readyPickTags
{
    _readyPickTags = readyPickTags;
    [self.readySelectList reloadData];
}

#pragma mark CollectionView代理

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.readyPickTags.count;
    }else{
        return self.pickedTags.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"ParkTagCell";
    ParkTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.tagTitle.text = ((ParkTag *)self.readyPickTags[indexPath.row]).tagName;
        cell.tagTitle.font = [UIFont systemFontOfSize:16];
        cell.layer.cornerRadius = 17.5;
        cell.layer.borderColor = UIColorFromHex(0xaaaaaa).CGColor;
        if ([self.pickedTags containsObject:self.readyPickTags[indexPath.row]]) {
            cell.tagTitle.textColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = UIColorFromHex(0x1476FF);
            cell.layer.borderWidth = 0;
        }else{
            cell.tagTitle.textColor = UIColorFromHex(0xaaaaaa);
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.layer.borderWidth = 1;
        }
    }else{
        cell.tagTitle.text = ((ParkTag *)self.pickedTags[indexPath.row]).tagName;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (self.pickedTags.count >= 4) {
            [Utils showToastWithMessage:@"您不能再多选了"];
            return;
        }
        
        for (ParkTag *parkTag in self.pickedTags) {
            if ([parkTag.tagName isEqualToString:((ParkTag *)self.readyPickTags[indexPath.row]).tagName]) {
                [self.pickedTags removeObject:parkTag];
                [self.readySelectList reloadData];
                return;
            }
        }
        
        [self.pickedTags addObject:self.readyPickTags[indexPath.row]];
        [self.readySelectList reloadData];
//        [self.readyPickTags removeObjectAtIndex:indexPath.row];
        
//        __weak TagPickerView *wself = self;
        
//        [self.readySelectList performBatchUpdates:^{
//            [wself.readySelectList moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:wself.pickedTags.count-1 inSection:1]];
//
//        } completion:nil];
        
    }else{
        __weak TagPickerView *wself = self;
        
        BOOL isreadyHasIt = NO;
        for (ParkTag *parkTag in self.readyPickTags) {
            if ([parkTag.tagName isEqualToString:((ParkTag *)self.pickedTags[indexPath.row]).tagName]) {
                isreadyHasIt = YES;
                break;
            }
        }
        
        if (!(isreadyHasIt || self.readyPickTags.count == 8)) {
            [self.readyPickTags addObject:self.pickedTags[indexPath.row]];
//            [self.readyPickTags sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//                ParkTag *tag1 = obj1;
//                ParkTag *tag2 = obj2;
//                return tag1.index > tag2.index;
//            }];
            
            NSInteger realIndex = [self.readyPickTags indexOfObject:self.pickedTags[indexPath.row]];
            
            [self.pickedTags removeObjectAtIndex:indexPath.row];
            
            [self.readySelectList performBatchUpdates:^{
                [wself.readySelectList moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:realIndex inSection:0]];
            } completion:nil];
        }else{
            [self.pickedTags removeObjectAtIndex:indexPath.row];
            [self.readySelectList reloadData];
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([UIScreen mainScreen].bounds.size.width < 330) {
        return CGSizeMake(63, 35);
    }
    return CGSizeMake(84, 35);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 0, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        if (self.pickedTags.count > 3 && self.readyPickTags.count == 4) {
            return CGSizeMake(320, 26+30);
        }
        return CGSizeMake(320, 26);
    }
    return CGSizeMake(0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}

@end

@implementation ParkTag

@end
