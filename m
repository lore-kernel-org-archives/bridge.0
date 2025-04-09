Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463D324886F
	for <bridge@lists.linux.dev>; Wed,  9 Apr 2025 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194804; cv=none; b=o3NnBNb5Hpi6kZBG0CzOH3nbpqPcUA/782rHhxWLn7x1KW3qPvFlHb7AxhDtqq2qw0pFCfUS3CI/HI20kclWjj6ZV0MAHXR+eXLgkUHPeqzr9PE6+BItG9IKITmb+CnMAIpAePvlu3qhDzI8hZl1Cfz6ZVF6DIENyizao66ikas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194804; c=relaxed/simple;
	bh=zqBa8qyfz3XqnbkLny2u5Hws//r6LChLxkecT5EOKeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnAwT4ISJUsgEqXUJeXXRCSsKNbR1RZx/hebFO4loqSrzVqx+0xf33j9hSU/ZVtXXTmj0trgShd3jk7savevp8xjnOqVwreKww2XbOGeQqL/f7/yf6ooEIvC83N2Y7giYWMoe+UTtL06fEdxDBykWxZwGnCskJGgVoyZpk+s3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=AePF1msv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="AePF1msv"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso44692555e9.3
        for <bridge@lists.linux.dev>; Wed, 09 Apr 2025 03:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744194800; x=1744799600; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBi4VOwBcb3oMnTsthtGachLyy7QtgkSFGvt4FX19+w=;
        b=AePF1msvD9Tzk7pyPpMMkxMdv/VeiCCTKzpFbKxlS8UdJhcUUYdAMqWTcArX6vupxE
         x3WWnaS7n1gOQZsFyJXYGNgIPwuN93quR6OVMrZ1noKyGMuNKzw69wsMkaQ7HUamhq2X
         D2WHa/Q9xMStq44a+4RFpqk9Fz+MZt4yob6pXCvyeYcelDhWdNi+2Cl2dlrG0SczWrRp
         Dp2qVnZVEH8MnP9MQnXx5Y63coUQkWlAkohR6LeP3CCIGfx84hDrG15rBsGuaVQt0B9M
         8xKBtKb9zeG0TcyA23XD6jNzPGIWpjOhmZu4LKz1cNyvc6D5jURv39hZ9MsJU4EnndiB
         +7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744194800; x=1744799600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBi4VOwBcb3oMnTsthtGachLyy7QtgkSFGvt4FX19+w=;
        b=pLNCkdk1IK120uiUIi5LDP+3zNQLMaf8p9c2p6lhTpXC5nYbZVrfy/ntIuhp6pxRJo
         ponsp9rzX6j099qBH5bK0u6QfsGVHt8BwBREyidv2+EXIAK3u81QufUd/Z+v3I5+a895
         QiKp0VXXC71WfIOpSrCl6b490thY5k6xD9tj4VQ9jy5es40ODWGR1zzkhyMIHNRpTRGv
         anMT/UU0Fij3P3ZrqlAbaQ+Wz5O2NbKLJ0x1f/FPmmgj9U2ydK9R9wq600XESvVePGZW
         l2EjfgwNeL4/h/gg0a3c2+S3ehM7YpU/NlkAs+6E8ZGMCAnaZkK1O/z4UUYe+NkXcQVe
         qnqA==
X-Forwarded-Encrypted: i=1; AJvYcCWtPz9RHOBq2/AnI60bGjXcBR7qpR/RKV1q9iPRCT8E3/4nS3ln7gVlcoD+7MJt3HNh3q093tA=@lists.linux.dev
X-Gm-Message-State: AOJu0YyrTl3n2MHk0xfkHlOl2sOiO/OXJeMVbpTgtFVggBiyUPZjnys1
	dOzqFbii0D8MydNSJJtWFPW6oNHFo4mTE/bfJgluX7Xcnl9sMykRs1ecp9MiYrw=
X-Gm-Gg: ASbGncsyRz+7kkabDUWiaojeuB709wXVooBpfpWQLqRk+EsBgI8bnRgFAz0WX8/DMwV
	5bHRnTQiMln1YF1wF12Juq/gTQq6XB5S8qXaSC4iV3cyyyQh3Pap+gFlU2vC1hOgQVkiL0W7SVI
	cQuwEpCF5ovaEtuH05V1jRoHccQ/fdZqUwn37d3RVzeVn+6YkzztJD98LxpvaRiBlopMVZ4NOac
	o11KmgGHd4ufbd5EAFjN78xSKtqi3nKgXGMcf/AUzf4e+lr8GcRdfRd3r0SapX0CoEN2kX5brId
	pOXw1TL9/dxyrXiuyjPnTp/XAvBqkymQuYifYxXORB/uKAJk1OoIMxQzD2+ZyQT9gotw0QI7SBs
	rFd9CiaQ=
X-Google-Smtp-Source: AGHT+IF+VmnSjKoz4qUXSItqfvLwHlUV3cZ/MgW2aun1vPnXhsC5dMMx7i0pxZQLraz/SZM47liIVw==
X-Received: by 2002:a05:600c:2d48:b0:43c:f332:703a with SMTP id 5b1f17b1804b1-43f21ad389fmr11637865e9.31.1744194800136;
        Wed, 09 Apr 2025 03:33:20 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2338dc13sm12257075e9.3.2025.04.09.03.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 03:33:19 -0700 (PDT)
Message-ID: <7d88da06-e943-4d78-a483-66d7ce151f00@blackwall.org>
Date: Wed, 9 Apr 2025 13:33:18 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: bridge: Prevent unicast ARP/NS packets
 from being suppressed by bridge
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 mlxsw@nvidia.com, Denis Yulevych <denisyu@nvidia.com>,
 Amit Cohen <amcohen@nvidia.com>
References: <cover.1744123493.git.petrm@nvidia.com>
 <6bf745a149ddfe5e6be8da684a63aa574a326f8d.1744123493.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <6bf745a149ddfe5e6be8da684a63aa574a326f8d.1744123493.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/25 18:40, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> When Proxy ARP or ARP/ND suppression are enabled, ARP/NS packets can be
> handled by bridge in br_do_proxy_suppress_arp()/br_do_suppress_nd().
> For broadcast packets, they are replied by bridge, but later they are not
> flooded. Currently, unicast packets are replied by bridge when suppression
> is enabled, and they are also forwarded, which results two replicas of
> ARP reply/NA - one from the bridge and second from the target.
> 
> RFC 1122 describes use case for unicat ARP packets - "unicast poll" -
> actively poll the remote host by periodically sending a point-to-point ARP
> request to it, and delete the entry if no ARP reply is received from N
> successive polls.
> 
> The purpose of ARP/ND suppression is to reduce flooding in the broadcast
> domain. If a host is sending a unicast ARP/NS, then it means it already
> knows the address and the switches probably know it as well and there
> will not be any flooding.
> 
> In addition, the use case of unicast ARP/NS is to poll a specific host,
> so it does not make sense to have the switch answer on behalf of the host.
> 
> According to RFC 9161:
> "A PE SHOULD reply to broadcast/multicast address resolution messages,
> i.e., ARP Requests, ARP probes, NS messages, as well as DAD NS messages.
> An ARP probe is an ARP Request constructed with an all-zero sender IP
> address that may be used by hosts for IPv4 Address Conflict Detection as
> specified in [RFC5227]. A PE SHOULD NOT reply to unicast address resolution
> requests (for instance, NUD NS messages)."
> 
> Forward such requests and prevent the bridge from replying to them.
> 
> Reported-by: Denis Yulevych <denisyu@nvidia.com>
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  net/bridge/br_arp_nd_proxy.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index 115a23054a58..1e2b51769eec 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -160,6 +160,9 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
>  	if (br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED)) {
>  		if (br_is_neigh_suppress_enabled(p, vid))
>  			return;
> +		if (is_unicast_ether_addr(eth_hdr(skb)->h_dest) &&
> +		    parp->ar_op == htons(ARPOP_REQUEST))
> +			return;
>  		if (parp->ar_op != htons(ARPOP_RREQUEST) &&
>  		    parp->ar_op != htons(ARPOP_RREPLY) &&
>  		    (ipv4_is_zeronet(sip) || sip == tip)) {
> @@ -410,6 +413,10 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
>  	if (br_is_neigh_suppress_enabled(p, vid))
>  		return;
>  
> +	if (is_unicast_ether_addr(eth_hdr(skb)->h_dest) &&
> +	    msg->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION)
> +		return;
> +
>  	if (msg->icmph.icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT &&
>  	    !msg->icmph.icmp6_solicited) {
>  		/* prevent flooding to neigh suppress ports */

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

