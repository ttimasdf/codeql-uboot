
import cpp

from MacroInvocation i, Macro m
where
    i.getMacro() = m
    and m.getName().regexpMatch("ntoh(s|l|ll)")
select i.getExpr()  //, m
