package com.yui.study.crawler.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author XuZhuohao
 * @date 2018/11/21
 */
public class PatternUtil {
    /**
     * 通过这种表达式进行匹配
     * @param patternStr 正则表达式
     * @param text 被匹配的文字
     * @param groupIndexes 对应的子表达式下表
     * @return 需要的字符串集合
     */
    public static List<String> getStringByPattern(String patternStr, String text, int ... groupIndexes) {
        List<String> result = new ArrayList<>(16);
        // 编译正则表达式规则
        Pattern pattern = Pattern.compile(patternStr);
        // 进行匹配
        Matcher matcher = pattern.matcher(text);
        // 循环获取结果
        while (matcher.find()) {
            for (int groupIndex : groupIndexes) {
                result.add(matcher.group(groupIndex));
            }
        }
        return result;
    }

    public static String getPatternFromChar(String result, String likeChars, List<String> likeCharsWithOuts){
        //
        String temp = likeCharsWithOuts.get(0);
        for (char c : temp.toCharArray()) {

        }
        return null;
    }

}
