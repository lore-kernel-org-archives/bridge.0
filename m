Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun, 25 Apr 2021 18:00:48 +0200
Message-Id: <20210425160050.8732-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/2] net: bridge: split IPv4/v6 mc router
	state and export for batman-adv
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>

Hi,

The following are two patches for the Linux bridge regarding multicast
routers. They are rebased on top of the following fix:
"net: bridge: mcast: fix broken length + header check for MRDv6 Adv." [0]
And should be applied afterwards.

The first one splits the so far combined multicast router state into two
ones, one for IPv4 and one for IPv6, for a more fine-grained detection of
multicast routers. This avoids sending IPv4 multicast packets to an
IPv6-only multicast router and avoids sending IPv6 multicast packets to
an IPv4-only multicast router. This is also in preparation for the
second patch:

The second patch exports this now per protocol family multicast router
state so that batman-adv can then later make full use of the
Multicast Router Discovery (MRD) support in the Linux bridge. The
batman-adv protocol format currently expects separate multicast router
states for IPv4 and IPv6, therefore it depends on the first patch.
batman-adv will then make use of this newly exported functions like
this[1].

Regards, Linus

[0]: https://patchwork.kernel.org/project/netdevbpf/patch/20210425152736.8421-1-linus.luessing@c0d3.blue/
[1]: https://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/linus/multicast-routeable-mrd
     -> https://git.open-mesh.org/batman-adv.git/commit/d4bed3a92427445708baeb1f2d1841c5fb816fd4

