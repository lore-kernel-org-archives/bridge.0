Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B463D330C
	for <bridge@lists.linux.dev>; Mon, 20 Jul 2026 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539872; cv=none; b=jiQ5b4zpgec6SpgiRz8HiZoxBQBBNMti9QecQRQziYhlNl75U2/IU33JxbcAo4gr7/bM5DnUE0jbkbz/pzGHERskQsOEsskEMlBiTOD3uhN04TM39X9j9IwaV8pupNaoC26kD2u0E441Zfx76Iboz4Ajp48doiHYbYaF39mIhBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539872; c=relaxed/simple;
	bh=BxnKu8vNtsYLiK5ravYlLTKTjAKTsC6um00fkLnSK3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0IxZSZ8zn1pV+TJU3c7u56z6lHAnSaRsgT58547Sk/Z5enFq/xzPZ9GcLBXVxZtIEptnwQHo/G2b7qqiM43uXETGxOBZtQQEFIAkScPkEeLbBJAR3Jx6H1CKuYwLrocYo2NvwaK+V6Ndys0VLY8GLsuweITQPCMzlUDbj5Fm4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=gcO3T73M; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="gcO3T73M"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49548e01d02so12461845e9.0
        for <bridge@lists.linux.dev>; Mon, 20 Jul 2026 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784539869; x=1785144669; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pW1JswRc46/DemocbXNde6KLd1ZN2Gsh0169WW0rnNE=;
        b=gcO3T73MIlXoACFgllYotkzE9oM/xiw0wV2kNf1Sv5GDvb7IC/c7vCHyNyJzgeBYDw
         MGoVoYAB6scxjPTEkZwZKLpGYoFd4XN8jEEaSzdqR+i16II7Aj5Ha0zf+mjeEeCg8b9O
         cg1hJ7w18Z1A3br08UjUOCko80aR0I1QZKjGm3d5gLHmUe52rZ2i+hSKgypOMEL+qaYV
         u0Ytep5/UItXjcOOyLfU8r3dzspqdaMpjIdl4AKCOcZPOgaihcgWjwRjcaOsySQuPXKa
         viUXrAl4o8Z557O+gAf9LuE0KBenTdVI+QALqInw5158zhYf+EwjQgFvCogsXesZz6Tg
         HsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539869; x=1785144669;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pW1JswRc46/DemocbXNde6KLd1ZN2Gsh0169WW0rnNE=;
        b=hczBpoFQl8foPDKbP7cD5LPQR6hr4ojDAm/htwg8hahcV/qLawLlBh2y1NZ8Y8EqcG
         MoxjODS97zSebLpiRExbPHKKRCOTAQOrcC7JAO8KwNSWoPjqjNGWtBmKC1PnLkDjKkVN
         aXXIeI8z8pYmztWpA1LvociUjXpr9leqBZtn30XChyrARbjz1V+h3MDJ+DCBBSjPid0Q
         0IudSQRUWnUQPr4RHKInzmWAW9bRJl4YAy8kKGP/O0wCKb8EalQ8y7PXjwmp7C8thpKI
         9RXG6YCdtEypPhprV4jYjnzHN8kTwydT3j4YizUGSkKQe6f/33/h8WetofEx15qNyydA
         rcog==
X-Forwarded-Encrypted: i=1; AHgh+RqVht3cBhquaNjXe16Q1woF1+RnVhP4dVDxEAUhPvfxdk1a7fx/hqZYBqNdHpIX6S3DOd0bPVQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1w/HEx4qLX3SNh51i78UZwOWYgwQdiMt67cZDhg5Rcpt0QxnC
	Jv7A6bLIDmBHQSC/W8VKVF5Zs+EMzSsQL5/RGN7YRi7lWaIhkLigbkzPmvz+wOLWAkA=
X-Gm-Gg: AfdE7clMh0METP5u0H17ZwKp9piphQxeDRtS0WwLYaQtqh9LuXcaWhCZNj7InWSdrAi
	1a3UL2xmFETigUiPM3zJoH0vEZoeoGds2s/1CW/Kgvs9mFAD7Mpi8D6FiHymoMV670bZh21auGn
	3v3uf30/bMt1qICBlu+U0dk9F8g1oz/BHijL/QvcDTjxw4AlzIP5xYnmMudKHVY6pVlqzCyQsh2
	FgxHGw/Sf3VVpzOrBZ683o0O3VcprhXIfnQhCtLIhbiGi6vas/P9Ufvd2tl3uIaV+pzhIkk/nWk
	HnQYtDTrdiLvM6y22iMcIw4kxC73ynhnq/maPnn13gZQsEw0Ms6Fmo79NnoAZRderIMMzGgIfhD
	AH+6CbiwZ7cw7uh5hA4mb+lh+c+Wbw9gdDs94T9darqgC565o3V4Ep7uFPdEsJkke9IpfwC429T
	LqTdbAko+kRXfEFSM0SEnmdP9QQaSmgh7k
X-Received: by 2002:a05:600c:45d5:b0:495:4056:9473 with SMTP id 5b1f17b1804b1-4954a40d0c3mr144465725e9.28.1784539868617;
        Mon, 20 Jul 2026 02:31:08 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edda2sm252362295e9.13.2026.07.20.02.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 02:31:08 -0700 (PDT)
Message-ID: <ad48b1da-50bd-4b79-943a-0a3331191b7c@blackwall.org>
Date: Mon, 20 Jul 2026 12:31:07 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] bridge: Validate and clean up IPv6 neighbour
 suppression
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ja@ssi.bg, petrm@nvidia.com, fw@strlen.de, kuniyu@google.com,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1784463131.git.danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <cover.1784463131.git.danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2026 16:34, Danielle Ratson wrote:
> The bridge implements IPv6 neighbour suppression by snooping Neighbour
> Solicitation and Neighbour Advertisement messages, but it previously only
> checked the ICMPv6 type and code before acting on them. This leaves it
> open to acting on malformed or spoofed packets that any RFC 4861 compliant
> node should reject, and the option parsing in br_nd_send() open-codes a
> loop that has historically been a source of bugs.
> 
> This series hardens and cleans up that path:
> 
> Add ndisc_check_ns_na(), a standalone NS/NA validator modeled after
> ipv6_mc_check_mld(), implementing the RFC 4861 section 7.1.1 / 7.1.2
> mandatory receive checks (hop limit, checksum, code, length, target and
> option validation). Wire the bridge into it so NS/NA messages are
> validated to the same standard MLD already enjoys.
> 
> Replace the manual ND option parsing loop in br_nd_send() with
> ndisc_parse_options() and ndisc_opt_addr_data(), and linearize the skb
> once it has been validated as an NS/NA message so that this and any future
> ND message handling operate on a linear buffer. The first patch is a small
> preparatory cleanup that drops the now-unnecessary skb_header_pointer()
> fallback from br_is_nd_neigh_msg().
> 
> No functional change is intended for well-formed packets.
> 
> Patchset overview:
> Patch #1: drop the skb_header_pointer() fallback.
> Patches #2-#3: add ndisc_check_ns_na() and validate NS/NA with it.
> Patch #4: linearize once the ND message type is validated.
> Patch #5: parse options via ndisc_parse_options().
> 
> Danielle Ratson (5):
>    bridge: Use direct pointer in br_is_nd_neigh_msg()
>    ipv6: ndisc: Add ndisc_check_ns_na() validation helper
>    bridge: Validate NS/NA messages using ndisc_check_ns_na()
>    bridge: Linearize skb once the ND message type is validated
>    bridge: Use ndisc_parse_options() to parse ND options in br_nd_send()
> 
>   include/net/ndisc.h          |   2 +
>   net/bridge/br_arp_nd_proxy.c |  54 +++++-----
>   net/bridge/br_device.c       |   4 +-
>   net/bridge/br_input.c        |   4 +-
>   net/bridge/br_private.h      |   2 +-
>   net/ipv6/Makefile            |   2 +-
>   net/ipv6/ndisc.c             |   1 +
>   net/ipv6/ndisc_snoop.c       | 190 +++++++++++++++++++++++++++++++++++
>   8 files changed, 224 insertions(+), 35 deletions(-)
>   create mode 100644 net/ipv6/ndisc_snoop.c
> 

Nice set, but I'm curious - any reason not to use EXPORT_SYMBOL_GPL() instead?

Cheers,
  Nik

