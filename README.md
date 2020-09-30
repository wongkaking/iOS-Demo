# Handing-button-inside-UITableViewCell
- 假设你在tableView中的每个单元格都有一个按钮，就像这张图
- 我希望我点击按钮的时候能进入下一个Controller，或者一些其他的传值操作。
- 我们可以怎么做呢，我们可以用tag、delegate、bolck完成这些操作。
- 详情：https://www.jianshu.com/p/01ece979c6dd

![](https://upload-images.jianshu.io/upload_images/13640702-2f67d9ed96074faf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)





# Cell with Checkbox and expand section
- 每一个Cell前面会有一个Checkbox
- 通过Checkbox来表示是否选择
- 每个分类的Section可以收起或展开
- 详情：https://www.jianshu.com/p/ed2eb270835c
- 优化引入MVVM：https://www.jianshu.com/p/67ed133cee4f
- 优化为VC瘦身：https://www.jianshu.com/p/15ffd8bbdabb

![最终效果](https://upload-images.jianshu.io/upload_images/13640702-c1546bad63159be1.gif?imageMogr2/auto-orient/strip)

# Cell with TextField
- 很多App会有输入信息这样的功能，在做这些功能的时候会将textField放在cell上，但是如果没处理好就会出现滑动textField的文字消失的情况
- 我们可以通过一个model把cell的index与text对应存起来，那么就可以避免这样的问题出现
- 详情：https://www.jianshu.com/p/e450aaa2c7b6
