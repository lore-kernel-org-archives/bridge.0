From: Linux Looser <mb4rt0l0@gmail.com>
Date: Fri, 16 Feb 2007 12:36:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702161236.34899.mb4rt0l0@gmail.com>
Subject: [Bridge] Bridge between ethernet and tuntap problem
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

	
Hello,

I have problem, i have bridge between ethernet interface and tuntap interface   

   application <-> tap0   Bridge0  eth0 <->   Network

everythings seem to be OK, bridge is bridging correctly, but when application 
do connect to some destination first Syn paket i see on tap0 if, and i see it 
on eth0 if, it goes to destination. The return Syn/Ack paket from destination 
i see on eth0, but not goes through bridge0 if to the tap0 interface. 
Application connect times out (3 seconnds )  and  send second Syn packet and 
receive Syn/ack , handshake complete and everything goes correctly. But for 
every connection initiated by application is situation same.


tcpdump on eth0:

 11:02:18.941680 IP 10.1.2.2.38894 > 195.28.64.118.25: S 1905693472:1905693472
(0) win 5840 <mss 1460,sackOK,timestamp 605391412 0,nop,wscale 2>
11:02:19.043882 IP 195.28.64.118.25 > 10.1.2.2.38894: S 3816891714:3816891714
(0) ack 1905693473 win 65535 <mss 1460,nop,wscale 1,nop,nop,timestamp 
2989341090 605391412,sackOK,eol>
11:02:21.938529 IP 10.1.2.2.38894 > 195.28.64.118.25: S 1905693472:1905693472
(0) win 5840 <mss 1460,sackOK,timestamp 605392162 0,nop,wscale 2>
11:02:22.030111 IP 195.28.64.118.25 > 10.1.2.2.38894: S 3816891714:3816891714
(0) ack 1905693473 win 65535 <mss 1460,nop,wscale 1,nop,nop,timestamp 
2989344076 605392162,sackOK,eol>
11:02:22.030204 IP 10.1.2.2.38894 > 195.28.64.118.25: . ack 1 win 1460 
<nop,nop,timestamp 605392184 2989344076>
11:02:22.410047 IP 195.28.64.118.25 > 10.1.2.2.38894: P 1:41(40) ack 1 win 
33304 <nop,nop,timestamp 2989344445 605392184>


tcpdump on tap0:
 
11:02:18.941468 IP 10.1.2.2.38894 > 195.28.64.118.25: S 1905693472:1905693472
(0) win 5840 <mss 1460,sackOK,timestamp 605391412 0,nop,wscale 2>
11:02:21.938516 IP 10.1.2.2.38894 > 195.28.64.118.25: S 1905693472:1905693472
(0) win 5840 <mss 1460,sackOK,timestamp 605392162 0,nop,wscale 2>
11:02:22.030119 IP 195.28.64.118.25 > 10.1.2.2.38894: S 3816891714:3816891714
(0) ack 1905693473 win 65535 <mss 1460,nop,wscale 1,nop,nop,timestamp 
2989344076 605392162,sackOK,eol>
11:02:22.030198 IP 10.1.2.2.38894 > 195.28.64.118.25: . ack 1 win 1460 
<nop,nop,timestamp 605392184 2989344076>
11:02:22.410055 IP 195.28.64.118.25 > 10.1.2.2.38894: P 1:41(40) ack 1 win 
33304 <nop,nop,timestamp 2989344445 605392184>
11:02:22.410490 IP 10.1.2.2.38894 > 195.28.64.118.25: . ack 41 win 1460 
<nop,nop,timestamp 605392279 2989344445>
11:02:40.269133 IP 10.1.2.2.38894 > 195.28.64.118.25: F 1:1(0) ack 41 win 1460 
<nop,nop,timestamp 605396743 2989344445>

tcpdump on bridge0:

11:02:18.941588 IP 10.1.2.2.38894 > 195.28.64.118.25: S 1905693472:1905693472
(0) win 5840 <mss 1460,sackOK,timestamp 605391412 0,nop,wscale 2>
11:02:21.938516 IP 10.1.2.2.38894 > 195.28.64.118.25: S 1905693472:1905693472
(0) win 5840 <mss 1460,sackOK,timestamp 605392162 0,nop,wscale 2>
11:02:22.030111 IP 195.28.64.118.25 > 10.1.2.2.38894: S 3816891714:3816891714
(0) ack 1905693473 win 65535 <mss 1460,nop,wscale 1,nop,nop,timestamp 
2989344076 605392162,sackOK,eol>
11:02:22.030198 IP 10.1.2.2.38894 > 195.28.64.118.25: . ack 1 win 1460 
<nop,nop,timestamp 605392184 2989344076>
11:02:22.410047 IP 195.28.64.118.25 > 10.1.2.2.38894: P 1:41(40) ack 1 win 
33304 <nop,nop,timestamp 2989344445 605392184>
11:02:22.410490 IP 10.1.2.2.38894 > 195.28.64.118.25: . ack 41 win 1460 
<nop,nop,timestamp 605392279 2989344445>

Thanks for any help/guidance!
Barto
