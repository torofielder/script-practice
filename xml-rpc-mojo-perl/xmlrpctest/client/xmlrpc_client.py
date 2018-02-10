try:
        import xmlrpclib as client
except ImportError:
        import xmlrpc.client as client

proxy = client.ServerProxy("http://192.168.132.131:8000/RPC2")
print("1 + 2 : %d" % ( proxy.xml.rpctestplus(1,2) ))
print("3 - 2 : %d" % ( proxy.xml.rpctestminus(3,2) ))

d={'foo':'test','bar':'data'}
b=[1,2,d,3]

a = proxy.xml.rpctestmixed(1500000000,b)

print( a )
