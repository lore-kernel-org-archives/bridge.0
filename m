Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=iUa0nG7RILOszUbC/Ce74QitnOCb+1UdyVX3GAwcC9o=;
	b=W5f40diHRQhvPjYFvAomlMvp+6rGSoy/kdk0BPs/SbjYibWxtXajpvYFZxCxjE/v5+
	/NmEU2bJmmVSfIpP1i/MV2L8X6HZGj72/vonNkJz2+mYF3eILWYJ/hnzi312xBq38g0m
	xqs/HlSZRi4kpj8GZ9/vwPdLhDZD9NwttZNv4=
References: <20190113135939.8970-1-zahari.doychev@linux.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <62e4c62c-39c0-71d7-99d0-3e51878e2ddc@cumulusnetworks.com>
Date: Mon, 14 Jan 2019 13:46:09 +0200
MIME-Version: 1.0
In-Reply-To: <20190113135939.8970-1-zahari.doychev@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 0/2] net: bridge: fix tc added QinQ forwarding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Zahari Doychev <zahari.doychev@linux.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, roopa@cumulusnetworks.com
Cc: johannes@sipsolutions.net, jhs@mojatatu.com

On 13/01/2019 15:59, Zahari Doychev wrote:
> The Linux bridge seems to not correctly forward double vlan tagged packets
> added using the tc vlan action. I am using a bridge with two netdevs and on one
> of them a have the clsact qdisc with tc flower rule adding two vlan
> tags.
> 
> ip link add name br0 type bridge vlan_filtering 1
> ip link set dev br0 up
> 
> ip link set dev net0 up
> ip link set dev net0 master br0
> 
> ip link set dev net1 up
> ip link set dev net1 master br0
> 
> bridge vlan add dev net0 vid 100 master
> bridge vlan add dev br0 vid 100 self
> bridge vlan add dev net1 vid 100 master
> 
> tc qdisc add dev net0 handle ffff: clsact
> tc qdisc add dev net1 handle ffff: clsact
> 
> tc filter add dev net0 ingress pref 1 protocol all flower \
> 		  action vlan push id 10 pipe action vlan push id 100
> 
> tc filter add dev net0 egress pref 1 protocol 802.1q flower \
> 		  vlan_id 100 vlan_ethtype 802.1q cvlan_id 10 \
> 		  action vlan pop pipe action vlan pop
> 
> When using the setup above the packets coming on net0 get double tagged but
> the MAC headers gets corrupted when the packets go out of net1. It seems that
> the second vlan header is not considered in br_dev_queue_push_xmit. The skb
> data pointer is decremented only by the ethernet header length. This later
> causes the function validate_xmit_vlan to insert the outer vlan tag behind
> the inner vlan tag. The inner vlan becomes also part of the source mac address.
> 
> The first patch fixes the problem described above. The second one fixes
> similar problem when the tpids of the bridge and the inserted vlan don't match.
> It fixes again incorrect insertion of the skb vlan into the payload. The two
> patches seem to fix the problem but I am not sure if this the right way to fix
> this and if there is any other impact.
> 
> Zahari Doychev (2):
>   net: bridge: fix tc added QinQ forwarding
>   net: bridge: fix tc added vlan insert as payload
> 
>  net/bridge/br_forward.c | 2 +-
>  net/bridge/br_vlan.c    | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 

How well was this set tested ? It breaks connectivity between bridge and
members when vlans are used. The host generated packets going out of the bridge
have mac_len = 0.

E.g.:
# tcpdump -e -n -i vnet2
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on vnet2, link-type EN10MB (Ethernet), capture size 262144 bytes
17:47:08.824208 00:01:52:54:00:04 > 00:01:08:00:06:04, ethertype 802.1Q (0x8100), length 32: vlan 25, p 0, ethertype 0x5eba, 
	0x0000:  c0a8 6401 0000 0000 0000 c0a8 6402       ..d.........d.
17:47:09.848492 00:01:52:54:00:04 > 00:01:08:00:06:04, ethertype 802.1Q (0x8100), length 32: vlan 25, p 0, ethertype 0x5eba, 
	0x0000:  c0a8 6401 0000 0000 0000 c0a8 6402       ..d.........d.

Headers are messed up. This is br0 with pvid 25 and vnet2 with vlan 25 tagged.
You'll probably have to reset mac_len in bridge's xmit function.

The potentially affected cases will need to be carefully considered, as you've noted,
since this change is dangerous. Please also run all bridge selftests and make sure
they all pass. Giving more details about which cases you've considered and how
this set was tested in the commit log would be very helpful.

Thanks,
 Nik


