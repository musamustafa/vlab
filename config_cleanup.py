#!/usr/bin/env python

def delIntfcs(host, user, password):
         from jnpr.junos import Device
         from jnpr.junos.utils.config import Config
         from pprint import pprint
         import sys
         try:
           device = Device(host, user=user, password=password)
           print (">>> Open device session")
           device.open()

           print ">>> Loading configuration changes"
           try:
             cu = Config(device)
             cmdlist = ["wildcard delete interfaces xe-*", "wildcard delete interfaces ge-*", "wildcard delete interfaces et-*"]
             for cmd in range(len(cmdlist)):
                 print cmdlist[cmd]
                 cu.load(cmdlist[cmd], format="set")
                 try:
                     print ">>> Committing configuration changes"
                     cu.commit()
#                     print ("Close device session")
#                     device.close()
                 except CommitError:
                     print ">>> Error: Unable to commit configuration"
           except ValueError as err:
               print err.message
           print ("Close device session")
           device.close()  
         except Exception as err:
           print err
           sys.exit()
           

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
        print (host)
        print (user)
        print (password)
        delIntfcs(host, user, password)

if __name__ == "__main__":
        main()


