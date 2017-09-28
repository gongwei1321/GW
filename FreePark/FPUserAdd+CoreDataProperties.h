//
//  FPUserAdd+CoreDataProperties.h
//  FreePark
//
//  Created by 龚伟 on 16/5/19.
//  Copyright © 2016年 zhangwx. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FPUserAdd.h"

NS_ASSUME_NONNULL_BEGIN

@interface FPUserAdd (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *cityIndex;
@property (nullable, nonatomic, retain) NSString *isUpdate;
@property (nullable, nonatomic, retain) NSString *parkName;
@property (nullable, nonatomic, retain) NSString *reviewTime;
@property (nullable, nonatomic, retain) NSString *sid;
@property (nullable, nonatomic, retain) NSString *posttime;

@end

NS_ASSUME_NONNULL_END
