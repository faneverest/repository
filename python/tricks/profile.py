import cProfile

def profileTest():
    return map(lambda x: x ** 2, xrange(100))

if __name__ == '__main__':
    cProfile.run("profileTest()")