Mime-Version: 1.0
Message-Id: <p05111b01bb7a6c4659d6@[10.96.96.13]>
In-Reply-To: <20030827132810.65010eac.shemminger@osdl.org>
References: <p05111b01bb728bc8972e@[10.96.96.13]>
 <20030827132810.65010eac.shemminger@osdl.org>
Date: Wed, 3 Sep 2003 16:56:06 +0200
From: Hannes Schulz <schulz@schwaar.com>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Subject: [Bridge] Re: [2.4.22] bad interaction between e100 and bridge: BUG at
 dev.c:991!
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org

>Could the problem be that the e100 can do IP receive checksumming on 
>the board,
>but the eepro driver doesn't enable it.  When the board is doing checksum
>offload, then the csum field isn't set.
>
>Please try disabling receive checksumming on the e100 driver
>
>	modprobe e100 XsumRX=0
>
>If this is the problem, it exists both 2.4 and 2.6.

If have just booted into 2.6.0-test4. Unplugging works, but the 
console is flooded with:
last-F IN=br0 OUT=br0 PHYSIN=eth1 PHYSOUT=eth0 SRC=10.96.96.25 DST=10.96.96.255

[last-F ist the last rule in my FORWARDING iptable and does log+drop]

Obviously I must allow forwarding br0 <=> br0.

While I am writing this the counter on the FORWARDING rule -i br0 -o 
br0 -j ACCEPT has reaches 2000+ packets with eth0 unplugged and the 
kernel ist still running.


In both 2.4.22 and 2.6.0-test4 all of netfilter and advanced routing 
ist set to M. In 2.6.0-test4 this includes ebtables.


Hope that helps

Hannes
