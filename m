Return-Path: <vladimir.oltean@nxp.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5260B404A1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30A6C40131
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orsDDOKKh9G4ZqtA+JbrZ/6al1+u8m6mVsti6x2RSZ0=;
 b=FdFeaLFbWNRS344QZX/4ayM8HEiU/IlgU2qNeF500NUHQrGDDXJY7bVd0fCzp58zaAdf4tsDDigANHDgqJFCugNHXu1KVFzQPfm9du/U0lsnK5Zx7Gp7qkbr+4ZnkNWLWd4a4UQr2N1UE7tfmVVziJ6gDF4ROscU5gwTE6PhGZ0=
Date: Mon, 24 Apr 2023 15:26:31 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Message-ID: <20230424122631.d7kwfwmlwvqjo3pz@skbuf>
References: <20230418155902.898627-1-vladimir.oltean@nxp.com>
 <875y9nt27g.fsf@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y9nt27g.fsf@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v2 net] net: bridge: switchdev: don't notify
 FDB entries with "master dynamic"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Sun, Apr 23, 2023 at 10:47:15AM +0200, Hans Schultz wrote:
> I do not understand this patch. It seems to me that it basically blocks
> any future use of dynamic fdb entries from userspace towards drivers.
> 
> I would have expected that something would be done in the DSA layer,
> where (switchcore) drivers would be able to set some flags to indicate
> which features are supported by the driver, including non-static
> fdb entries. But as the placement here is earlier in the datapath from
> userspace towards drivers it's not possible to do any such thing in the
> DSA layer wrt non-static fdb entries.

As explained too many times already in the thread here:
https://patchwork.kernel.org/project/netdevbpf/patch/20230318141010.513424-3-netdev@kapio-technology.com/
the plan is:

| Just like commit 6ab4c3117aec ("net: bridge: don't notify switchdev for
| local FDB addresses"), we could deny that for stable kernels, and add
| the correct interpretation of the flag in net-next.

Obviously we have not reached the end of that plan, and net-next is closed now.
