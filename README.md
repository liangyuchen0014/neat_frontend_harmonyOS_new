这份代码的产生方式，是先扒源代码的`pages`和 `views`部分，扒的过程中保留了一些基本的数据模型，例如bean、model等。在这些数据模型文件中，原本可能包含一些数据处理逻辑的函数，搬的时候是删掉了，为的是先避免处理逻辑放前端还是后端的复杂。

“我的“页面和”成就“页面的逻辑都已省去。

目前为止，只有下图中4个文件还有问题，但因为他们设计的控件和逻辑都比较多，例如很多的CustomDialog等，所以比较难处理。我的建议是直接在调用的位置重写那些自定义的CustomDialog。

![image-20230410230641613](https://raw.githubusercontent.com/liangyuchen0014/picGo/main/image-20230410230641613.png)

后端代码地址[liangyuchen0014/healthy-life-backend: using nest.js (github.com)](https://github.com/liangyuchen0014/healthy-life-backend)后端可以考虑用内网穿透在本地运行，有一个接口尚有bug。

前端需要在合适的位置调用httpRequest。