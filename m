Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7DvjBKU+lzi8updN/QuQZNwqHGl0ZMYszAHWb39k4Y=;
 b=ax6YfM6KtGttdQtOSbe1gUMVrlo165DqrTg8aQIF+YyuKoJApymFk/VvADwJUNXk01R6BcqVNrlBaJlNTrMrcXIBKRzUaWOwYF2XCtEBErSssavQJzALktgH7lHdG0lOTgf2zq2HY66UUbDYPHqT7c+8jZ6xzg00krxOxcUBy+2wYwsO3fbITUTwZNTDQIuGFlVApzA5K38ZcThh6hq4XM+jsOrw+L79yg1j4/fvDjjVPoqwY0fQHy+/Q3xPGSipxpymVrFRh5KxEF9KKmaYJ8hITt9RO9LYgyYSycwTfM2B6He0jskyiLZdZ4DEv/NjkdHWNeZ059khAQxGQae5ig==
References: <20210702120736.3746-1-w.bumiller@proxmox.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <c0168781-19a0-724b-09a4-f08dfa05e044@nvidia.com>
Date: Fri, 2 Jul 2021 18:25:38 +0300
In-Reply-To: <20210702120736.3746-1-w.bumiller@proxmox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v3] net: bridge: sync fdb to new
	unicast-filtering ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>, netdev@vger.kernel.org
Cc: Vlad Yasevich <vyasevic@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, bridge@lists.linux-foundation.org, Thomas Lamprecht <t.lamprecht@proxmox.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On 02/07/2021 15:07, Wolfgang Bumiller wrote:
> Since commit 2796d0c648c9 ("bridge: Automatically manage
> port promiscuous mode.")
> bridges with `vlan_filtering 1` and only 1 auto-port don't
> set IFF_PROMISC for unicast-filtering-capable ports.
> 
> Normally on port changes `br_manage_promisc` is called to
> update the promisc flags and unicast filters if necessary,
> but it cannot distinguish between *new* ports and ones
> losing their promisc flag, and new ports end up not
> receiving the MAC address list.
> 
> Fix this by calling `br_fdb_sync_static` in `br_add_if`
> after the port promisc flags are updated and the unicast
> filter was supposed to have been filled.
> 
> Fixes: 2796d0c648c9 ("bridge: Automatically manage port promiscuous mode.")
> Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
> ---
> Changes to v2:
>   * Added 'fdb_synced' boolean to only unsync on error if it was
>     actually synced.
>     `br_fdb_sync_static()` already unrolls changes if it encounters an
>     error in the middle, so only a successful call will trigger the
>     unsync.
>     I opted for the explicit error handling as I felt that avoiding the
>     error cleanup by moving the code down might be more easily missed in
>     future changes (I just felt safer this way), plus, it's closer to
>     the call which would normally be responsible for doing this which
>     felt more natural to me.
> 
>     I hope this is fine, otherwise I can still move it :-)
> 
>  net/bridge/br_if.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 

Looks good to me, thanks!
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

