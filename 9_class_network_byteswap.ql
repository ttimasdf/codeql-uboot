import cpp

// 对Expr进行过滤：定义成Expr的子类
class NetworkByteSwap extends Expr {
  // 输出Expr就是过滤好的：定义为“构造函数”
  NetworkByteSwap () {
    // 声明临时变量m，类型：宏调用
    // 表示输出的Expr要与这个m有特定关联
    exists(MacroInvocation m |
      // m符合的条件是：名字是ntohs等等
      m.getMacroName().regexpMatch("ntoh(s|l|ll)") and
      // 输出的Expr是m的展开结果
      m.getExpr() = this
    )
  } 
}

from NetworkByteSwap n
select n, "OMG it works!!!!"
