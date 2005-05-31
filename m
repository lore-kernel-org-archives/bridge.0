Date: Tue, 31 May 2005 09:40:24 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge not working on arm embedded platform
Message-ID: <20050531094024.75098a16@dxpl.pdx.osdl.net>
In-Reply-To: <34d8b2fe05053002387a1942bf@mail.gmail.com>
References: <34d8b2fe05053002387a1942bf@mail.gmail.com>
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
To: Louis Croisez <louis.croisez@gmail.com>
Cc: bridge@lists.osdl.org

On Mon, 30 May 2005 11:38:59 +0200
Louis Croisez <louis.croisez@gmail.com> wrote:

> Hi,
> i want to implement the bridging feature on an arm (cpu intel ixp425), 
> running busybox+linux kernel 2.6.11.
> For this, I have recompiled the kernel to enable bridging and ebtables, and 
> I have compiled and installed brctl utility for arm.
> 
> Here is my network setup:
> [PC_A] eth0 10.0.0.10/24  ======== eth0 --+-- eth1 ======== [PC_B] eth0 10.10.0.1/24
>                                           | 
>                                           br0 
>                                           [ARM]

What is IP address of bridge? (br0) or do you not
want the ARM box to be IP accessible?

> 
> Here is how I setup my bridge on the ARM:
> brctl addbr br0
> brctl addif br0 eth0
> brctl addif br0 eth1
> brctl setfd br0 1
why set forwarding delay so low, please don't
> ifconfig eth0 promisc
Don't do this you don't need to, unless something is
broken in driver.

> ifconfig eth1 promisc
> ifconfig eth0 0.0.0.0 <http://0.0.0.0>
What is http:// stuff? some filter got it?
expect:
   ifconfig eth0 0.0.0.0
to bring up without IP address

> ifconfig eth1 0.0.0.0 <http://0.0.0.0>
> ifconfig eth0 up
unneeded device is already up.
> ifconfig eth1 up
> ifconfig br0 0.0.0.0 <http://0.0.0.0>

You forgot to assign IP address to bridge, expect:
   ifconfig br0

> ifconfig br0 up
Likewise unneeded.

> ip route add 0.0.0.0/0 <http://0.0.0.0/0> dev br0

In addition to configuration issues, I would also suspect the ARM ethernet
driver.  Possible issues:
	1) Does each ethernet device have a valid unique ethernet address? (ifconfig -a)
	2) Does promiscuous work correctly? 
           Can you snoop the net correctly with tcpdump without the bridge and without forcing
	   eth into promiscuous mode.
 
