Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA51F4176
	for <bridge@lists.linux.dev>; Thu, 27 Aug 2026 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841356; cv=none; b=ATeFyJSgjlsvkTbKtOqRHudqhlhMQmM1wG+pml2APg6mOIdWgyKwnoU4KsTDD00AhhmRFQN7ZMUdRADFle0EIpkrsnMhWkKOL9zXUnJP85+X/Vv/WSTg32eISb8M6u+PRUS6BIAbi7K8qrNAk4iogxD+k1E9URMotvkVzAkEK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841356; c=relaxed/simple;
	bh=OvCuE3tKhuByh3bh7M7tAUdCId7sWjvotChThY107eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3NdtkuGget3wYT92iP0T1S56ryfbTI7egj7GX06jzgN6cUD6urrvyRYoHYY57bCMcJTEKSYtVuBWXrivvp86+297bJiMB0DR2K52IcVYlVA6KAyDvWOEebe0t5D7/nTC84cdKQMDHTOhRkXjfztYrwRac0mCy/IxKFreNmjaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=dwLJZij8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="dwLJZij8"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2530cabcf4so250952266b.0
        for <bridge@lists.linux.dev>; Thu, 27 Aug 2026 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787841353; x=1788446153; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BKzWbSJH9JlleRjv6GcxliujufDL4y1EreMLQdzQ5Js=;
        b=dwLJZij8KGne0jSU4/26bLuz51MAtF3+ZAcgJYcfz2I1v5ilcLry9NNfvkqUXy+9XG
         fLH3e/OwKE8ja0qkltHeEIhJYlSCspnu99VfnQnHTfBIKHQHgfMPVXmR54vZ3uyuXmCg
         RbxMdGoLdjkDxAOqK7ts8aWtIELrkkzt6EW6n+IWhJwSkStlpIW0PCrl4mu+fJ+q/nub
         eMqG/1PseaeZdhV5JEP4VCWqhat2dGVuA4J3vFcQCdWosdtf6xXQkPrR3thD9fREo7mZ
         6QQs5VsdbLx4ZONkB/Sy1RfkTIJ2NIgglhMiSHnbzL3XaMhCnTucfjfGoY6CtCn1L1GO
         9NGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787841353; x=1788446153;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BKzWbSJH9JlleRjv6GcxliujufDL4y1EreMLQdzQ5Js=;
        b=X6JMjihuIeZTkf9IQWz/FpAlyLBTXAwbsASd9KNwGvWanXQPYtUMzBxsCjm0h94AD/
         /6ylcUQurY4F60h0wu3b+OTxibgw/qS3pDHlZ7p7Ec4Lt54xAZDUfUAfyxPq5tfs7fbO
         cN6szLFjDT2uD7nNeOq0rTCLC+M1Y8pLlimwGXSVemqht+7RV63rTx8MDApvtOLyqYKe
         XqrXsrz/2AxScqdNJ0FlJCxuNC6KRJe+0YGOTBfPXjwhQz8rx+UGDFaVhJQUl8ax8Fd/
         LAMiqped0WRJs17NYZrgN3onp1W3jcR2qT5IXazGuqWayS7fMRz2pXum7KYcSCck2DJC
         KGCQ==
X-Gm-Message-State: AFuF++nJgTVRL+ElOqj8zB7SiVwciQVv2/rQXS735NkiC4RRT8NvlGGc
	sAWtru3DY2DqVmWsde5tv2tUgsdSaXQirXL8WNNsOsFjFf1TDENmw/jltNblA8vSCnU=
X-Gm-Gg: AR+sD13sMOZ4gZYOWXFUhQcrmS1trfmyG93luQmMYQdJoZ2jPEblzbRs4a7W29WTMm8
	QqnbxkM6Klt7CebkmXQA7BCIEMEGg/RERdnkclwNtxKTzOvsIZCOqtL/YYom3hgsTPbERVvHcvp
	fF6vgE313rwSpf6GXKjO/Lc9Vc4kq56o308XTzmDWxStCDdjIGW5tTCxAkHr4/4L1HwmQ22Kcjd
	llIcNLve/jiEB89gqGAb/3C9j/HJUOnQC2rk+FZXGtW/nehoUtjs9sTjB4mxhAECZ5DIlv+SPXP
	oYqNqiU+RLOt2ncqS+DgHSCPVYd5qplgJFA/CW0Wt3kL+qP4+zcrA0OG2fXjTHD5JWmGqgkbDdA
	fL+V1+FscVgHCL6jKsvJd6h1wrpLbaI8fU54He77Q0tRVa9PvamBaAzhHkyA+nGMKmiekVKFyvk
	bw63qHZYOK0Lbe9sKL4ZgeBGthT9zUGxVY5OuarQ7RqlXgKBG8OCgP+NzdIthyCSE6h4hJUtgix
	jnkse8b/LYISFvqorU=
X-Received: by 2002:a17:907:c08c:b0:c21:752f:c44e with SMTP id a640c23a62f3a-c250bc0f7e6mr1797816966b.16.1787841352449;
        Thu, 27 Aug 2026 07:35:52 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d62dfsm738498266b.4.2026.08.27.07.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 07:35:51 -0700 (PDT)
Message-ID: <ddf53430-f3ce-4ca8-aacd-3fd8ffc81091@blackwall.org>
Date: Thu, 27 Aug 2026 17:35:50 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] net/bridge: out-of-bounds in br_forward()
Content-Language: en-US, bg
To: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Phil Sutter <phil@nwl.cc>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <fai12uKS5302YnCQV4E3zlDqcsAS5aGcMutS@bugs.sh>
 <apBJyKJ7zs4kUmpd@strlen.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <apBJyKJ7zs4kUmpd@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/08/2026 17:29, Florian Westphal wrote:
> co <co+63bad23bb3b4cd85@bugs.sh> wrote:
>> We found a bug reachable in:
>>
>>      path    net/bridge/netfilter
>>      crash   out-of-bounds in br_forward()
>>      commit  7b5344954050 ("Merge tag 'nf-26-08-10' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf")
> 
> I'm looking into these reports, I think this is the same
> underlying bug as the other report; a variant of
> 
> ccb9fd4b8753 ("netfilter: revalidate bridge ports")
> 
> That bug uses nfnetlink_queue for RCU escape, the other two reports
> use defrag engine.
> 
> And sure, its br_netfilter again -- I think we will have to consider
> removing it even though it will break existing setups.
> 

+10

> As a compromise, I suggest to reject br_netfilter in user namespaces,
> i.e. call_iptables cannot be enabled anymore unless you have
> CAP_NET_ADMIN in init net.

+1000 :)

I absolutely agree on both counts.
