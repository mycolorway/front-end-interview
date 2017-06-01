# 前端笔试题

_注意：答题前请fork这个仓库，然后把笔试答案（包括相关代码）整理好，放到fork的仓库里；需要在线演示的代码，可以放到jsfiddle、codepen或者类似的服务上面。_

__1. 以下代码有没有什么问题？ 如果有，如何改进。__

关系: Post belongs_to Author

```ruby
posts = Post.limit(50)
posts.each do |post|
  puts post.author.name
end
```

__2. 我们通常只希望在 controllers 只出现 7 个标准的 action，以下 controller 如何改进？__

```ruby
class PostsController < ApplicationController
    def show
    end

    def index
    end

    def create
    end

    def archive
    end

    def vote
    end

    def share
    end
end
```

__3. 下图中，.container和.box的高度和宽度都是浮动的、不确定的，编写一段CSS，让.box元素在水平方向和竖直方向相对于.container容器居中，要求至少采用三种不同的实现方式，并分析它们的使用场景和优缺点__

要求：不能引入除了.box和.container以外的元素辅助布局

![question 3](https://raw.githubusercontent.com/mycolorway/front-end-interview/master/images/q4.png)

__4. 继续上一题，请使用CoffeeScript和Sass编写代码，实现切换.box元素的显示（display:block）和隐藏（display：none）状态的交互__

要求：
* 实现这样的交互动画：显示的时候从下往上移动一段距离到居中，同时opacity从0到1变化；隐藏的时候从居中位置往下移动一段距离，同时opacity从1变化到0
* 隐藏状态下，.box的`display`需要设置为`none`
* 使用css trasition实现动画交互，不能使用setTimeout方法
* 进行合理的模块化设计，让代码易读、易维护、易扩展

__5. 观察下面的截图，只从视觉设计上考虑，有哪些地方做的不好，应该怎样改进？__

![question 5](https://raw.githubusercontent.com/mycolorway/front-end-interview/master/images/q6.png)
