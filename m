Date: Tue, 29 Apr 2008 17:18:43 +0200
From: Jaime Medrano <jaime.medrano@gmail.com>
Message-ID: <20080429151843.GA10576@localhost>
References: <4766a3d1.02ab100a.0be8.6fdc@mx.google.com>
	<20071217085349.729e5c17@deepthought>
	<20080128153914.GA5880@localhost> <20080428135754.2ae382b4@extreme>
	<20080429082414.GA6475@localhost> <m31w4oltkx.fsf@ursa.amorsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m31w4oltkx.fsf@ursa.amorsen.dk>
Subject: Re: [Bridge] [PATCH] Add vlan id to bridge forward database
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benny Amorsen <benny+usenet@amorsen.dk>
Cc: bridge@osdl.org

On Tue, Apr 29, 2008 at 02:43:42PM +0200, Benny Amorsen wrote:
> Jaime Medrano <jaime.medrano@gmail.com> writes:
> > Yes, I know. However, AFAIK out of band passing of the vlan tag is only
> > done when a vlan device is created and attached to the ethernet device
> > of the port. 
> 
> If the driver supports VLAN acceleration, it is usually on by default.
> At least I can't tcpdump VLAN packets with intact VLAN tags on my
> notebook's tg3 card -- even if I haven't loaded the 8021q module at
> all. It's rather annoying, really.

That's weird.

I've got a tg3 card and I see the tags in tcpdump unless I register a vlan
device to it.

I've taken a look at the source code of the tg3 driver and
vlan_hwaccel_receive_skb() only gets called if a prior
tg3_vlan_rx_register() has been made.
