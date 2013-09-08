
;在 (serialized-exchange acc1 acc2) 执行的时候，会先获取acc1、acc2的锁，然后去执行 ((acc1 'withdraw) diff)，而按照Louis的实现方法，在withdraw的时候要再次获取acc1的锁，从而导致程序进入死锁状态.
