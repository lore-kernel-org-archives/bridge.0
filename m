Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-sender
	:x-me-sender:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Ud3RStQ/lNhEM7
	C1JxJvnbeF7z4=; b=HY8esGil4KMu7UxiQLNnLzNPMOIsfR+51np8ufHPAyaODr
	HOHkCZ/yXdYoyKcx1fXTAiYjnoieETeruruB+Rw7yuzp3drRgcCAlbFoFjfSo1Tw
	qJnLEmijvZNPgXwP4R7jfIrT8Ary3F/5QiObNEH4S4YKENQo0PNE30ZRiQnbY=
Date: Tue, 22 Nov 2016 19:41:40 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20161122174140.2ly226dcxkv23nlo@splinter.mtl.com>
References: <20161121190925.14530-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161121190925.14530-1-f.fainelli@gmail.com>
Subject: Re: [Bridge] [RFC net-next 0/3] net: bridge: Allow CPU port
	configuration
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: idosch@mellanox.com, andrew@lunn.ch, vivien.didelot@savoirfairelinux.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jiri@mellanox.com, davem@davemloft.net

Hi Florian,

On Mon, Nov 21, 2016 at 11:09:22AM -0800, Florian Fainelli wrote:
> Hi all,
> 
> This patch series allows using the bridge master interface to configure
> an Ethernet switch port's CPU/management port with different VLAN attributes than
> those of the bridge downstream ports/members.
> 
> Jiri, Ido, Andrew, Vivien, please review the impact on mlxsw and mv88e6xxx, I
> tested this with b53 and a mockup DSA driver.

We'll need to add a check in mlxsw and ignore any VLAN configuration for
the bridge device itself. Otherwise, any configuration done on br0 will
be propagated to all of its slaves, which is incorrect.

> 
> Open questions:
> 
> - if we have more than one bridge on top of a physical switch, the driver
>   should keep track of that and verify that we are not going to change
>   the CPU port VLAN attributes in a way that results in incompatible settings
>   to be applied
> 
> - if the default behavior is to have all VLANs associated with the CPU port
>   be ingressing/egressing tagged to the CPU, is this really useful?

First of all, I want to be sure that when we say "CPU port", we're
talking about the same thing. In mlxsw, the CPU port is a pipe between
the device and the host, through which all packets trapped to the host
go through. So, when a packet is trapped, the driver reads its Rx
descriptor, checks through which port it ingressed, resolves its netdev,
sets skb->dev accordingly and injects it to the Rx path via
netif_receive_skb(). The CPU port itself isn't represented using a
netdev.

Given the above, having VLAN filters (or STP) on the CPU port itself
isn't really helpful (we do have them for physical ports of course...).
So, mlxsw will not benefit from this patchset and if we've the same
concept of "CPU port", then I'm not sure why you don't just enable all
the VLANs on it?

Also, how are you going to set the VLAN filters for the CPU port when
you don't offload a bridge, but instead vlan devices between which you
route packets? You lose your abstraction of CPU port...

Thanks!
