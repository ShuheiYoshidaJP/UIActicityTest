//
//  ViewController.swift
//  UIActivityTest
//
//  Created by 吉田 周平 on 2022/03/08.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func showUIActivity(_ sender: Any) {
        //TODO: URLを指定 -
        let urlString = ""
        let testText = "URLはこちら \(urlString)"
        let testURL = URL(string: urlString)!
        let testItemSource = ShareActivityItemSource(preview: testText, share: testURL)
        let activityItems = [testItemSource]
        let view = UIActivityViewController(activityItems: activityItems,
                                            applicationActivities: nil)
        present(view, animated: true, completion: nil)
    }
}

/// https://zenn.dev/ueshun/articles/4fed2b4f576e0b
/// String > URL > Image
/// UIActivityItemSourceを使うと優先度が変わる
/// 「テキストとURLを共有したい」且つ「URLをプレビューしたい」という場合は、以下のように「UIActivityItemSource経由のString」と「URL」を渡すと良い
/// 高度な設定をしたい場合はLPLinkMetadataを使ってカスタマイズできるが、iOS13からなので注意

/// ↓定義が必要となったらUIComponentの中に入れるべし
///
class ShareActivityItemSource: NSObject, UIActivityItemSource {
    private let preview: Any
    private let share: Any

    init(preview: Any, share: Any) {
        self.preview = preview
        self.share = share
        super.init()
    }
    // プレビューに表示する
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return preview
    }
    
    //共有したい
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return share
    }
}
