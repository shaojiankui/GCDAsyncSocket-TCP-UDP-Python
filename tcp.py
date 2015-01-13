#! /usr/bin/env python
#coding=utf-8
from socket import *
from time import ctime

serverClient = socket(AF_INET, SOCK_STREAM)

HOST=''
PORT=8808
BUFSIZ=1024
ADDR=(HOST, PORT)

serverClient.bind(ADDR)
serverClient.listen(5)

while True:
    print('waiting for input')
    clientSocket, addr = serverClient.accept()
    print('connect from ', addr)
    while True:
        try:
            data= clientSocket.recv(BUFSIZ)
        except:
            print(e)
            clientSocket.close()
            break
        if not data:
            break
        s='Hi,you send me :[%s] %s' %(ctime(), data.decode('utf8'))
        clientSocket.send(s.encode('utf8'))
        print([ctime()], ':', data.decode('utf8'))

clientSocket.close()
serverClient.close()
