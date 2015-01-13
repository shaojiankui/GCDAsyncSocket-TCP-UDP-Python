#! /usr/bin/env python
#coding=utf-8
import socket

serverSocket = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

HOST=''
PORT=8888 #从指定的端口，从任何发送者，接收UDP数据
BUFSIZ=1024
ADDR=(HOST, PORT)

serverSocket.bind(ADDR)


while True:
    #接收一个数据
    print('waiting for input')

    message,clientAddress = serverSocket.recvfrom(BUFSIZ)
    
    print('Received:',message,'from',clientAddress)
    
    modifiedMessage = message.upper()
    
    serverSocket.sendto(modifiedMessage, clientAddress)  #clientAddress必填 要不然客户端接不到数据

