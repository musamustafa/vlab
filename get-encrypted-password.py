#!/usr/bin/env python

def getencryptedpass(host, user, password):
         from jnpr.junos import Device
         from jnpr.junos.utils.config import Config
         from pprint import pprint
         from lxml import etree
         import sys
         try:
           device = Device(host, user=user, password=password)
#           print (">>> Open device session")
           device.open()

#           print ">>> Getting RPC"
           data = device.rpc.get_config()
           output = data.xpath('/rpc-reply/configuration/system/login/user[name="%s"]/authentication/encrypted-password'% user)
          # print etree.tostring(output[0], method='text') 
           env = etree.tostring(output[0], method='text')
           print(env)
#           print ("Close device session")
           device.close()  
         except Exception as err:
           print(err)
           sys.exit()
#         return etree.tostring(output[0], method='text')
           

def main():
        import argparse

        parser = argparse.ArgumentParser(description='Device baseline configuration cleanup')
        parser.add_argument("--host", dest="hostname", default="",metavar="HOST",help="Specify remote host")
        parser.add_argument("--username", dest="username", metavar="USERNAME",help="Specify the username")
        parser.add_argument("--password", dest="password", metavar="PASSWORD",help="Specify the password")
        args = parser.parse_args()

        host = args.hostname
        user = args.username
        password = args.password
        getencryptedpass(host, user, password)

if __name__ == "__main__":
        main()


