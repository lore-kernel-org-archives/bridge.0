Return-Path: <BATV+52873753120e990d0a27+3393+infradead.org+tgraf@casper.srs.infradead.org>
Date: Fri, 7 Dec 2012 10:36:29 +0000
From: Thomas Graf <tgraf@suug.ch>
Message-ID: <20121207103629.GB2996@casper.infradead.org>
References: <1354874688-24564-1-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1354874688-24564-1-git-send-email-amwang@redhat.com>
Sender: Thomas Graf <tgr@infradead.org>
Subject: Re: [Bridge] [PATCH net-next v5] bridge: export multicast database
	via netlink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <amwang@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Herbert Xu <herbert@gondor.hengli.com.au>, Jesper Dangaard Brouer <brouer@redhat.com>, Stephen Hemminger <shemminger@vyatta.com>, "David S. Miller" <davem@davemloft.net>

On 12/07/12 at 06:04pm, Cong Wang wrote:
> From: Cong Wang <amwang@redhat.com>
> 
> V5: fix two bugs pointed out by Thomas
>     remove seq check for now, mark it as TODO
> 
> V4: remove some useless #include
>     some coding style fix
> 
> V3: drop debugging printk's
>     update selinux perm table as well
> 
> V2: drop patch 1/2, export ifindex directly
>     Redesign netlink attributes
>     Improve netlink seq check
>     Handle IPv6 addr as well
> 
> This patch exports bridge multicast database via netlink
> message type RTM_GETMDB. Similar to fdb, but currently bridge-specific.
> We may need to support modify multicast database too (RTM_{ADD,DEL}MDB).
> 
> (Thanks to Thomas for patient reviews)
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Stephen Hemminger <shemminger@vyatta.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Thomas Graf <tgraf@suug.ch>
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Cong Wang <amwang@redhat.com>

Acked-by: Thomas Graf <tgraf@suug.ch>
