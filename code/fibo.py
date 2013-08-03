def fibo(n):
    a, b = 1, 0
    while n > 0:
        a, b = a + b, a
        n -= 1
    return b

print fibo(300000)
