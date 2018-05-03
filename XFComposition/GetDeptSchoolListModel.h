//
//  GetDeptSchoolListModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetDeptSchoolListModel : NSObject
@property (nonatomic,strong)NSString *deptid;
@property (nonatomic,strong)NSString *deptname;




+(id)loadWithJSOn:(NSDictionary *)json;

@end
