Date: Wed, 12 Jan 2005 16:40:25 -0500 (EST)
From: Adam Sulmicki <adam@cfar.umd.edu>
Message-ID: <Pine.BSF.4.61.0501121638530.30246@www.missl.cs.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bridge] RE: [Xen-devel] nfsroot and brige (fwd)
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bridge mailing list <bridge@osdl.org>


any comments?

if nothing else, is there any way to atomically setup bridge?

not on list, please cc.

---------- Forwarded message ----------
Date: Wed, 12 Jan 2005 21:08:15 -0000
From: Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>
To: Adam Sulmicki <adam@cfar.umd.edu>, xen-devel@lists.sourceforge.net
Subject: RE: [Xen-devel] nfsroot and brige

> hello,
>  	it seems like a catch-22 to me. I boot xen0 with nfsroot,
>  	and then try to setup bridge stuff. something like this
>
> /sbin/brctl addbr xen-br0
> /sbin/brctl addif xen-br0 eth0
> /sbin/ifconfig xen-br0 10.0.10.103 netmask 255.255.255.0 up
> /sbin/ifconfig eth0 0.0.0.0 promisc up
>
>  	however, once I start it running it crashes down with error
>  	that nfs server is not available.
>
>  	does it mean that I must use initramfs to configure bridge
>  	first, or is there some other way?

It really bugs me that there's no atomic way to configure a bridge and
transfer an IP address already active on another interface to it. I'm
not 100% convinced that the current behaviour is actually what the
bridge code author's intend: a the host can still transmit packet's with
an IP associated with an eth interface that is part of a bridge, it just
can't receive packets on that IP. I'd certainly appreciate it if someone
could ask the question on the bridge mailing list...

The workarounds for using nfsroot in dom0 at the moment are: a) use a
ramfs to configure the bridge; b) use a routed rather than bridged
setup.

I'm actually going off the whole idea of bridging rather than routeing
as the default...

Ian
