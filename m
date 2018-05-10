Return-Path: <davem@davemloft.net>
Date: Thu, 10 May 2018 17:51:35 -0400 (EDT)
Message-Id: <20180510.175135.2183739418603250085.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180510101306.4891-1-idosch@mellanox.com>
References: <20180510101306.4891-1-idosch@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/4] mlxsw: Support VLAN devices in
 mirroring offloads
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: idosch@mellanox.com
Cc: mlxsw@mellanox.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jiri@mellanox.com, petrm@mellanox.com

From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 10 May 2018 13:13:02 +0300

> Petr says:
> 
> When offloading "tc action mirred mirror", there are several scenarios
> where VLAN devices can show up, that mlxsw can offload on Spectrum
> machines.
> 
> I) A direct mirror to a VLAN device on top of a front-panel port device
>    (commonly referred to as "RSPAN")
> 
> II) VLAN device in egress path of a packet when resolving a mirror to
>     gretap or ip6gretap netdevice.
> 
> Specifically in the latter case, the following are the cases that can be
> offloaded:
> 
> IIa) VLAN device directly above a physical device.
> IIb) A VLAN-unaware bridge where the egress device is as in IIa.
> IIc) VLAN device on top of a VLAN-aware bridge where the egress device
>      is a physical device.
> 
> This patch set implements all the above cases.
 ...

Series applied, thanks.
