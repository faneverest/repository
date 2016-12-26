import fpformat

def printExample():
    """
    examples of different formating
    """

    # only output first 3 chars
    chars = 'abcdefg'
    print '%.3s' % chars

    # fixed width (of 10), use whitespace if necessary
    print '%10s' % chars

    # fixed width (of 10), only first 3 chars
    print '%10.3' % chars

    # float
    a = 0,003
    print fpformat.fix(a, 6)

    # hex, dec, oct
    num = 10
    print "Hex = %x, Dec = %d, Oct = %o" % (num, num, num)
    