# 前端面试题

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

__4. 下图中，.container的宽度是确定的、高度不确定，.box的高度确定、宽度不确定，请编写一段CSS，让.box元素在水平方向和竖直方向相对于.container容器居中，要求至少采用三种不同实现方式，并比较它们的优劣__

__5. 假如上题中.container和.box的高度和宽度都是浮动的、不确定的，再编写一段CSS，让.box元素在水平方向和竖直方向相对于.container容器居中，要求至少采用两种不同的实现方式，并比较它们的优劣__

__6. 继续上一题，请使用CoffeeScript和Sass编写代码，实现切换.box元素的显示（display:block）和隐藏（display：none）状态的交互__

要求：显示和隐藏的过程中实现slide up/down + fade in/out的交互动画；不能使用setTimeout方法

__7. 观察下面的截图，从视觉设计上考虑，有哪些地方做的不好，应该怎样改进？__
