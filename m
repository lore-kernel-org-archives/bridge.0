Date: Tue, 29 Apr 2008 10:24:14 +0200
From: Jaime Medrano <jaime.medrano@gmail.com>
Message-ID: <20080429082414.GA6475@localhost>
References: <4766a3d1.02ab100a.0be8.6fdc@mx.google.com>
	<20071217085349.729e5c17@deepthought>
	<20080128153914.GA5880@localhost> <20080428135754.2ae382b4@extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20080428135754.2ae382b4@extreme>
Subject: Re: [Bridge] [PATCH] Add vlan id to bridge forward database
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.osdl.org

On Mon, Apr 28, 2008 at 01:57:54PM -0700, Stephen Hemminger wrote:
> I looked at this, and thought about cleaning it up and putting in
> next release but right now can't see how it could work with
> vlan accelerated hardware.

=BFDid you see my last mail? I made the cleaning up you suggested and
generalized the code to support any level of nested tags instead of just
two.

> Your patch doesn't work if hardware does vlan acceleration. Vlan accelera=
tion
> strips the tag off so skb->data points to actual contents and tag is pass=
ed
> up to vlan_receive_skb out of band. By the time the bridge sees the packe=
t the
> actual tag is gone.

Yes, I know. However, AFAIK out of band passing of the vlan tag is only
done when a vlan device is created and attached to the ethernet device
of the port. That's a weird case from my point of view:

	brctl addif br0 eth0
	vconfig add eth0 5

If you want to get vlan packets from a bridge, you'd better attach the
device to the bridge instead of one of the ports:

	brctl addif br0 eth0
	vconfig add br0 5

If you attach it to a port, the out of band tag won't reach current
bridge code, and won't be restored on bridge output in case the packet
has to be forwarded.  Attaching the vlan device to the bridge device
doesn't enable hardware vlan acceleration, so that everything works.

> You might be able to get tag by using some API to reference the VLAN devi=
ce,
> but it all gets complex and racy. Plus not sure if it is really even tech=
nically
> correct.

I guess the complexity overwhelms the benefits. Anyway, if that case is
to be handled I think that restoring the tag on output is more
important.
