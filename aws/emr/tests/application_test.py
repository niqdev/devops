import unittest

class ApplicationTestCase(unittest.TestCase):

    def setUp(self):
        print('test setUp')

    def tearDown(self):
        print('test tearDown')
    
    def test_example(self):
        assert 'aaa' in 'aaa'

if __name__ == '__main__':
    unittest.main()
