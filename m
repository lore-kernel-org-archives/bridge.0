Date: Fri, 10 Sep 2004 04:56:03 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Re: Problem in changed VLAN code can cause systems to
	hang.
Message-Id: <20040910045603.32e8ded3@linux.site>
In-Reply-To: <20040909085149.1d483349.davem@davemloft.net>
References: <414057B1.1020902@siennax.com>
	<20040909082129.62059694.davem@davemloft.net>
	<4405.131.188.28.69.1094744038.squirrel@www.osdl.org>
	<20040909085149.1d483349.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: bridge@lists.osdl.org

I can't reproduce the problem on a test machine (SMP) with eth0 (e100) and eth2 (e1000)
Doesn't seem to hang either with commands or custom program.

[root@dev4-009 root]# vconfig add eth2 1
Added VLAN with VID == 1 to IF -:eth2:-
WARNING:  VLAN 1 does not work with many switches,
consider another number if you have problems.
[root@dev4-009 root]# ifconfig eth2:1
eth2:1    Link encap:Ethernet  HWaddr 00:03:47:9A:33:D5
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Memory:fa420000-fa440000

[root@dev4-009 root]# mii-tool eth2:1
SIOCGMIIPHY on 'eth2:1' failed: Operation not supported

This is what we would expect since e1000 doesn't support MII ioctl when
running in 1000Gbit mode.

[root@dev4-009 root]# vconfig add eth0 11
Added VLAN with VID == 11 to IF -:eth0:-
[root@dev4-009 root]# mii-tool eth0:11
eth0:11: negotiated 100baseTx-FD, link ok

The e100 link works, and also eth1 (e1000 in 100mbit mode).
If someone can reproduce the problem, please tell me how and/or do it
on a console; it is probably a OOPs.


