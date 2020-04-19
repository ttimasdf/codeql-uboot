/**
* @kind path-problem
*/

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

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

class Config extends TaintTracking::Configuration {
  Config() { this = "NetworkToMemFuncLength" }

  override predicate isSource(DataFlow::Node source) {
    exists(NetworkByteSwap nbswap
    | source.asExpr() = nbswap)
  }

  override predicate isSink(DataFlow::Node sink) {
    exists(FunctionCall call
    | call.getTarget().getName() = "memcpy" and
    sink.asExpr() = call.getArgument(2))
  }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"
