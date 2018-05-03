//
//  LeftMenuModel.h
//  XFComposition
//
//  Created by wbb on 2018/4/19.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
{
    "ret_code" = 0;
    "ret_data" =     (
                      {
                          childfirst =             (
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 6;
                                                        isParent = true;
                                                        name = "\U4e00\U5e74\U7ea7";
                                                    },
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 12;
                                                        isParent = true;
                                                        name = "\U4e8c\U5e74\U7ea7";
                                                    },
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 5;
                                                        isParent = true;
                                                        name = "\U521d\U4e2d\U4e00\U5e74\U7ea7";
                                                    }
                                                    );
                          id = 3;
                          isParent = true;
                          name = "\U5e74\U7ea7";
                      },
                      {
                          childfirst =             (
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 7;
                                                        isParent = true;
                                                        name = "\U5c0f\U5b66\U5b66\U6bb5";
                                                    },
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 8;
                                                        isParent = true;
                                                        name = "\U521d\U4e2d\U5b66\U6bb5";
                                                    }
                                                    );
                          id = 4;
                          isParent = true;
                          name = "\U5b66\U6bb5";
                      },
                      {
                          childfirst =             (
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 14;
                                                        isParent = true;
                                                        name = "\U6587\U5b57\U82b3\U8349";
                                                    },
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 13;
                                                        isParent = true;
                                                        name = "\U5c11\U5e74\U6587\U5b57";
                                                    }
                                                    );
                          id = 2;
                          isParent = true;
                          name = "\U6587\U5b66\U56ed\U5730";
                      },
                      {
                          childfirst =             (
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 23;
                                                        isParent = true;
                                                        name = "\U5199\U666f";
                                                    }
                                                    );
                          id = 1;
                          isParent = true;
                          name = "\U6292\U60c5";
                      },
                      {
                          childfirst =             (
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 10;
                                                        isParent = true;
                                                        name = "\U8bed\U6587";
                                                    },
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 11;
                                                        isParent = true;
                                                        name = "\U6570\U5b66";
                                                    },
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 15;
                                                        isParent = true;
                                                        name = "\U5e8f";
                                                    },
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 16;
                                                        isParent = true;
                                                        name = "\U6587\U5b66\U7c7b";
                                                    },
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 17;
                                                        isParent = true;
                                                        name = "\U54c7\U54c8\U54c8";
                                                    },
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 18;
                                                        isParent = true;
                                                        name = "\U987a\U4e30\U901f\U9012";
                                                    },
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 19;
                                                        isParent = true;
                                                        name = "\U5c31\U770b\U89c1";
                                                    },
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 20;
                                                        isParent = true;
                                                        name = "\U8bf4\U8bf4";
                                                    },
                                                    {
                                                        childsecond =                     (
                                                        );
                                                        id = 21;
                                                        isParent = true;
                                                        name = "\U662f\U7684";
                                                    }
                                                    );
                          id = 9;
                          isParent = true;
                          name = "\U516c\U5171\U6807\U7b7e";
                      }
                      );
    "ret_msg" = "\U6210\U529f";
}


 
 */

@interface LeftMenuModel : NSObject
@property (nonatomic,copy) NSArray *childfirst;
@property (nonatomic,copy) NSString *userid;
@property (nonatomic,copy) NSString *isParent;
@property (nonatomic,copy) NSString *name;
@end

@interface LeftMenuSecondModel : NSObject
@property (nonatomic,copy) NSArray *childsecond;
@property (nonatomic,copy) NSString *userid;
@property (nonatomic,copy) NSString *isParent;
@property (nonatomic,copy) NSString *name;
@end
