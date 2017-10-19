package util;

import org.apache.log4j.DailyRollingFileAppender;
import org.apache.log4j.Priority;

/**
 * 用在日志输出到文�?
 * 默认输出在比低等级之上的日志到一个文件中
 * OFF FATAL ERROR WARN INFO DEBUG ALL
 * @author LinZB
 *
 */
public class LogAppender extends DailyRollingFileAppender {

    @Override  
    public boolean isAsSevereAsThreshold(Priority priority) {
        
         //只判断是否相等，而不判断优先�?  
         return this.getThreshold().equals(priority);  
    }  
//    public boolean isAsSevereAsThreshold(Priority priority)  {    
//        return threshold == null || priority.isGreaterOrEqual(threshold);  
//    }
}
