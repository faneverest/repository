import sys
import getopt

def usage():
    try:
        opts, args = getopt.getopt(sys.argv[1:], 'he:c:f:')
    except getopt.GetoptError:
        print 'wrong usage'
        sys.exit()

        if len(opts) == 0:
            print "hecf"
            sys.exit()
    for opt, arg in opts:
        if opt in ('h', '--help'):
            print 'help'
        elif opt == 'e':
            print 'option e'
        elif opt == 'c':
            print 'option c'
        elif opt == 'f':
            print 'option f'
        