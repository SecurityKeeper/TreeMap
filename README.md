# 一种OC中Key-Value结构数据存储方法
在OC（Objective-C）中，对于Key-Value结构的数据存储，提供了一种NSDictionary的类，可以非常方便的存取。但NSDictionary类底层是哈希表实现，Key（键值）之间没有联系，也是无序的。对于某些对数据存储时有特殊要求的功能就无法实现。例如键值存储是人名，要按字母顺序存储读取数据，这样单独靠NSDictionary类就无法实现。
本发明就实现了一种能够有序存储Key-Value结构数据的方法。底层数据结构是平衡树实现。

---

##方法结构

整个方法主要由三个类组成，TreeMap、NSTree、NSTreeNode，三个类均继承于NSObject并满足NSCopying系列协议。

结构图：

![TreeMap.png](http://upload-images.jianshu.io/upload_images/2641798-db64033385494d39.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


- TreeMap：继承于NSObject，唯一暴露出来的类，提供了一些列方法，主要包括存储数据、读取数据、删除数据、取排在某一个位置的数据等。
- NSTree：平衡树类，支持TreeMap实现的一个类，提供了节点的插入，节点删除等内部方法。
- NSTreeNode：节点类，树结构的最小单元，提供了节点旋转操作，平衡维持，节点链接等内部方法。


##方法实现与部分流程

1. 平衡树实现选择的是[Size Balance Tree](http://wcipeg.com/wiki/Size_Balanced_Tree)，这种平衡树实现简单，插入查找效率高。`（实现原理这里省略）`
2. Key的比较方式：首先对于存储的Key可以是NSString、NSNumber、NSArray等各种满足NSCopying协议的对象。在存入Key过后，无论何种类型值最终都转换成字符串类型，提高比较排序的效率（这里对于非字串类型后面回拼接标志字段，保证取数据的正确性）。然后比较规则为，长度大的字串大，同样长度字串，从高位逐位比较Unicode码大小，最后得到Key的比较结果。
3. 流程主要包括：存储数据流程，获取数据流程，删除数据流程等，这里介绍一个插入流程图：

![Insert Flow.png](http://upload-images.jianshu.io/upload_images/2641798-98e7e8e98b50f8d7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
