import cpp

from MacroInvocation m
where m.getMacro().getName().regexpMatch("ntoh(s|l|ll)")
// 与下面的语句功能相同
// where m.getMacroName().regexpMatch("ntoh(s|l|ll)")
select m
