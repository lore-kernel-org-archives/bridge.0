Message-ID: <46F132FA.8050501@mediatvcom.com>
Date: Wed, 19 Sep 2007 16:32:26 +0200
From: David Martin <dmartin@mediatvcom.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------030409030509020004060304"
Subject: [Bridge] Arp & Bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------030409030509020004060304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

here is my bridge config :
Let say br0 containing eth0 and eth1, with br0 IP adress is 192.168.0.10

For some reasons, I would like to be able to send packet from the bridge 
machine, only via a specific device.
Thus, I set IP adress for eth0 and eth1 (let's say 192.168.0.11 and 
192.168.0.12).
I know a bridge is not supposed to have IP adress on the interfaces..
 ___________________________
| br0 (192.168.0.10)                |
|  +---   eth0  (192.168.0.11)   --------------------------- ethernet 
wire --------------------- 192.168.0.1
|  +---   eth1  (192.168.0.12)   ----------------------------ethernet 
wire --------------------- 192.168.0.254
|___________________________|

But when I try to send packet's from only one device, it does not work.
ie : ping -I eth0 192.168.0.1  gives no response.

I noticed that arp are sent and received by eth1, but they are of course 
received by br0 too.
So the arp table is completed for br0 but not for eth1...

The question is :
Why does br0 update the arp table, but eth1 doesnt? how is the arp table 
are updated? eth1 is the one sending the request!
Is there any mean to solve that?

--------------030409030509020004060304
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<font size="-1">here is my bridge config : <br>
Let say br0 containing eth0 and eth1, with br0 IP adress is 192.168.0.10<br>
<br>
For some reasons, I would like to be able to send packet from the
bridge machine, only via a specific device.<br>
Thus, I set IP adress for eth0 and eth1 (let's say 192.168.0.11 and
192.168.0.12).<br>
I know a bridge is not supposed to have IP adress on the interfaces..<br>
&nbsp;___________________________<br>
</font><font size="-1">| br0 (192.168.0.10)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
|&nbsp; +---&nbsp;&nbsp; eth0&nbsp; (192.168.0.11)&nbsp;&nbsp; --------------------------- ethernet
wire --------------------- 192.168.0.1<br>
|&nbsp; +---&nbsp;&nbsp; eth1&nbsp; (192.168.0.12)&nbsp;&nbsp; ----------------------------ethernet
wire --------------------- 192.168.0.254</font><br>
<font size="-1">|___________________________|<br>
<br>
But when I try to send packet's from only one device, it does not work.<br>
ie : ping -I eth0 192.168.0.1&nbsp; gives no response.<br>
<br>
I noticed that arp are sent and received by eth1, but they are of
course received by br0 too.<br>
So the arp table is completed for br0 but not for eth1...<br>
<br>
The question is :<br>
Why does br0 update the arp table, but eth1 doesnt? how is the arp
table are updated? eth1 is the one sending the request!<br>
Is there any mean to solve that?<br>
</font>
</body>
</html>

--------------030409030509020004060304--
