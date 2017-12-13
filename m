Return-Path: <davem@davemloft.net>
Date: Wed, 13 Dec 2017 15:10:16 -0500 (EST)
Message-Id: <20171213.151016.1106433741027557327.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1513087370-4791-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1513087370-4791-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: use rhashtable for fdbs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, srn@prgmr.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 12 Dec 2017 16:02:50 +0200

> Before this patch the bridge used a fixed 256 element hash table which
> was fine for small use cases (in my tests it starts to degrade
> above 1000 entries), but it wasn't enough for medium or large
> scale deployments. Modern setups have thousands of participants in a
> single bridge, even only enabling vlans and adding a few thousand vlan
> entries will cause a few thousand fdbs to be automatically inserted per
> participating port. So we need to scale the fdb table considerably to
> cope with modern workloads, and this patch converts it to use a
> rhashtable for its operations thus improving the bridge scalability.
> Tests show the following results (10 runs each), at up to 1000 entries
> rhashtable is ~3% slower, at 2000 rhashtable is 30% faster, at 3000 it
> is 2 times faster and at 30000 it is 50 times faster.
> Obviously this happens because of the properties of the two constructs
> and is expected, rhashtable keeps pretty much a constant time even with
> 10000000 entries (tested), while the fixed hash table struggles
> considerably even above 10000.
> As a side effect this also reduces the net_bridge struct size from 3248
> bytes to 1344 bytes. Also note that the key struct is 8 bytes.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
> After this I'll post patches for the per-port fdb limit option. Later we
> can get rid of hash_lock altogether though that requires much more
> careful changes.

Nice work Nikolay, applied, thanks!
