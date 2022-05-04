Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 4 May 2022 12:06:00 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <YnJQCIKgriI3kjFc@sellars>
References: <20220405235117.269511-1-kevmitch@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220405235117.269511-1-kevmitch@arista.com>
Subject: Re: [Bridge] [PATCH v2 0/1] UDP traceroute packets with no checksum
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kevin Mitchell <kevmitch@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, gal@nvidia.com, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Matthias Schiffer <mschiffer@universe-factory.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pablo Neira Ayuso <pablo@netfilter.org>

On Tue, Apr 05, 2022 at 04:51:15PM -0700, Kevin Mitchell via Bridge wrote:
> This is v2 of https://lkml.org/lkml/2022/1/14/1060
> 
> That patch was discovered to cause problems with UDP tunnels as
> described here:
> 
> https://lore.kernel.org/netdev/7eed8111-42d7-63e1-d289-346a596fc933@nvidia.com/
> 
> This version addresses the issue by instead explicitly handling zero UDP
> checksum in the nf_reject_verify_csum() helper function.
> 
> Unlike the previous patch, this one only allows zero UDP checksum in
> IPv4. I discovered that the non-netfilter IPv6 path would indeed drop
> zero UDP checksum packets, so it's probably best to remain consistent.

Are you sure that a UDP zero checksum is not working for IPv6
packets? We are using it here without any issues with VXLAN
tunnels.

Yes, the original RFC did not allow UDP zero checksums in IPv6
packets, but I believe this has changed:

https://www.rfc-editor.org/rfc/rfc6936
(https://www.ietf.org/archive/id/draft-ietf-6man-udpzero-01.html)

Regards, Linus
