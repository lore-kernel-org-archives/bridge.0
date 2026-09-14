Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF1439A803
	for <bridge@lists.linux.dev>; Mon, 14 Sep 2026 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375713; cv=none; b=hFV+gojw+FWAdzfdsAQYQG+UOTEm2iaxwsVoaL+uruI8M+hEA0134wRKdCRGjdTTemcea8BYQNP3MF3GvkJ56SsTZdqxAEh9+bbvdXkADM3QePNcMrEcLkVZ74RmZQFhocjaoFJAtUVTE7iGcHLdqxqfM0V+VxLfT8h6o6wqz4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375713; c=relaxed/simple;
	bh=R0P/c38iIYnBempsh/B5wBuzkZjvXciuyexnFDMRjPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2PZ2pe/C2lqaIjlMkkBdPx8NNblxGIOI5pmgEa3DHQ4mWxdmC/a5cOR82GBHtKIHfCCrkM0F3Qu611t9/C7XniVM8c+rldpFluzgX/Gb1R73EwK0cWWxaOOQsMLJcVn7YSeqcf30XrqCFBwUPF+FOlD76g5Ee6r8+aa2PtnjGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=QKR+fLgZ; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="QKR+fLgZ"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f88so882924f8f.2
        for <bridge@lists.linux.dev>; Mon, 14 Sep 2026 01:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789375710; x=1789980510; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0kvizxDrpk0j6xDj6aqJhobOa++7+JeUcG4npstg5E8=;
        b=QKR+fLgZ3Kwi5mO7/13ukYUWqd+8cMt/U0dUrwdoT3IPZB+EK5DMB786s3qYCVeh2J
         Meh3P2gXcTaNk8htda6nm8laNzRuUDFAR8QsaP22wX8qeNA5b6E3LhYRsHnJ4rl0iYo9
         ZJJAB1bNtGBWoa+X6QShTcoU7cgMCHRYgZphzWdUGtMfyMRwWh4maVMoyeWZ92TWVWOt
         HK56BnCVMLgwH9OV6MtVTZhNSoIo2fL5NO24D63Dhyv8WjIxSfQG3LvhNfySlCaEzZIC
         MGI0ehpYHVK7VbVNVZHsRhqnwmVOMI+eHo2ZvwJvE3nSexBqHmPiE1yvqbe5LWx0JyTZ
         szTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789375710; x=1789980510;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0kvizxDrpk0j6xDj6aqJhobOa++7+JeUcG4npstg5E8=;
        b=BeLxe9VGNYSW5xP//Cyf0/0sA+HGpX+c4YM7A6/Zo5vIplTtEClFVbWaF/nQGB8RQp
         J/nGcuT/AbJB1X92ULQSd4CTt8jdVVQdQp4jAypl6QBBasL9WCt+BODU4UaA8O+TNjtl
         MrY338XL+K4m5hAvHu3qyPYW7NQYzCOAm0K5Ba8lA7/RJzbRVkeRsz67+FLI5rTmHigL
         9JoZCem6w8rkXgBnitJ0udkx91vpnOP6lYchwBTKEAdkjw2U7qRU65rskP9cmdzCxTli
         XvaPNIYwSP2dH/aQ7s530LPSHGLLGi/czhBHE1rDYeVCcDTE9L0VC3YK1DPWoN653dA7
         RQIg==
X-Gm-Message-State: AFuF++mgLt546ghwZ0YmYqCIL3DbFZA35XWJi2AjPs8t0MwUxjvOuzEp
	OKzqB+L1IsQuLlbI+elZ0xdkvy1+3b9dXWyDUQfYWiABhvmbSSI8xchYPeTmWZYvLzk=
X-Gm-Gg: AYBFou3eZ0KgVi8VOV1FrfSNW6ZCeMa7UxTPwmasRtwB7h66Q5/g6nmHsqf7B0RYgbS
	1cLlviQ2bSWeQZ9DPKD//AOO/8qcSKOl1YLwuxlLeSBgfV5rOEW0Z7bhe/MbUNQhe/dVl/IysFE
	hlEy/UzZP0EQEpXbP7EOKCRbKtm9xOzGn9/0F3HroglM4Ue4jny9NiuKfJJZo2zK/m0sNQGwGCV
	4RSgcJk1v6ypZZ6MHh8/XDpeEOKyMcfk3UCGnj3RromjFGUfSPqyQh48BMnqNDhZG9QoCTfPhUr
	hdnZvREcAeRADhZ1Qb8fOqN7jLYdtGe7ejzMh48jSIcOyvBR+aWPpVTHfYoC4YDwJ2YHZnNvg1/
	nPmb3fWHwXZqgAGiRadcQ6S8k0N7jVpZ3mslQ1sreYAX4szlU9ttpMyAmRrx/kfpo9CIkMAWmnY
	BlRxdmXXxBEyMJIBKTb3T1aYsMqxQo1yS67/LNdIhqGDeaqSzVvew1wk0xus0CXazyn+UnDKQn+
	d056lTP8fyjwydvX9mdPZbgPScdFQ==
X-Received: by 2002:a05:6000:41eb:b0:484:42d5:e6d5 with SMTP id ffacd0b85a97d-48702a9a973mr1744558f8f.11.1789375710548;
        Mon, 14 Sep 2026 01:48:30 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33fd3bsm25823507f8f.19.2026.09.14.01.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 01:48:30 -0700 (PDT)
Message-ID: <2ce01033-a121-4d50-b629-f35e789a4743@blackwall.org>
Date: Mon, 14 Sep 2026 11:48:28 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: bridge: fail link info that does not
 fit the IFLA_AF_SPEC nest
Content-Language: en-US, bg
To: Artem Lytkin <iprintercanon@gmail.com>, netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, kuniyu@google.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 oss-drivers@corigine.com, wintera@linux.ibm.com, aswin@linux.ibm.com,
 linux-s390@vger.kernel.org
References: <20260912135022.1701-1-iprintercanon@gmail.com>
 <20260912135022.1701-3-iprintercanon@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260912135022.1701-3-iprintercanon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/09/2026 16:50, Artem Lytkin wrote:
> br_fill_ifinfo() puts all of a port's VLAN, tunnel and MST entries into
> one nest, and nla_len is a u16, so a large enough port produces a nest
> whose length wraps and userspace reads garbage.
> 
> Cancel the message and return -E2BIG with an extack pointing at
> RTM_GETVLAN instead. The dump retries the port with an empty skb and
> the error goes to userspace; notifications reach rtnl_set_sk_err() and
> listeners resync. Not -EMSGSIZE, since no bigger buffer would help.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
> ---
>   net/bridge/br_netlink.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 

This patch seems incomplete, it doesn't fix the same problem for MST and CFM.
They both can use the same helper - nla_nest_end_safe().
More below...

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 855a46aec3a89..53676df9e4d11 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -459,7 +459,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>   			  const struct net_bridge_port *port,
>   			  u32 pid, u32 seq, int event, unsigned int flags,
>   			  u32 filter_mask, const struct net_device *dev,
> -			  bool getlink)
> +			  bool getlink, struct netlink_ext_ack *extack)
>   {
>   	u8 operstate = netif_running(dev) ? READ_ONCE(dev->operstate) :
>   					    IF_OPER_DOWN;
> @@ -613,6 +613,12 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>   
>   done:
>   	if (af) {
> +		if (skb_tail_pointer(skb) - (unsigned char *)af > U16_MAX) {

here you can use nla_nest_end_safe()

> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "VLAN information does not fit in one message, use RTM_GETVLAN");
> +			nlmsg_cancel(skb, nlh);
> +			return -E2BIG;
> +		}
>   		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))

while here you can just change this to if !nla_len(af) nla_nest_cancel()

Also add a common label and goto it from all errors e.g:
nla_nest_too_large:
   	nlmsg_cancel(skb, nlh);
   	return -E2BIG;
>   			nla_nest_end(skb, af);
>   		else
> @@ -654,7 +660,8 @@ void br_info_notify(int event, const struct net_bridge *br,
>   	if (skb == NULL)
>   		goto errout;
>   
> -	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false);
> +	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false,
> +			     NULL);
>   	if (err < 0) {
>   		/* -EMSGSIZE implies BUG in br_nlmsg_size() */
>   		WARN_ON(err == -EMSGSIZE);
> @@ -693,7 +700,7 @@ int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>   		return 0;
>   
>   	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
> -			      filter_mask, dev, true);
> +			      filter_mask, dev, true, extack);
>   }
>   
>   static int br_vlan_info(struct net_bridge *br, struct net_bridge_port *p,

