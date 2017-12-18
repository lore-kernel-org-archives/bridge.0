Return-Path: <makita.toshiaki@lab.ntt.co.jp>
References: <73a472e3-e521-1930-0643-a6f2714db6ce@cumulusnetworks.com>
	<1513423896-30294-1-git-send-email-nikolay@cumulusnetworks.com>
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <0d66d7ab-2837-afcb-430f-32f6e4a5d675@lab.ntt.co.jp>
Date: Mon, 18 Dec 2017 11:24:03 +0900
MIME-Version: 1.0
In-Reply-To: <1513423896-30294-1-git-send-email-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: fix early call to
 br_stp_change_bridge_id
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, roopa@cumulusnetworks.com, avagin@gmail.com, davem@davemloft.net

On 2017/12/16 20:31, Nikolay Aleksandrov wrote:
> The early call to br_stp_change_bridge_id in bridge's newlink can cause
> a memory leak if an error occurs during the newlink because the fdb
> entries are not cleaned up if a different lladdr was specified, also
> another minor issue is that it generates fdb notifications with
> ifindex = 0. To remove this special case the call is done after netdev
> register and we cleanup any bridge fdb entries on changelink error.
> That also doesn't slow down normal bridge removal, alternative is to call
> it in its ndo_uninit.
...
> Fixes: a4b816d8ba1c ("bridge: Change local fdb entries whenever mac address of bridge device changes")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
> Consequently this also would fix the null ptr deref due to the rhashtable
> not being initialized in net-next when br_stp_change_bridge_id is called.
> 
> Toshiaki, any reason you called br_stp_change_bridge_id before
> register_netdevice when you introduced it in 30313a3d5794 ?

Thank you for taking care of this.
It's my bad. I just missed the problem.

>  net/bridge/br_netlink.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index d0ef0a8e8831..b0362cadb7c8 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1262,19 +1262,23 @@ static int br_dev_newlink(struct net *src_net, struct net_device *dev,
...
>  	err = br_changelink(dev, tb, data, extack);
> -	if (err)
> +	if (err) {
> +		/* clean possible fdbs from br_stp_change_bridge_id above */
> +		br_fdb_delete_by_port(br, NULL, 0, 1);

Don't we need to call br_dev_delete (br_link_ops.dellink) after
successful register instead of br_fdb_delete?
Particularly I'm wondering if not calling br_sysfs_delbr() is ok or not.

-- 
Toshiaki Makita

