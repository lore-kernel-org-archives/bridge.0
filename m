Return-Path: <eric.dumazet@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version;
	bh=gg6ewOqIJ1YfhB6V7BSsok3BPac4LHL4jEA6a+H5a2o=;
	b=PcZWF8hIcSB/5zQQv/lplQy8XSiOLPf0GDKfTP/p53sJu4BlAZlNoGH/3CRy+87ysp
	aMEAAWhJf3x7IR9bnk+uMohyne67YXovEOKJp7QuRm9PDfAaFMBIHxDiCOBzwuWJMeND
	giSnhq6RvTElR49uG55bzjTGVps8DngpdF3kZ1Bgq4WYtLrMOsT+Wue+ts0lsFN39l3A
	COlN2uTLpmi7hK3f6z96zhYtTO+wc5pzeSTWe3D9qTWlXjcT2g2GW2IWjwUvGk7pVm8K
	oAAZa5loZ66u5IG7GOnQHxGTKhktk0nC/LknezjyESUB8KdXj0N1LqsiUjdSJt12AP8U
	Iohw==
Message-ID: <1386256693.30495.194.camel@edumazet-glaptop2.roam.corp.google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 05 Dec 2013 07:18:13 -0800
In-Reply-To: <1386255025-23823-1-git-send-email-jiri@resnulli.us>
References: <1386255025-23823-1-git-send-email-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Subject: Re: [Bridge] [patch net/stable] br: fix use of ->rx_handler_data in
 code executed on non-rx_handler path
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>
Cc: jtluka@redhat.com, mst@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, stephen@networkplumber.org, edumazet@google.com, laine@redhat.com, zhiguohong@tencent.com, davem@davemloft.net

On Thu, 2013-12-05 at 15:50 +0100, Jiri Pirko wrote:
> br_stp_rcv() is reached by non-rx_handler path. That means there is no
> guarantee that dev is bridge port and therefore simple NULL check of
> ->rx_handler_data is not enough. There is need to check if dev is really
> bridge port and since only rcu read lock is held here, do it by checking
> ->rx_handler pointer.
> 
> Note that synchronize_net() in netdev_rx_handler_unregister() ensures
> this approach as valid.
> 
> Introduced originally by:
> commit f350a0a87374418635689471606454abc7beaa3a
>   "bridge: use rx_handler_data pointer to store net_bridge_port pointer"
> 
> Fixed but not in the best way by:
> commit b5ed54e94d324f17c97852296d61a143f01b227a
>   "bridge: fix RCU races with bridge port"
> 
> Reintroduced by:
> commit 716ec052d2280d511e10e90ad54a86f5b5d4dcc2
>   "bridge: fix NULL pointer deref of br_port_get_rcu"
> 
> Please apply to stable trees as well. Thanks.
> 
> Reported-by: Laine Stump <laine@redhat.com>
> Signed-off-by: Jiri Pirko <jiri@resnulli.us>
> ---
>  net/bridge/br_private.h  | 12 ++++++++++++
>  net/bridge/br_stp_bpdu.c |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 229d820..67a2d4b 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -204,6 +204,13 @@ static inline struct net_bridge_port *br_port_get_rcu(const struct net_device *d
>  	return rcu_dereference(dev->rx_handler_data);
>  }
>  
> +static inline bool br_rx_handler_check_rcu(const struct net_device *dev);
> +

Why doing this ugly forward declaration ?

> +static inline struct net_bridge_port *br_port_get_check_rcu(const struct net_device *dev)
> +{
> +	return br_rx_handler_check_rcu(dev) ? br_port_get_rcu(dev) : NULL;
> +}
> +
>  static inline struct net_bridge_port *br_port_get_rtnl(const struct net_device *dev)
>  {
>  	return br_port_exists(dev) ?
> @@ -426,6 +433,11 @@ netdev_features_t br_features_recompute(struct net_bridge *br,
>  int br_handle_frame_finish(struct sk_buff *skb);
>  rx_handler_result_t br_handle_frame(struct sk_buff **pskb);
>  



> +static inline bool br_rx_handler_check_rcu(const struct net_device *dev)
> +{
> +	return rcu_dereference(dev->rx_handler) == br_handle_frame;
> +}


Move br_port_get_check_rcu() here ?


> +
>  /* br_ioctl.c */
>  int br_dev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
>  int br_ioctl_deviceless_stub(struct net *net, unsigned int cmd,
> diff --git a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
> index 8660ea3..bdb459d 100644
> --- a/net/bridge/br_stp_bpdu.c
> +++ b/net/bridge/br_stp_bpdu.c
> @@ -153,7 +153,7 @@ void br_stp_rcv(const struct stp_proto *proto, struct sk_buff *skb,
>  	if (buf[0] != 0 || buf[1] != 0 || buf[2] != 0)
>  		goto err;
>  
> -	p = br_port_get_rcu(dev);
> +	p = br_port_get_check_rcu(dev);
>  	if (!p)
>  		goto err;
>  


