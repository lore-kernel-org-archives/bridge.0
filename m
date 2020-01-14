Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579010145;
 bh=1yUOzUoSxcZExOH/9FkbsG0uKOk9GKckSuGzrxAhpN4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Y/OHm3zVJP77IeFzNoTtCjaV4OMo99jbKwlrOUlnf74lwnac0v9y+KRU8MT/8n/1U
 v1vikP/x83NJ81KIqu9FjDc8BC5HTVi4vL06g1v+ntBL5f0MJEBv0uSh9lzruZIGrM
 jq/Yhgng2P3+H4sqZMZnw4xSFckrSrVxa7SudB0Q=
Date: Tue, 14 Jan 2020 05:55:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20200114055544.77a7806f@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20200113155233.20771-4-nikolay@cumulusnetworks.com>
References: <20200113155233.20771-1-nikolay@cumulusnetworks.com>
 <20200113155233.20771-4-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 3/8] net: bridge: vlan: add rtm
 definitions and dump support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, "dsahern@gmail.com" <dsahern@gmail.com>

On Mon, 13 Jan 2020 17:52:28 +0200, Nikolay Aleksandrov wrote:
> +static int br_vlan_rtm_dump(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	int idx = 0, err = 0, s_idx = cb->args[0];
> +	struct net *net = sock_net(skb->sk);
> +	struct br_vlan_msg *bvm;
> +	struct net_device *dev;
> +
> +	if (cb->nlh->nlmsg_len < nlmsg_msg_size(sizeof(*bvm))) {

I wonder if it'd be useful to make this a strict != check? At least
when strict validation is on? Perhaps we'll one day want to extend 
the request?

> +		NL_SET_ERR_MSG_MOD(cb->extack, "Invalid header for vlan dump request");
> +		return -EINVAL;
> +	}

