# 试题内容：给定数据框df_origin，要求得到数据框df_change
# Content: Clean data from df_origin to df_change

library(tidyverse)
# 数据准备
df <- df_origin <- data.frame(Id = 1:14,
                        Name = c('北京市','山东省','昌平区','海淀区',
                                 '沙河镇','马池口镇','中关村','上地',
                                 '烟台市','青岛市','牟平区','芝果区',
                                 '即墨区','城阳'),
                        ParentId = c(0,0,1,1,3,3,4,4,2,2,9,9,10,10),
                        stringsAsFactors = F)


df_change <- data.frame(一级地名 = c(rep('北京市',4), rep('山东省',4)),
                        二级地名 = c('昌平区','昌平区','海淀区','海淀区',
                                 '烟台市','烟台市','青岛市','青岛市'),
                        三级地名 = c('沙河镇','马池口镇','中关村','上地',
                                 '牟平区','芝果区','即墨区','城阳'))

# 函数准备
rollback <- function(dat, char){
  num = which(df$Id == df$ParentId[df$Name == char])
  return(num)
}

getFinalNode <- function(dat){
  id = setdiff(df$Id, df$Id[df$Id %in% df$ParentId])
  return(id)
}

vecRollback <- function(dat, vec){
  last_level <- list()
  for(i in seq_along(vec)){last_level[[i]] <- rollback(dat, vec[i])}
  last_level <- dat$Name[dat$Id[unlist(last_level)]]
  return(last_level)
}

# 分级提取
third_level <- df$Name[getFinalNode(df)]
second_level <- vecRollback(df, third_level)
first_level <- vecRollback(df, second_level)

# 汇总数据框
df_change <- data.frame(一级城市 = first_level,
                        二级城市 = second_level,
                        三级城市 = third_level,
                        stringsAsFactors = F)
