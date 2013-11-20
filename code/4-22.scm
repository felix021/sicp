; 在 application? 判断之前加上：

    ((let? exp) (analyze (let->combination exp)))
