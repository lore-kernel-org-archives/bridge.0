Return-Path: <kevmitch@arista.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
 s=Arista-A; t=1649202720;
 bh=tjab0l+xfYR0aZEj5soCABbrSjfcWfiSiNw5bb6ADcc=;
 h=From:To:Cc:Subject:Date:From;
 b=woP9fF3qZzunKXrRcPgDSyac21eIvuWWbeTXc12/yEUdySijANk8sRKdptJl6l5cV
 iLcWQenoSPX2Ua0bGFCFKIClIsbbT65yMydGSEo0ET6l5uKpuHqFK61RohyHNSI0Kq
 N+MjUi8fnrUaLZTjxB92POD5qaaEiDgFmSq4TIzgFSShKcjV2p+U/2HajpkGw7oVwX
 Xbnd+gf0pkHohKyV6TZIsm4APNq+F+u8GWZm4iBIUbO2G1UxNT0QdN6rOWgHAL3CD+
 qbi6ht0AIfArtaytZm0+cEir6F5+2bHfzNrmyt+2AcBxSrm/nEmbNJqmeleAy7LBGo
 xAWf0YU6uw5RQ==
From: Kevin Mitchell <kevmitch@arista.com>
Date: Tue,  5 Apr 2022 16:51:15 -0700
Message-Id: <20220405235117.269511-1-kevmitch@arista.com>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 0/1] UDP traceroute packets with no checksum
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Cc: kevmitch@arista.com, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, gal@nvidia.com, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

This is v2 of https://lkml.org/lkml/2022/1/14/1060

That patch was discovered to cause problems with UDP tunnels as
described here:

https://lore.kernel.org/netdev/7eed8111-42d7-63e1-d289-346a596fc933@nvidia.com/

This version addresses the issue by instead explicitly handling zero UDP
checksum in the nf_reject_verify_csum() helper function.

Unlike the previous patch, this one only allows zero UDP checksum in
IPv4. I discovered that the non-netfilter IPv6 path would indeed drop
zero UDP checksum packets, so it's probably best to remain consistent.

-- 
2.35.1

