Date: Tue, 31 May 2005 13:21:18 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge not working on arm embedded platform
Message-ID: <20050531132118.63be271d@dxpl.pdx.osdl.net>
In-Reply-To: <34d8b2fe050531121736623672@mail.gmail.com>
References: <34d8b2fe05053002387a1942bf@mail.gmail.com>
	<20050531094024.75098a16@dxpl.pdx.osdl.net>
	<34d8b2fe050531121736623672@mail.gmail.com>
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

On Tue, 31 May 2005 21:17:17 +0200
Louis Croisez <louis.croisez@gmail.com> wrote:

> Hi Stephen,
> first of all, thx for helping me :o)
> 
> 2005/5/31, Stephen Hemminger <shemminger@osdl.org>:
> > 
> > On Mon, 30 May 2005 11:38:59 +0200
> > Louis Croisez <louis.croisez@gmail.com> wrote:
> > 
> > > Hi,
> > > i want to implement the bridging feature on an arm (cpu intel ixp425),
> > > running busybox+linux kernel 2.6.11.
> > > For this, I have recompiled the kernel to enable bridging and ebtables, 
> > and
> > > I have compiled and installed brctl utility for arm.
> > >
> > > Here is my network setup:
> > > [PC_A] eth0 10.0.0.10/24 <http://10.0.0.10/24> ======== eth0 --+-- eth1 
> > ======== [PC_B] eth0 10.10.0.1/24 <http://10.10.0.1/24>
> > > |
> > > br0
> > > [ARM]
> > 
> > What is IP address of bridge? (br0) or do you not
> > want the ARM box to be IP accessible?
> 
> 
> It is not well sure that the bridge is to be accessible. But it is not 
> forbidden. In fact, a requirement is that the bridge worked with or without 
> IP address on br0 iface. On my linux bridge test box, whether to have or not 
> an IP on br0 does not makes the difference.
> 
> >
> > > Here is how I setup my bridge on the ARM:
> > > brctl addbr br0
> > > brctl addif br0 eth0
> > > brctl addif br0 eth1
> > > brctl setfd br0 1
> > why set forwarding delay so low, please don't
> 
> 
> Could please you explain me the consequence of setting this parameter too 
> low? 
> 
> > ifconfig eth0 promisc
> > Don't do this you don't need to, unless something is
> > broken in driver.
> 
> 
> I am currently debugging. To have idea of where is the network packet in the 
> stack, I use the ebtables/iptables log feature, that show the traject of a 
> packet.
> Here is the result of my last test.
> Goal:
> [PC_A] ping [PC_B] thru [ARM].
> Result:
> icmp request is even not sent, because first an arp request is broadcast on 
> the lan to resolve PC_B hw address. Problem is that this arp request never 
> reach PC_B. It is stopped inside ARM.
> Here is the path followed by this packet:
> ebt:BRoute:BRouting
> ebt:Nat:PreRouting
> ipt:Mangle:PreRouting
> ipt:Nat:PreRouting
> ebt:Filter:Input
>
Does the bridge without any ebtables or iptables filtering at all? 
That is might be where the problem is.
