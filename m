Message-ID: <1031.204.10.124.3.1171560450.squirrel@squirrel.ouraynet.com>
In-Reply-To: <BAY131-F1857AFF907BF1716A253BBE2960@phx.gbl>
References: <BAY131-F1857AFF907BF1716A253BBE2960@phx.gbl>
Date: Thu, 15 Feb 2007 10:27:30 -0700 (MST)
From: kevin@ouraynet.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] bridge problem
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

> On the target board
>
> ifconfig eth0 0.0.0.0
> ifconfig eth1 0.0.0.0
> brctl addbr br0
> brctl addif br0 eth0
> brctl addif br0 eth1
> ifconfig br0 10.1.111.1 netmask 255.255.255.0 up
> echo 1 > /proc/sys/net/ipv4/ip_forward

Bridging works transparently and is not routing.

You will not need ip_forwarding set, nor and ip in the same subnet.

forget setting the ip_forward, just bring up your bridge with:

ifconfig br0 0.0.0.0 up

If you have everything plugged in properly, and two ips in the same
subnet on either side, they will start pinging.

As mentioned on this list many times prior it does take 30 seconds for
the forwarding to take place unless you set it to 0 with:

brctl setfd br0 0

Hope that helps,
Kevin Karsh
Ouraynet

