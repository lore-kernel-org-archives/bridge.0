Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F8F3ED5C9
	for <bridge@lists.linux.dev>; Thu,  9 Jul 2026 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589683; cv=none; b=fO4qpPaeUWC5Bfh6OtUIjgm8TWzrsmTk7iGkeVDU0m+y9tbbAoLHgDuJTXPV6L/e+LK3ROWj05HgoEdk8X1a76mEQP23folo243NKEUGzXOxkSclRWywOTych+h+SjUMhP1EuBs2UMYqCj6vN7bS3P28YbnZACGHgwPc9O4qLpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589683; c=relaxed/simple;
	bh=BGotsO+Xy3yZ58ijoTkhB5nFmmjexia5sAeBl48H7c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5vv+3pGoFVm6ryoNpWj68EEtKuZqvtjpJwIK6htE1kksZ3VX5FOuroF5fzL4W1BIZgtqpRdA6g87DgmVkXCUZsxlXTeO6wJsLkjkTycjKuCyLgzzsaWEeJzBEJt1ggcKMT2S74g/7DC0/43aBmc5uwgU9wWUwHlWpBrhcH1uTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=nkE6xMH2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="nkE6xMH2"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so5073425e9.1
        for <bridge@lists.linux.dev>; Thu, 09 Jul 2026 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1783589680; x=1784194480; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uY49nb5pN+xm+mpr8Plpnx3+y2A04Mn/N8LUEgZX3IY=;
        b=nkE6xMH2razpCSnN/qVf5OS8PArq9GEtrUGlF22RJYfteSDVA6gcsNDBCnb8XJPpqr
         uOdFCi/E1KYvgmCEJ6FbsQRoyn3lb5aprrpjta0wkUtzQRd8oCRw1/AKIXJ4mJaB/KPT
         aDjWmgjN6RdpzjB2EG2IXvovf5FsMgaTDXuYhtrMsRwQIuqt7StMpM0A4nTppV2ZOygT
         vR9UbPKt26iTwB3p3zV6/b1MbMe5nd4y+WzMzg7oT/j2/nJj5De+Gr2hfepKKrLmq+xE
         akQftcikefJbBqPgwOCGdAeOaf7LMW/bBNQUUq9/L2ulShXICBjygSKqgoqYtufFqp7Q
         4NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783589680; x=1784194480;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uY49nb5pN+xm+mpr8Plpnx3+y2A04Mn/N8LUEgZX3IY=;
        b=rwZ9NFQwOAXD2MQslqfuWa7rPsMC+2ACVrYd8bTBsTsTy8nHV16G5Yl7jCKzZcm2pX
         hMv+wm4ufDY0pW9mgUrunyN9aZuz2GpNRQUZIVkw03dCMRdxJUYkvWDcSg5/475tZZlK
         wOlrkWq9yOF15hVeodB7rK5cndD6YF0bRK/SHGzks3219GTmD1XRhFAgnwolQKP3xW2A
         4NHTiIn0cgt5gZwbvkbbKWBuIVcVS8MVRyrPDHceu8EfOZVlz+mEJXecuA6nBoFT0X7R
         cjXnqvD31HmbBMOYIOmPA3Z3t9SXC0nT4OYZuuHLnKxwkT8m2Ghd9e6aY1hHdtAZohZr
         WjMQ==
X-Forwarded-Encrypted: i=1; AHgh+RqthL75BjNrDV3Xqk5zjLegnjITBR4Z6GRNlaOdH/I3vB9EJukNTiExpZC0Ba/G06VOtMzh8Rc=@lists.linux.dev
X-Gm-Message-State: AOJu0YwOBseeM4MHj5WAtWN1hSmRz6vN9GtkC1P99wix+u4K55oyWkg9
	Vdd5bzJq97exrM7Cm2B85ugDr8NoiLcPlLmJLMCeHGjl4HPwgH2tAHM/FHvox4trX00=
X-Gm-Gg: AfdE7cmnXM/XVI879Itc9Xi8wnWx08YAkPwEBG3VaejnQOCmscK8Vykho+dhDDoGEL8
	4eJRjUsEfJqkBeANvBb+juIQ3+RKm8eRvRMZW5K/gO+3oQxFqoUJwX74dyGEPV6PrynZ2ueR+by
	NN269xNWugdkHslv5piCFMlxDQntrafXiwspmKZH7yXD8URjrUHlSeJ0ft2aYgyK7d4bxMbLA4f
	hMmtK6jiXw0QyBD4c+JDTM6OnUapAieZZ6SghWlqtjWiVhahYXI64gJy1p0u2wHMWetqX7wR9hG
	yv4t6fX4EPBf9a9QPhzPmlYj0Pu4dJvejnme7HC3jOk/KwkwFC65h+bTNEzY2+6AjjT4L4eYFPr
	E4GNX3fpnJlt+vj1Y9pi+pbfF2WOKIu7L+zvMxTaMpEOLtBimMn3q5hGFSKqP7TowKWQZyLWInA
	1pXxKa1JlNWLBrPfigDKRR5MHdSC+3av8nwtjlBVlbDzpw2Ma1vfMGOg==
X-Received: by 2002:a05:600c:22d2:b0:48a:5f32:62c6 with SMTP id 5b1f17b1804b1-493ec7754cemr14846825e9.11.1783589679980;
        Thu, 09 Jul 2026 02:34:39 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae44sm47893706f8f.23.2026.07.09.02.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 02:34:39 -0700 (PDT)
Message-ID: <b0774436-bc41-462f-820b-6a037b6082bb@blackwall.org>
Date: Thu, 9 Jul 2026 12:34:37 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 nf-next 0/7] netfilter: Add bridge-fastpath
To: Pablo Neira Ayuso <pablo@netfilter.org>,
 Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, Ido Schimmel <idosch@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>,
 Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Krishna Kumar <krikku@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20260707091045.967678-1-ericwouds@gmail.com>
 <ak4culZgTe8CNSva@chamomile>
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ak4culZgTe8CNSva@chamomile>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/07/2026 12:47, Pablo Neira Ayuso wrote:
> Hi Eric,
> 
> On Tue, Jul 07, 2026 at 11:10:38AM +0200, Eric Woudstra wrote:
>> This patchset makes it possible to set up a software fastpath between
>> bridged interfaces. One patch adds the flow rule for the hardware
>> fastpath. This creates the possibility to have a hardware offloaded
>> fastpath between bridged interfaces. More patches are added to solve
>> issues found with the existing code.
> 
> Thanks for your series.
> 
> I posted an alternative series, including one of your patches for the
> bridge vlan filtering support (which is still untested on my side):
> 
> https://lore.kernel.org/netfilter-devel/20260708093250.1187068-1-pablo@netfilter.org/T/#m270aedab59bf39f1bc4452d1d8d739a2b1b0bc45

Hi Pablo,
I think I haven't been CCed on that posting, can't find it in my inbox.
Anyway, I know I've acked the patch but taking a second look I think there might
be a problem, specifically at patch 01:

+	if (netif_is_bridge_port(ctx->dev)) {
+		struct net_device *br_dev;
+
+		br_dev = netdev_master_upper_dev_get_rcu((struct net_device *)ctx->dev);
+		if (!br_dev)
+			return -1;

-	br = netdev_priv(ctx->dev);
+		src = br_port_get_rcu(ctx->dev);
+		br = netdev_priv(br_dev);
+	} else {
+		src = NULL;
+		br = netdev_priv(ctx->dev);
+	}

If ndo_fill_forward_path can be called while a port is being removed from the
bridge, then we might reach this call and netif_is_bridge_port() can be false
since the flag is removed before the synchronize_net() done by rx handler
unregistering. Specifically if CONFIG_BRIDGE_VLAN_FILTERING is not defined
then the previous synchronize_net/rcu are not done and I think we can observe
a port which is being dismantled in ndo_fill_forward_path without the flag and
erroneously categorized as a bridge device. I think a safer and correct approach
would be to check if the device is a bridge master:
  } else if (netif_is_bridge_master(ctx->dev)) {
...

Cheers,
  Nik

