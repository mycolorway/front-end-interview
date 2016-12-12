# 前端笔试题

_注意：答题前请fork这个仓库，然后把笔试答案（包括相关代码）整理好，放到fork的仓库里。_

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

__3. 假设以上 controller 并未修改，你是否可以写一个 filter, 并运用于 create, archive, vote 三个 action 中使其整个 action 被包在 transaction 中__

__4. 下图中，.container的高度和宽度是浮动的、不确定的，.box的高度和宽度都是确定的，请编写一段CSS，让.box元素在水平方向和竖直方向相对于.container容器居中，要求至少采用两种不同实现方式，并分析它们的使用场景和优缺点__

要求：不能引入除了.box和.container以外的元素辅助布局

![question 4](https://raw.githubusercontent.com/mycolorway/front-end-interview/master/images/q4.png)

__5. 假如上题中.container和.box的高度和宽度都是浮动的、不确定的，再编写一段CSS，让.box元素在水平方向和竖直方向相对于.container容器居中，要求至少采用两种不同的实现方式，并分析它们的使用场景和优缺点__

要求：实现方式不能与上一题相同

__6. 继续上一题，请使用CoffeeScript和Sass编写代码，实现切换.box元素的显示（display:block）和隐藏（display：none）状态的交互__

要求：
* 实现这样的交互动画：显示的时候从下往上移动一段距离到居中，同时opacity从0到1变化；隐藏的时候从居中位置往下移动一段距离，同时opacity从1变化到0
* 隐藏状态下，.box的`display`需要设置为`none`
* 不能使用setTimeout方法
* 合理设计，让代码易读、易维护、易扩展

__7. 观察下面的截图，从视觉设计上考虑，有哪些地方做的不好，应该怎样改进？__

![question 4](https://raw.githubusercontent.com/mycolorway/front-end-interview/master/images/q7.png)
