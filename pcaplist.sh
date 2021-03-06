#!/bin/bash

# 涉及到的命令：find/grep/file/sed/cut

# 方案1：以后缀名的方式筛选
# 筛选后缀名为pcap或者pcapng的文件，获取其绝对路径，然后通过sed加上双引号（为了避免文件名中有空格的情况）
find `pwd` -regex ".*.pcap[ng]*" | sed -e 's/^/"/g' -e 's/$/"/g' >> pcap.list

# 方案2：以文件类型的方式筛选
# 先用find获取文件列表，再用file命令判断文件mime
# mime的类型
# pcapng为application/octet-stream
# pcap为application/vnd.tcpdump.pcap

# file命令不接受标准输入作为输入
# 回答一：应该使用重定向而不是pipe
# 回答二：应该使用xargs；另外为了避免文件名中的空格，应该使用 find . -print0 | xargs -0 file这种形式
# 另外一种方法，find $PWD | xargs ls -dQ | xargs file -i还是会存在空格的问题
find $PWD -print0 | xargs -0 file -i
