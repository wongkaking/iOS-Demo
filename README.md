# Handing-button-inside-UITableViewCell
假设你在tableView中的每个单元格都有一个按钮，就像这张图

![](https://upload-images.jianshu.io/upload_images/13640702-2f67d9ed96074faf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

我希望我点击按钮的时候能进入下一个Controller，或者一些其他的传值操作。
我们可以怎么做呢，我们可以用tag、delegate、bolck完成这些操作。

**Tag（不推荐）**

在网上似乎很多都有提到用Tag的方法，这个方法也相对比较简单。Tag属性是原始的，用于在app中唯一标示视图，不应该用于数据储存，如果你使用很多Tag，那么你的项目很可能会存在一个滥用Tag的噩梦。我们通过代码分析，将索引值传给tag，通过tag反取索引值，获得cell中的内容，这一系列操作无疑是累赘的，耦合度高，非常不优雅，可读性也不高。

```
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell_tag", for: indexPath) as? TableViewCell_tag else { return UITableViewCell() }
        cell.setupCell(self.contentArray[indexPath.row])
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        return cell
    }

    @objc func didTapButton(_ button: UIButton){
        let row = button.tag
        let vc = SecViewController()
        vc.textLabel.text = contentArray[row]
        navigationController?.pushViewController(vc, animated: true)
    }
```



**代理Delegate（推荐）**

代理是一种通用的设计模式，有协议、委托、代理三部分组成
![](https://upload-images.jianshu.io/upload_images/13640702-f478b1cced93c61e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

协议（Protocol）
只能定义公用的一套接口，类似于一个约束代理双方的作用，但不能提供具体的实现方法
```
protocol TableViewCellDelegate: class {
    func didTapButton(_ content: String)
}
```
实现方法需要代理对象去实现
```
func didTapButton(_ content: String) {
        let vc = SecViewController()
        vc.textLabel.text = "\(content)"
        navigationController?.pushViewController(vc, animated: true)
    }
```
在iOS中一个代理可以有多个委托方，而一个委托方也可以有多个代理。代理对象在很多情况下其实是可以复用的，可以创建多个代理对象为多个委托方服务。代理方，实现具体的操作流程，委托方不需要知道实现细节。

<hr>代理是一个非常常用的方法，它的优点是安全，不会引用上下文，不容易循环引用，效率更高，因为只保存一个对象指针，直接回调，没有额外消耗；在多个通信事件的时候会显得等直观更容易维护。但是声明和实现不分是分开的，代码的连续性不好，可读性没有Block高，需要储存临时数据。


**闭包Block（推荐）**
Block是iOS4.0+ 和Mac OS X 10.6+ 引进的对C语言的扩展，用来实现匿名函数的特性。Blocks语法块代码以闭包得形式将各种内容进行传递，可以是代码块也可以是其他。
```
// Cell中Block的定义
var buttonBlock: (()->Void)?

// Controller中使用Block
cell.buttonBlock = {
            let vc = SecViewController()
            vc.textLabel.text = self.contentArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
```
<hr>Block的优点是省去写很多代理方法，更加轻型简单，能更好保证代码的连贯性。但是block容易引起循环引用导致内存溢出的问题，如果闭包当中逻辑复杂，代码也会显得略微臃肿。

##闭包与代理对比
- 代理与闭包一般都是一对一的通信
- Delegate需要定义协议方法，代理对象实现协议方法，并且需要建立代理关系才可以实现通信
Block更加简洁，不需要定义繁琐的协议方法，但通信事件比较多的话，建议使用Delegate
- Delegate运行成本低，Block成本很高。Block出栈需要将使用的数据从栈内存拷贝到堆内存，当然对象的话就是加计数，使用完或者Block置nil后才消除；Delegate只是保存了一个对象指针，直接回调，没有额外消耗。

**每一种方法都有其优缺点，根据自身项目需求选择合适的解决方案才是最佳的选项**

<hr>参考文档

[Handling button tap inside UITableView Cell without using tag](https://fluffy.es/handling-button-tap-inside-uitableviewcell-without-using-tag/#closure)

[你真的了解iOS代理设计模式吗？](https://www.jianshu.com/p/2113ffe54b30)


# Cell with Checkbox and expand section
- 每一个Cell前面会有一个Checkbox
- 通过Checkbox来表示是否选择
- 每个分类的Section可以收起或展开
- 详情：https://www.jianshu.com/p/ed2eb270835c

![最终效果](https://upload-images.jianshu.io/upload_images/13640702-c1546bad63159be1.gif?imageMogr2/auto-orient/strip)
