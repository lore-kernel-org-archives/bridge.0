Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98891C6FF8
	for <bridge@lists.linux.dev>; Thu,  6 Feb 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851725; cv=none; b=ZBKIP1WbKTEPIfNwDqCRqbDat2o5QvXPFvrjGSgUXQXrNkFVmsf2U16ORJqSdpBPvAKJojfTYuTvXfnvMPVrSQJzUG/cLNyv7Iw9WOAW6lTW8zOK2faO+vbhkElFX519HXr9QX75ptAbmLLv4gXpwhpdCjeAPh7jCKSkDHwiBlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851725; c=relaxed/simple;
	bh=Qaii/4wx+f4RmmjpA6Oq2TvM5/xDsmQW0adSKnoxq2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsHGLkT6r0huumcHKFp21Rtg9ThI0c20iH9fzl8+Zf74s0LGWhsw+aB2U9EhhDoxta5s4n6YSHDdT+RqTKVMPw7KiwcQGE2zDVa+b2G6mam0uvUxXmX0vtRau41qOT9r0PL+1svnWW8MYVaAgX9AeGo61NceO90B2pXym9Q2vYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=KuIKMg4r; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="KuIKMg4r"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dc75f98188so1789394a12.2
        for <bridge@lists.linux.dev>; Thu, 06 Feb 2025 06:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738851722; x=1739456522; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AtE/V7UyaqCUm/jEvMcWRgFAvov74MHFiHvUqv3+ay4=;
        b=KuIKMg4rap/EpKjuYyXZwh8/mTg2PipdfsWMMuiSxTNySFYLeyoqG4794OM5LffqHi
         7wZuxMK2S+ELt9OSlVgVZF4+K0smq1G+PVza/X9hnB4D8WsEEU6sJml4s3jlMmIGax6B
         FWZQ3ZbQA1FNgHHyOt3P83i5vqSDT2INSdsuHsiJTFauzPBK71+7kQifRIrFsRSEmnGH
         QGjQGzwxFHMgDnfHbT+iixdtAbMo6BtNkhU2wgfnpTwE/ThQZs7EXrfY3CUrDDvhaUQm
         Ks7TxJ7945odc1zUyVqwbss2qkdH6Nc/yoZR6JrfjMNB9JEgiJaqbNJAxKpXK1J/a1D4
         GimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738851722; x=1739456522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtE/V7UyaqCUm/jEvMcWRgFAvov74MHFiHvUqv3+ay4=;
        b=XQzFgkUf7LhP6zc3Qf9BrnitKSRAeY1kKtPYAmy8on+Ml/zLuIr7yiLhE+O0qQ7g2F
         rjLjqBlq7t7VW2EgFi7+ukbXaEXewq6c1rEsBkwJefWoCdI2Hg+dlGzLHi5Qd9hJE/ie
         CFpL1gXDrvBdO2xl+15U23NkJUdLQyQgKSmieK3LuD9xqk04K9wQxeiZ2w5Vl+bshMeW
         ImFRSkj6k+V/BDhdq4h0l5WMbEVbfrY17os0AeNMQTmQ6HUvFk0V6Gq50YEUWgxl51hZ
         IrE/Y4CeyJdUHf0Qwpfgapmldou+ZP4VGhRjWjsayMCDR4Jcyw4QZeW6g3V4Avs2VsSO
         8mJA==
X-Forwarded-Encrypted: i=1; AJvYcCXmdSC3DBELyoSRI1ZnBon+UvwhmeUd068/YZAaYbZIfdqrGmWfHJ7V4sV476EDGb9H9DmPnCU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5L68gQaL1yr0XSi4RWa73FLxlxicO8JxbrTvR9yPLLqsVSQ8i
	wdpEoDi2JuGUBmPMPgrVotFlMyzwKyW9BnLBelsuPUx99brHa//3dTQkz6Sy0yY=
X-Gm-Gg: ASbGncucvj+vMHZCX/h4CKulLd/lMCn8PqWwn37FUdKyJfjZ7Q9yzZXLdz/SyDenlBy
	ibtsQb9Dh6yFF6pw1ky0kk79sfE4Y0wruYlA25iF1rIq7vrWBeoRqiFM1cKt/EqrDIrtg4/rYIW
	MRueRZTf13YEs083Sx66XUALhlmN2LrEcwRgYr/Ivw71PngXki8qDXfa5tbhfCtZqDAqJ77XghP
	Ii92lbXcndGp0CTv3CidCTaPiqEfTXhnOcGI76Du9v+CbChoA0DwRVhSplsshTSWDQl1QA9Dunf
	dteBJsaNb2UjoJWdg6K/ZYyQb1RymTNE0qh8SKtk0vVSNQ4=
X-Google-Smtp-Source: AGHT+IEe7WdSsNkjgnty/HyvHskjlhljY6wt44W4IMiUaDBB3MI2H2nfwFKZUIVfpj7A/eSHa7SXrA==
X-Received: by 2002:a05:6402:4486:b0:5db:f423:19b9 with SMTP id 4fb4d7f45d1cf-5dcdb72958cmr8121194a12.16.1738851721184;
        Thu, 06 Feb 2025 06:22:01 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b85a3fsm941354a12.46.2025.02.06.06.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:22:00 -0800 (PST)
Message-ID: <cd2926cf-b32b-4de7-851e-97a3ce2118af@blackwall.org>
Date: Thu, 6 Feb 2025 16:21:58 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 12/14] bridge: No DEV_PATH_BR_VLAN_UNTAG_HW
 for dsa foreign
To: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250204194921.46692-1-ericwouds@gmail.com>
 <20250204194921.46692-13-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-13-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> In network setup as below:
> 
>              fastpath bypass
>  .----------------------------------------.
> /                                          \
> |                        IP - forwarding    |
> |                       /                \  v
> |                      /                  wan ...
> |                     /
> |                     |
> |                     |
> |                   brlan.1
> |                     |
> |    +-------------------------------+
> |    |           vlan 1              |
> |    |                               |
> |    |     brlan (vlan-filtering)    |
> |    |               +---------------+
> |    |               |  DSA-SWITCH   |
> |    |    vlan 1     |               |
> |    |      to       |               |
> |    |   untagged    1     vlan 1    |
> |    +---------------+---------------+
> .         /                   \
>  ----->wlan1                 lan0
>        .                       .
>        .                       ^
>        ^                     vlan 1 tagged packets
>      untagged packets
> 
> br_vlan_fill_forward_path_mode() sets DEV_PATH_BR_VLAN_UNTAG_HW when
> filling in from brlan.1 towards wlan1. But it should be set to
> DEV_PATH_BR_VLAN_UNTAG in this case. Using BR_VLFLAG_ADDED_BY_SWITCHDEV
> is not correct. The dsa switchdev adds it as a foreign port.
> 
> The same problem for all foreignly added dsa vlans on the bridge.
> 
> First add the vlan, trying only native devices.
> If this fails, we know this may be a vlan from a foreign device.
> 
> Use BR_VLFLAG_TAGGING_BY_SWITCHDEV to make sure DEV_PATH_BR_VLAN_UNTAG_HW
> is set only when there if no foreign device involved.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  include/net/switchdev.h   |  1 +
>  net/bridge/br_private.h   | 10 ++++++++++
>  net/bridge/br_switchdev.c | 15 +++++++++++++++
>  net/bridge/br_vlan.c      |  7 ++++++-
>  net/switchdev/switchdev.c |  2 +-
>  5 files changed, 33 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

