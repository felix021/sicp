; 例如 (map display (list 1 2))
;   map接受到的参数为
;   (list
;       (list 'primitive {[procedure display]} )
;       (list 1 2))
;
;   scheme原生的map会把第一个参数(display)当成一个[原生函数]直接作用于后续参数，因此会出错。
;
;   而自定义的map会再次调用 apply 来执行display函数，因此可以正常工作。
