Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvRo1UX7h+VvHifNiaqz/XjPnCfcGJA1fWCfAdRkgDs=;
 b=oCep61/aYmSwaxoKXIR2eLqnjt7OVyVLLlf90WF7KYItVIazlNgUiF7ZMDTxrNIkgieDxDwtAsUeJZyGmfKRHIPJOwbqqA0q0Nh5IFyQ7ZPK0xErxfkYFDxq/F13b6cmFYN8DAg30wuzACCWVjzW/Wbjk3jI/pl98XZzvX5zwePXdZIt6OmLwPR7u51qShTVApkbOIdJfH+o1Swxel199LxN8TXco/8zWW+fCtYoYZP/E/rIKd7+ND60JIQ7bS3VBLum0vTvGz9s7Z3zgggJjnLRRfz0Mjo0HUHdQhfrsygmvDzXjAG3OgfYKpQGoKUNRToCUbDJC0yB/fTxSGpq+Q==
References: <20210801231730.7493-1-vladimir.oltean@nxp.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <ff6d11a2-2931-714a-7301-f624160a2d48@nvidia.com>
Date: Mon, 2 Aug 2021 10:42:41 +0300
In-Reply-To: <20210801231730.7493-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net] net: bridge: validate the NUD_PERMANENT
 bit when adding an extern_learn FDB entry
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>

On 02/08/2021 02:17, Vladimir Oltean wrote:
> Currently it is possible to add broken extern_learn FDB entries to the
> bridge in two ways:
> 
> 1. Entries pointing towards the bridge device that are not local/permanent:
> 
> ip link add br0 type bridge
> bridge fdb add 00:01:02:03:04:05 dev br0 self extern_learn static
> 
> 2. Entries pointing towards the bridge device or towards a port that
> are marked as local/permanent, however the bridge does not process the
> 'permanent' bit in any way, therefore they are recorded as though they
> aren't permanent:
> 
> ip link add br0 type bridge
> bridge fdb add 00:01:02:03:04:05 dev br0 self extern_learn permanent
> 
> Since commit 52e4bec15546 ("net: bridge: switchdev: treat local FDBs the
> same as entries towards the bridge"), these incorrect FDB entries can
> even trigger NULL pointer dereferences inside the kernel.
> 
> This is because that commit made the assumption that all FDB entries
> that are not local/permanent have a valid destination port. For context,
> local / permanent FDB entries either have fdb->dst == NULL, and these
> point towards the bridge device and are therefore local and not to be
> used for forwarding, or have fdb->dst == a net_bridge_port structure
> (but are to be treated in the same way, i.e. not for forwarding).
> 
> That assumption _is_ correct as long as things are working correctly in
> the bridge driver, i.e. we cannot logically have fdb->dst == NULL under
> any circumstance for FDB entries that are not local. However, the
> extern_learn code path where FDB entries are managed by a user space
> controller show that it is possible for the bridge kernel driver to
> misinterpret the NUD flags of an entry transmitted by user space, and
> end up having fdb->dst == NULL while not being a local entry. This is
> invalid and should be rejected.
> 
> Before, the two commands listed above both crashed the kernel in this
> check from br_switchdev_fdb_notify:
> 

Not before 52e4bec15546 though, the check used to be:
struct net_device *dev = dst ? dst->dev : br->dev;

which wouldn't crash. So the fixes tag below is incorrect, you could
add a weird extern learn entry, but it wouldn't crash the kernel.

> 	struct net_device *dev = info.is_local ? br->dev : dst->dev;
> 
> info.is_local == false, dst == NULL.
> 
> After this patch, the invalid entry added by the first command is
> rejected:
> 
> ip link add br0 type bridge && bridge fdb add 00:01:02:03:04:05 dev br0 self extern_learn static; ip link del br0
> Error: bridge: FDB entry towards bridge must be permanent.
> 
> and the valid entry added by the second command is properly treated as a
> local address and does not crash br_switchdev_fdb_notify anymore:
> 
> ip link add br0 type bridge && bridge fdb add 00:01:02:03:04:05 dev br0 self extern_learn permanent; ip link del br0
> 
> Fixes: eb100e0e24a2 ("net: bridge: allow to add externally learned entries from user-space")

Please change fixes tag to 52e4bec15546.

> Reported-by: syzbot+9ba1174359adba5a5b7c@syzkaller.appspotmail.com
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
[snip]

Thanks,
 Nik
