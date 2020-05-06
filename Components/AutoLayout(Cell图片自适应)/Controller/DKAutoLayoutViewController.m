//
//  DKAutoLayoutViewController.m
//  Function2020
//
//  Created by Docker on 2020/4/26.
//  Copyright © 2020 Docker. All rights reserved.
//

#import "DKAutoLayoutViewController.h"
#import "DKAutoLayoutCell.h"

@interface DKAutoLayoutViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray<DKAutoLayout *> *dataArray;

@end

@implementation DKAutoLayoutViewController

static NSString *const DKAutoLayoutCellId = @"DKAutoLayoutCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI {
    self.title = @"Cell图片自适应";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DKAutoLayoutCell class]) bundle:nil] forCellReuseIdentifier:DKAutoLayoutCellId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DKAutoLayoutCell *cell = [tableView dequeueReusableCellWithIdentifier:DKAutoLayoutCellId];
    cell.autoLayout = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DKAutoLayout *autoLayout = self.dataArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:autoLayout keyPath:@"autoLayout" cellClass:[DKAutoLayoutCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"12");
}

- (NSArray<DKAutoLayout *> *)dataArray {
    if (!_dataArray) {
        NSArray *tempArr = @[@{@"name": @"北京今年高考外语口试取消！",
                               @"detail": @"据北京教育考试院4月24日官方消息，为落实国家和北京市关于新冠肺炎疫情防控工作部署及要求，切实保障考生、考试工作人员的生命安全和身体健康，经研究决定，我市今年不再举行全市统一高考外语口试，相关外语专业的录取要求由招生高校提出。高考报名期间考生缴纳的外语口试费将通过考生缴费渠道全额退还。",
                               @"time": @"2019-01-03",
                               @"images": @[@{@"preImage": @"http://img4.imgtn.bdimg.com/it/u=2444550362,2139482976&fm=26&gp=0.jpg",
                                              @"orgImage": @"http://img3.redocn.com/tupian/20150112/lansediqiusucai_3828600.jpg"},
                                            @{@"preImage": @"http://img000.hc360.cn/g6/M02/04/77/wKhQsVNXho2ECHIaAAAAAJKIVoA574.jpg",
                                              @"orgImage": @"http://img0.imgtn.bdimg.com/it/u=3856147510,1546883212&fm=214&gp=0.jpg"},
                                            @{@"preImage": @"http://www.uimaker.com/uploads/allimg/110412/1_110412164512_5_lit.jpg",
                                              @"orgImage": @"http://pic.downcc.com/upload/2014-11/20141123163013.jpg"},
                                            @{@"preImage": @"http://img4.imgtn.bdimg.com/it/u=2444550362,2139482976&fm=26&gp=0.jpg",
                                              @"orgImage": @"http://img3.redocn.com/tupian/20150112/lansediqiusucai_3828600.jpg"},
                                            @{@"preImage": @"http://img000.hc360.cn/g6/M02/04/77/wKhQsVNXho2ECHIaAAAAAJKIVoA574.jpg",
                                              @"orgImage": @"http://img0.imgtn.bdimg.com/it/u=3856147510,1546883212&fm=214&gp=0.jpg"},
                                            @{@"preImage": @"http://www.uimaker.com/uploads/allimg/110412/1_110412164512_5_lit.jpg",
                                              @"orgImage": @"http://pic.downcc.com/upload/2014-11/20141123163013.jpg"},
                                            @{@"preImage": @"http://img4.imgtn.bdimg.com/it/u=2444550362,2139482976&fm=26&gp=0.jpg",
                                              @"orgImage": @"http://img3.redocn.com/tupian/20150112/lansediqiusucai_3828600.jpg"},
                                            @{@"preImage": @"http://img000.hc360.cn/g6/M02/04/77/wKhQsVNXho2ECHIaAAAAAJKIVoA574.jpg",
                                              @"orgImage": @"http://img0.imgtn.bdimg.com/it/u=3856147510,1546883212&fm=214&gp=0.jpg"},
                                            @{@"preImage": @"http://www.uimaker.com/uploads/allimg/110412/1_110412164512_5_lit.jpg",
                                              @"orgImage": @"http://pic.downcc.com/upload/2014-11/20141123163013.jpg"}
                                           ]
                             },
                             @{@"name": @"北京本地危重症患者“清零”",
                               @"detail": @"昨日，北京市第92场新冠肺炎疫情防控工作新闻发布会召开。北京新冠肺炎危重症救治专家组组长、北京天坛医院副院长周建新介绍，截至4月24日，已成功撤除危重型患者体外膜肺氧合治疗4例，使用最长时间为35天，年纪最大的患者78岁；撤除单独使用呼吸机的10例，使用最长时间为42天，年纪最大的患者85岁。目前危重症患者还剩下3人，均为境外输入病例，正在北京地坛医院接受治疗，北京本地的危重症患者已“清零”。",
                               @"time": @"2019-02-03",
                               @"images": @[@{@"preImage": @"http://img4.imgtn.bdimg.com/it/u=2444550362,2139482976&fm=26&gp=0.jpg",
                                              @"orgImage": @"http://img3.redocn.com/tupian/20150112/lansediqiusucai_3828600.jpg"},
                                            @{@"preImage": @"http://img000.hc360.cn/g6/M02/04/77/wKhQsVNXho2ECHIaAAAAAJKIVoA574.jpg",
                                              @"orgImage": @"http://img0.imgtn.bdimg.com/it/u=3856147510,1546883212&fm=214&gp=0.jpg"},
                                            @{@"preImage": @"http://www.uimaker.com/uploads/allimg/110412/1_110412164512_5_lit.jpg",
                                              @"orgImage": @"http://pic.downcc.com/upload/2014-11/20141123163013.jpg"}
                                           ]
                              },
                              @{@"name": @"北京本地危重症患者“清零”",
                                @"detail": @"昨日，北京市第92场新冠肺炎疫情防控工作新闻发布会召开。北京新冠肺炎危重症救治专家组组长、北京天坛医院副院长周建新介绍，截至4月24日，已成功撤除危重型患者体外膜肺氧合治疗4例，使用最长时间为35天，年纪最大的患者78岁；撤除单独使用呼吸机的10例，使用最长时间为42天，年纪最大的患者85岁。目前危重症患者还剩下3人，均为境外输入病例，正在北京地坛医院接受治疗，北京本地的危重症患者已“清零”。",
                                @"time": @"2019-02-03",
                                @"images": @[]
                               },
                              @{@"name": @"林允连线周星驰又闻熟悉的笑声 星爷幕后培养新人",
                                @"detail": @"很多人都比较熟悉周星驰，毕竟拍戏这一块可是有很多他的身影，特别是喜剧类电影，给观众带来了不少的笑点，可惜如今退居幕后培养新人了。",
                                @"time": @"2019-04-03",
                                @"images": @[@{@"preImage": @"http://img4.imgtn.bdimg.com/it/u=2444550362,2139482976&fm=26&gp=0.jpg",
                                               @"orgImage": @"http://img3.redocn.com/tupian/20150112/lansediqiusucai_3828600.jpg"},
                                             @{@"preImage": @"http://img000.hc360.cn/g6/M02/04/77/wKhQsVNXho2ECHIaAAAAAJKIVoA574.jpg",
                                               @"orgImage": @"http://img0.imgtn.bdimg.com/it/u=3856147510,1546883212&fm=214&gp=0.jpg"},
                                             @{@"preImage": @"http://www.uimaker.com/uploads/allimg/110412/1_110412164512_5_lit.jpg",
                                               @"orgImage": @"http://pic.downcc.com/upload/2014-11/20141123163013.jpg"}
                                            ]
                              }];
        _dataArray = [DKAutoLayout mj_objectArrayWithKeyValuesArray:tempArr];
    }
    return _dataArray;
}

@end

