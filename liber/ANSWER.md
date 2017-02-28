### 1. N + 1 Query
The codes equals to:
``` sql
SELECT * FROM posts LIMIT 50 /* Will result <=50 numbers of author_id */

SELECT * FROM authors WHERE `id` = [author_id_1]
SELECT * FROM authors WHERE `id` = [author_id_2]
...
SELECT * FROM authors WHERE `id` = [author_id_50]
```

To optimize, we can use:
``` sql
/* Way 1 */
SELECT * FROM posts LIMIT 50 /* Will result <=50 numbers of author_id */

SELECT * FROM authors WHERE `id` IN ([author_id_1], [author_id_2], ... [author_id_50])
```
Or
``` sql
/* Way 2 */
SELECT a.`id`, a.`author_id`, ... , b.`id`, b.`name` FROM posts AS a LEFT OUTER JOIN authors AS b ON posts.`author_id` = authors.`id`
```

The codes can simply be as below when it comes to Rails:
``` ruby
posts = Post.includes(:author).limit(50)

# No SQL query executed below:
posts.each do |post|
  puts post.author.name
end
```

Rails will decide which way(Way 1 or Way 2) to use when we use `includes` here.

What's more, can be optimized a little better (only if we just need the informations from authors ):
``` ruby
posts = Post.select(:author_id).includes(:author).limit(50)
```

### 2. 一个标准的Controller中不应该出现除7个标准方法之外的任何公有方法
这里的主要问题在于：`archive`, `vote` 和 `share`会被定义成public的，因此会暴露在所有地方，包括浏览器。
这三个方法其实都是用来更新post，所以应该写成一个update方法。

同时，新建一个文件，在里面定义一个叫做PostHelper的Module，在该文件中定义上述三个方法，及其具体实现，并声明为protected。
在PostController中include PostHelper，然后在update方法中，通过传入param来判断具体该执行哪个方法。

### 3. `around_action`的运用
感觉题目本意应该是：`并运用于archive, vote, share`，而不是`并运用于 create, archive, vote`
因为这里的场景可能是：post已经创建好了，此时别的用户可能会对该post有archive, vote, share的操作，此时需要post的创建者预览，之后进行审批。这种预览的场景很适合around_action。
``` ruby
class PostsController < ApplicationController
  around_action :preview_in_transaction, only: [:archive, :vote, :share]

  private

  def preview_in_transaction
    ActionRecord::Base.transaction do
      yield
    ensure
      ActiveRecord::Rollback # Always rollback after rendered the template
    end
  end

  ...

end
```

还有一种可能是希望保证这几个方法一定完全执行成功，否则，一旦有异常，就rollback所有操作：
``` ruby
class PostsController < ApplicationController
  around_action :insure_in_transaction, only: [:archive, :vote, :share]

  private

  def insure_in_transaction
    ActionRecord::Base.transaction do
      yield
    rescue
      raise # ActiveRecord::Rollback, exceptions will force a rollback
    end
  end

  ...

end
```

### 4. 示例及代码请见q4.html
- `css3-transform`:
利用了CSS3 Transforms的特性，通过translate属性将元素相对于自己上移一半，这样正好弥补了定位时`Top: 50%`造成的元素超出中线50%的问题。
  
  优点：
  - 实现方式最简单，改动涉及的元素少，维护起来方便
  - 性能好，Transforms会由GPU来单独处理，这样不会产生主线程的reflow和repaint，减轻了主线程的压力
  
  缺点：
  - 低版本浏览器支持不好，IE9需要加厂商前缀，IE9以下都不支持，详见：[transform](http://caniuse.com/#search=transform)
  
  使用场景：推荐在目标客户浏览器环境允许的条件下使用这种方式

- `display-table-cell`:
利用了table cell支持`vertical-align: middle;`的特点来实现垂直居中。

  优点：
  - 浏览器支持好，支持IE8及以上的版本，详见：[css-table](http://caniuse.com/#search=css-table)

  缺点：
  - 需要改变元素的display属性，可能影响原有样式
  - 改动同时涉及多个元素，实现相对复杂一些，不利于维护

  使用场景：需要对IE8进行支持的时候

- `display-flex`:
利用CSS3的弹性盒子模型进行布局，使用align-items实现垂直居中。

  优点：
  - 弹性盒子是一种新的布局方式，比传统的块式盒子模型要方便的多
  - 功能强大。当然责任也越大，要掌握好正确的使用方式，不然适得其反

  缺点：
  - 规范标准还没有最终定稿
  - 浏览器支持不好，IE11都没有完全支持，详见：[Flexbox](http://caniuse.com/#search=Flexbox)

  使用场景：常用于在mobile device上进行布局

### 5. 请见q5.html

### 6. 个人考虑
1. 如果这是页面，要保证页面完整呈现的时候，二维码的大小不会变得太大，否则会比较难扫。
2. 页面的功用没有很好的体现出来，可以考虑：
  - 将“微信扫码”、“钉钉扫码” 文字移到二维码下方，使得文字不集中在一起，否则用户可能不想看描述文字。
  - 将描述文字改成`扫描二维码，申请开通“彩城设计”管理员账号`。因为"请选择常用的应用扫码"不是常用句式，会增加用户的理解成本。
  - 可以稍微列举开通管理员账号的原因以及主要功能。
3. 如果是页面，缺少导航栏；如果是弹出页面，缺少关闭/返回按钮。
4. 缺少帮助支持以及问题反馈的途径。如果操作失败或遇到问题，用户需要第一时间得到帮助。对衣食父母好一点，这很关键。
