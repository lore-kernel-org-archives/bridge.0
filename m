Message-ID: <88240e9404111010486cfbd495@mail.gmail.com>
Date: Wed, 10 Nov 2004 10:48:16 -0800
From: TEJAS VORA <voratejas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge Problem with RedHat and iptables
Reply-To: TEJAS VORA <voratejas@gmail.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@osdl.org
Cc: bridge@lists.osdl.org

Hello,

I am running into a strange problem here. I wrote you a mail earlier
also regarding this.

1. I am trying to run the bridge mode over Redhat 7.3 (kernel 2.4.18).
I tried the latest version of brdige mode utility and also I tried
version 0.94 as well. But whenever I run the brdige mode on this
kernel - the kernel goes panic saying "aiee - killing interrupt
handler". Now I am in a crutial situation here. We are building a
product based on kernel version 2.4.18 and running on Redhat 7.3 - and
we have to setup bridge mode on the machine. But due to this problem
we are not able to do that. So please help me what is the problem here
and what could be the solution?

2. Now the second problem is regarding iptables. As brdige was not
working on redhat 7.3 due to kernel panicing - I tried it temporarily
in redhat 9.0 (jkernel 2.4.20-8) - where it is working fine. I setup a
FTP transparent proxy on the machine. The configuration is - our
machine (with brdige mode and transparent proxy) seats between client
and server. And it forwards or the traffice to and fro and for FTP
traffic we want to have transparent proxy in between. The
configuration is as shiown below.

Bridge Machine (br0) IP : 192.168.11.201
(need to be used as Transparent proxy)
       +---------------------------------------------+
       |                       |
       |                       |
       |                       |
       |                       |
       |                       |
       |                       |
       +---------------------------------------------+
               |       |
               eth0    eth1
               |       |
               |       |
               |       | FTP Content Server (192.168.11.60) and Internet
               |       +------------------------>
               |
               |
               |
               | TO INTRANET 
               +-------------------------------->

Now the thing is on bridge machine I am running FTP transparent proxy
(jftpgw) and I have setup iptables rule as follow.

iptables -t nat -A PREROUTING -p tcp -d 0/0 -s 0/0 --dport 21 -J DNAT
--to 192.168.11.201:2370

But the strange thing is before the packet is redirected to port 2370
(to Transparent PROXY) - brdige forwards it to the other machine and
the packet does not reach port 2370 on the same machine. So what could
be the problem here and what could be the solution for that?

I am in a urgent help. Please help  me and let me know the solution
ofr these problems.

Thanks you,
Tejas Vora
