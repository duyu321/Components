//
//  DK3DTouchAppIconViewController.m
//  Function2020
//
//  Created by Docker on 2020/4/29.
//  Copyright © 2020 Docker. All rights reserved.
//

#import "DK3DTouchAppIconViewController.h"
#import "DKShortcut.h"

@interface DK3DTouchAppIconViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray<DKShortcut *> *selectedArray;
@property (strong, nonatomic) NSMutableArray<DKShortcut *> *unSelectedArray;

@end

@implementation DK3DTouchAppIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self setUI];
}

- (void)setUI {
    self.title = @"App Icon 3D-Touch";
    
    // 读取已添加的Shortcut
    NSString *edPatch = [kDocuments stringByAppendingPathComponent:@"Shortcut.plist"];
    self.selectedArray = [DKShortcut mj_objectArrayWithKeyValuesArray:[NSMutableArray arrayWithContentsOfFile:edPatch]];

    // 读取未添加Shortcut
    NSString *unPatch = [kDocuments stringByAppendingPathComponent:@"UnShortcut.plist"];
    NSMutableArray *unPatchArr = [NSMutableArray arrayWithContentsOfFile:unPatch];
    if (!unPatchArr) { // 首次创建未添加
        unPatchArr = @[@{@"icon":@"photo_delete",
                               @"title":@"打开",
                               @"subtitle":@"",
                               @"methods":@"shortcut.open",
                             },
                             @{@"icon":@"photo_delete",
                               @"title":@"拍照",
                               @"subtitle":@"",
                               @"methods":@"shortcut.photo",
                             },
                             @{@"icon":@"photo_delete",
                               @"title":@"聊天",
                               @"subtitle":@"",
                               @"methods":@"shortcut.call",
                             }
                            ].mutableCopy;
        [unPatchArr writeToFile:unPatch atomically:YES]; // 没有会自动创建，写入是异步的，所以不能用
    }
    self.unSelectedArray = [DKShortcut mj_objectArrayWithKeyValuesArray:unPatchArr];
    
    [self.tableView setEditing:YES animated:YES];
//    plist 设置方式
//    <key>UIApplicationShortcutItems</key>
//    <array>
//        <dict>
//            <key>UIApplicationShortcutItemIconFile</key>
//            <string>photo_delete</string>
//            <key>UIApplicationShortcutItemType</key>
//            <string>ShortCutOpen</string>
//            <key>UIApplicationShortcutItemTitle</key>
//            <string>打开</string>
//            <key>UIApplicationShortcutItemSubtitle</key>
//            <string>点击打开App</string>
//        </dict>
//        <dict>
//            <key>UIApplicationShortcutItemIconType</key>
//            <string>UIApplicationShortcutIconTypeLove</string>
//            <key>UIApplicationShortcutItemType</key>
//            <string>ShortCutLove</string>
//            <key>UIApplicationShortcutItemTitle</key>
//            <string>聊天</string>
//            <key>UIApplicationShortcutItemSubtitle</key>
//            <string>马上开始</string>
//        </dict>
//        <dict>
//            <key>UIApplicationShortcutItemIconType</key>
//            <string>UIApplicationShortcutIconTypeBookmark</string>
//            <key>UIApplicationShortcutItemType</key>
//            <string>ShortCutFriend</string>
//            <key>UIApplicationShortcutItemTitle</key>
//            <string>朋友圈</string>
//            <key>UIApplicationShortcutItemSubtitle</key>
//            <string>秀一下朋友圈</string>
//        </dict>
//    </array>
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    DKShortcut *cut = sourceIndexPath.section == 0 ? self.selectedArray[sourceIndexPath.row] : self.unSelectedArray[sourceIndexPath.row];
    if (sourceIndexPath.section == 0) [self.selectedArray removeObjectAtIndex:sourceIndexPath.row];
    if (sourceIndexPath.section == 1) [self.unSelectedArray removeObjectAtIndex:sourceIndexPath.row];

    if (destinationIndexPath.section == 0) [self.selectedArray insertObject:cut atIndex:destinationIndexPath.row];
    if (destinationIndexPath.section == 1) [self.unSelectedArray insertObject:cut atIndex:destinationIndexPath.row];

    // 保存到plist
    [self saveShortcut];
    // 根据plist设置Shortcut
    [self setShortcut];
    [self.tableView reloadData];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DKShortcut *shortcut = self.selectedArray[indexPath.row];
        [self.selectedArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.unSelectedArray insertObject:shortcut atIndex:0];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
    }
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        DKShortcut *shortcut = self.unSelectedArray[indexPath.row];
        [self.unSelectedArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.selectedArray addObject:shortcut];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.selectedArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }

    // 保存到plist
    [self saveShortcut];
    // 根据plist设置Shortcut
    [self setShortcut];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)saveShortcut {
    //获取文件的完整路径
    NSString *edPatch = [kDocuments stringByAppendingPathComponent:@"Shortcut.plist"]; //没有会自动创建
    NSString *unPatch = [kDocuments stringByAppendingPathComponent:@"UnShortcut.plist"]; //没有会自动创建
    
    [[DKShortcut mj_keyValuesArrayWithObjectArray:self.selectedArray] writeToFile:edPatch atomically:YES];
    [[DKShortcut mj_keyValuesArrayWithObjectArray:self.unSelectedArray] writeToFile:unPatch atomically:YES];
}

- (void)setShortcut {
    //获取文件的完整路径
    NSString *edPatch = [kDocuments stringByAppendingPathComponent:@"Shortcut.plist"]; //没有会自动创建
    
    NSArray<DKShortcut *> *shortcutArray = [DKShortcut mj_objectArrayWithKeyValuesArray:[NSMutableArray arrayWithContentsOfFile:edPatch]];
    NSMutableArray *arrShortcutItem = [NSMutableArray array];
    for (DKShortcut *cut in shortcutArray) {
        UIApplicationShortcutItem *shoreItem = [[UIApplicationShortcutItem alloc] initWithType:cut.methods localizedTitle:cut.title localizedSubtitle:cut.subtitle icon:[UIApplicationShortcutIcon iconWithTemplateImageName:cut.icon] userInfo:nil];
        [arrShortcutItem addObject:shoreItem];
    }
    UIApplicationShortcutItem *shoreItem = [[UIApplicationShortcutItem alloc] initWithType:@"shortcut.add" localizedTitle:@"添加更多快捷方式" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"photo_delete"] userInfo:nil];
    [arrShortcutItem addObject:shoreItem];
    [UIApplication sharedApplication].shortcutItems = arrShortcutItem;
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.selectedArray.count;
    }
    return self.unSelectedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShortcutCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShortcutCell"];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = self.selectedArray[indexPath.row].title;
    } else {
        cell.textLabel.text = self.unSelectedArray[indexPath.row].title;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"已添加";
    }
    return @"添加更多";
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (NSMutableArray<DKShortcut *> *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}

- (NSMutableArray<DKShortcut *> *)unSelectedArray {
    if (!_unSelectedArray) {
        _unSelectedArray = [NSMutableArray array];
    }
    return _unSelectedArray;
}

@end
