From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: Tue, 29 Apr 2008 14:43:42 +0200
Message-ID: <m31w4oltkx.fsf@ursa.amorsen.dk>
References: <4766a3d1.02ab100a.0be8.6fdc@mx.google.com>
	<20071217085349.729e5c17@deepthought>
	<20080128153914.GA5880@localhost> <20080428135754.2ae382b4@extreme>
	<20080429082414.GA6475@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
Subject: Re: [Bridge] [PATCH] Add vlan id to bridge forward database
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

Jaime Medrano <jaime.medrano@gmail.com> writes:

> Yes, I know. However, AFAIK out of band passing of the vlan tag is only
> done when a vlan device is created and attached to the ethernet device
> of the port. 

If the driver supports VLAN acceleration, it is usually on by default.
At least I can't tcpdump VLAN packets with intact VLAN tags on my
notebook's tg3 card -- even if I haven't loaded the 8021q module at
all. It's rather annoying, really.

Anyway, you need to explicitly turn off VLAN acceleration on the
devices added to such a bridge.


/Benny


