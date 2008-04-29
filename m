Message-ID: <2e59e6970804291616l5e6685edw7299be09c0dd2384@mail.gmail.com>
Date: Tue, 29 Apr 2008 23:16:47 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <20080429082414.GA6475@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4766a3d1.02ab100a.0be8.6fdc@mx.google.com>
	<20071217085349.729e5c17@deepthought>
	<20080128153914.GA5880@localhost> <20080428135754.2ae382b4@extreme>
	<20080429082414.GA6475@localhost>
Subject: Re: [Bridge] [PATCH] Add vlan id to bridge forward database
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jaime Medrano <jaime.medrano@gmail.com>
Cc: bridge@lists.osdl.org

>  > Your patch doesn't work if hardware does vlan acceleration. Vlan acceleration
>  > strips the tag off so skb->data points to actual contents and tag is passed
>  > up to vlan_receive_skb out of band. By the time the bridge sees the packet the
>  > actual tag is gone.
>
>  Yes, I know. However, AFAIK out of band passing of the vlan tag is only
>  done when a vlan device is created and attached to the ethernet device
>  of the port. That's a weird case from my point of view:
>
>         brctl addif br0 eth0
>         vconfig add eth0 5
>
>  If you want to get vlan packets from a bridge, you'd better attach the
>  device to the bridge instead of one of the ports:
>
>         brctl addif br0 eth0
>         vconfig add br0 5

That's for bridging a trunk, but what about bridging between vlans:

vconfig add eth0 5
vconfig add eth0 6
brctl add br0 eth0.5
brctl add br0 eth0.6

While you could combine the vlans, doing this allows you to force all
traffic through packet filtering/traffic shaping/IDS.

Usually you wouldn't then see the same MAC on two different VLAN but
you might on spanning tree packets.
