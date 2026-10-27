Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092216;
	b=iXVxHR3k8EgCxWwrQL3wZBLDn1Q2GdC9ElfPvPChJK7VSZDh1LekwDPeJ4jxpHMlseL8
	 HQ6mrUiZQ4VbhMjCfeWtFfW6PJ7XGuYCH41afRlr0aBfQUseeroWJLfp15jUVKVkwDIHL
	 jX+1etkZtEv+as/gyKqUV7GBBBI32zC1taPmnnIeSY+m3mi8QvMDuZjRi+VXlGO/xXqUM
	 l674a3fBrqvXpGC1xYcvBTYifOcMt18BqHSUACF/HdzsvX0gpY2k5X2cQLAPY80qbHrJr
	 Q/NAYoPZgg589sVVXKBXVlU4tUbsidN03OTpf/itLT5eZ2qjggP7PoiliKdaDvYzc0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092216;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=bUwFovR37/0YXm0NK1fQDRB+635h59wnlNOapHrj0Dg=;
	b=cDPJKYitT8tYGL7T2b0bWhowQkvcHKDK3r5/ebOSV1jpt6ozlEmwI6aTqJmf9Bl/mcjl
	 vjLvjz02zmY0SD14ZycLWqc5VVJwo8OwdUqnQqEi3lsauHigCGz+/mWDRUD8Maf6wUwpK
	 ax6g9fSS2On/7vfOZT4JkS2ZUxdWhm/DE386+jXOMG8DBxAhamqYOmJJn8Fw5JLPH1dYp
	 nMpBKpLpWzb9Ve/gu1iir+0z2kVI98tscsK29ViEV3jUJQuZcFP3Ox4NjD+IbvFqCAYBh
	 /3884ThAGfrQURkozOiziz45x8MokXoBwJ7zDPzCFxSEEtGgg2Y43EV+/go8FmSx2VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=YfTKfOk9;
	arc=none smtp.remote-ip=220.197.31.7
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CEE606A31E
	for <bridge@lists.linux.dev>; Tue, 27 Oct 2026 09:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21CEE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=YfTKfOk9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=bUwFovR37/0YXm0NK1fQDRB+635h59wnlNOapHrj0Dg=;
	b=YfTKfOk9H1wlZk+Ube5R3QSQC2eoaOSZlZRKt1oN9BTxEISJxoCW4UIa0LJM7p
	Os+woGcubcvXuH8yc1ZCgjPRbNhQFC7QVz2qhQwFHWghc2JM4fYyJ/dOPFGhPrGS
	X0oJEYIqvc1qiAnJZj67YLiXLljMPeMK3nlxahbzpxRHI=
Message-ID: <6b1d38f9-458e-47a0-a593-e47a219ff13e@126.com>
Date: Tue, 27 Oct 2026 17:08:50 +0800
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: netlink: do not clear the vlan info dump
 error
To: netdev-bot+sinfo@kernel.org
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20261027085200.1501599-1-xiaolinkui@126.com>
 <179309134717.3327.17438354236814047357@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <179309134717.3327.17438354236814047357@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3XywiauBqENglCA--.65308S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFykCry5Xw4UGryUWr17ZFb_yoW8CF1xp3
	98KanxJan5JF1Skr1vvw40va4Fk393Ga1UXr1UKr1jv3Z8GFy7tr42gr4jka4DuFWrA34F
	gw4qgr1DAryqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtpnQUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqAR2TWrgaiRJnwAA3F

Hi,

Thanks for the notice. Please find the missing information below.

On 2026/10/27 16:55, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

How the issue was discovered: Found during Sashiko AI review of the 
bridge netlink code. The review identified that 
br_fill_vlan_tunnel_info() could overwrite a previous -EMSGSIZE error 
from br_fill_ifvlaninfo*() when the port has no VLAN-to-tunnel mapping. 
The relevant review comment is already referenced in the commit message 
via the Link: tag.

Whether the issue was actually triggered: Not triggered at runtime. This 
is a theoretical error-path issue found by code inspection/AI review, 
not by syzbot, a static analysis tool scan, or a production report. No 
stack trace or error message was observed, and no test case was written 
to reproduce it.

Testing: The change was compile-tested only. No hardware or runtime test 
was performed, as reproducing the exact -EMSGSIZE + no-tunnel-mapping 
combination requires a specific skb size boundary that was not constructed.

If a v2 is needed for other review reasons, I will include this 
information in the commit messages.

Thanks,
Linkui Xiao

