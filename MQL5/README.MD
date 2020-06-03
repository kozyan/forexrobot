# 通过执行快捷键来运行程序 Ctrl+Shift+B

# Task.json 的关键配置
``` json
"command": "", //20200603, 由于默认是 powershell 的终端，所以这里不用指定 'powershell'
"args": [
    "./Compile-MQL.ps1",
    "'C:/Program Files/MetaTrader 5 - EXNESS/metaeditor64.exe'",
    "${file}"
],
```