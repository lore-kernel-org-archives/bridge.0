Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IA2delY+nvouL7k3WAzaksVLLZyCKVj7Nj88hB3F63s=;
 b=GYrmOPaepSu5FE6sfqecFvPZF773kgYg1vEEYvE1MbxANRsiSYvBfYILVlNDEdGhFO
 JUSGMofsQoayPlsa6FZcB9iMp9QZ0BrtlSbXser6l9hz1+MXlF8TIJWV9wu8l0juOa4e
 g+Zd5QNvCFTXHNT/JnUbdNFiuWpvINsRHcohiM3zW2UMJng0/82ZQq6UDkgO3zABBHkn
 1AMokmHlCQgEhi9uKoARCID/6Ta4moGt3wXoN83JCl34IPN/6jrsj0PfjOTejxnjS1sh
 huOkILHsB+O0ZM1bk7RezUbAMXZVrgZKNX5za1Uz/p/g4YOXIriT2aTCYk9PONAM+IFu
 WsiQ==
References: <20200113155233.20771-1-nikolay@cumulusnetworks.com>
 <20200113155233.20771-4-nikolay@cumulusnetworks.com>
 <20200114055544.77a7806f@cakuba.hsd1.ca.comcast.net>
From: David Ahern <dsahern@gmail.com>
Message-ID: <076a7a9f-67c6-483a-7b86-f9d70be6ad47@gmail.com>
Date: Tue, 14 Jan 2020 08:34:05 -0700
MIME-Version: 1.0
In-Reply-To: <20200114055544.77a7806f@cakuba.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 1/14/20 6:55 AM, Jakub Kicinski wrote:
> On Mon, 13 Jan 2020 17:52:28 +0200, Nikolay Aleksandrov wrote:
>> +static int br_vlan_rtm_dump(struct sk_buff *skb, struct netlink_callback *cb)
>> +{
>> +	int idx = 0, err = 0, s_idx = cb->args[0];
>> +	struct net *net = sock_net(skb->sk);
>> +	struct br_vlan_msg *bvm;
>> +	struct net_device *dev;
>> +
>> +	if (cb->nlh->nlmsg_len < nlmsg_msg_size(sizeof(*bvm))) {
> 
> I wonder if it'd be useful to make this a strict != check? At least
> when strict validation is on? Perhaps we'll one day want to extend 
> the request?
> 

+1. All new code should be using the strict checks.

