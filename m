Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6305D1E0DE5
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255649; cv=none; b=sf26YPBhxZqgdRC1LM5yMaG+GRxp8WulBBgjZkWW048zYB1u0iOPEIXS8wCMok4ck408Y18cK66FTp726Zqxd59NanKVcqQ0Pcm7vyM+5N/N9fQJZGB9meqhKLetDmtRtjrJn5yrgCBy/mva7y/2GieTu133VpDzvwbHpVmDOVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255649; c=relaxed/simple;
	bh=dEXv7Cj+BC57a/C4F+5/2Rm0FhmxI6RRXkVRjhyCXkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+InHA7ia1noUitcidRoVrwHNQ8yWdfduTxkyjcSqSI8XVnlrMjXbjPKP3hkYsfPhVhNvKkh2HRIWK1062SJf0siimvunSXmY0o+FDD5fHuCRgazfkepb9Q6nf/7rntiV7ZL2mr53yCMQ3vfQN6hlvDYllV1LKcEZ5Y/64MxWEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsUDUino; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsUDUino"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso23126422a12.0
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 05:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736255646; x=1736860446; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TaKbNQkeyDwSjQGIQ+m5SGuLh75ZMMIa7nlAuxNwI4s=;
        b=LsUDUino5yzPBEvnqZ1fxi3aknI9uelJ243xcNH3wq/w5GtbQxiIR4yloV1JqvcR4E
         ex9AoFMs0yHj6G35gEY/1OkiI3YIbABj1AoMAt80ryBv7eCHDsVOcs970SWCfU04MPmw
         0elNh5H8xcYWXovuJ8ZZoM5ho4BbyfcsrEYmMxDG+vsfdFPQNKclP9x+Voi0UgBQLGuu
         3d5xo2maghpqtJ2+0zgNpEuxWv7qpzW+W6gF/ePTg702TuhMWMzI+eR87D1ixpD7Azf3
         ldODUpAIYNGNoUZXFV7noVeTiDMi8jRBbsgiqoienWOnOUFRtSQyPZUtoZDJodqLOw5X
         76cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736255646; x=1736860446;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TaKbNQkeyDwSjQGIQ+m5SGuLh75ZMMIa7nlAuxNwI4s=;
        b=rQCra5Gc+e4B82a5s5hhsQ1tHWhvROyDcmiMeXeU05v9eRzNEicjUd0f6rgiKUxbkd
         leckRkhmazSY35Ny8q+YguFcXfqZyX7SLMczpE0gp29vb07R1MH46JUdI4uGMg70L7FF
         dHqZrGsY4H9dGmgubpdiPmBTJDhjqTAK3hRIPLwzISiSjw4k/xpZaC/KXZ4MGlk0UMLH
         JJcEg0/c30HGajcuWCWzi3/l4uSO+3J2qikdWKbin9gBsen25183zavRIJsjBSVjbGRP
         8IlRq0kXZQBqOpdz00sJxXCPCXsAIrca7KjCIHcSP4gh7L30/SsAWAuwLcQcuzkoMjut
         W7Iw==
X-Forwarded-Encrypted: i=1; AJvYcCW6Di38wQqCWKqe1J9xIsUXRQbZQ6CsP0niVelmiGPIPPUGpto3tilRMLOChYCWYThJip3vyLU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz74EvHE74Mi+9Xe4snQswoNMnw5KinQ3pzKkeE8xRtwJInn8Ng
	LPc7yyWhOargc3RgbCmmfdQLqXvgRnwWI1CELs4IM37s3w1ztQ36
X-Gm-Gg: ASbGncv+WMrBer0KruQIz71kFMfNXT2+YEQzlqtDuEnnGmK68zArf5uQIHZuOFb6syj
	ExJzT0gKpzexYKf+b8tvf3H6J1saXtF4/Fi8ficP1U8iaNz0T8SiwFjOre7vjgfypRINob/CX7s
	bAyHPMHsTRypxJsIr7DfRySJQn+6+HXb8VUBktkMABK9IqkKo66O4aIJdhqUPikDHb3WtCV7s3P
	zyiot5vHINIKaj9JLpUH+6/21A8TwJ+VYBnJBMN1E4aWlA3P9A3/OAVyBm7MUPWIv+30lcxr7cV
	hFA1IetShFBb+LNnKnuxZWDFbW4c+73d8u1vvJBmtHC6bP64BbZYjWhfqfet0dfUku86aJ3h9i0
	j8BX/B6bWjGsL/nMvigcd6QCbneFnXS8=
X-Google-Smtp-Source: AGHT+IG685u/TuxRo4gOyPFhExD9aC7tMDskOonBEuq2S9e6D8OwVVwO7wNmsSRZ+5auRMu6yPKriA==
X-Received: by 2002:a05:6402:35c2:b0:5d0:ea4f:972f with SMTP id 4fb4d7f45d1cf-5d81dd9af30mr134224547a12.8.1736255645405;
        Tue, 07 Jan 2025 05:14:05 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f015b1asm2383448366b.148.2025.01.07.05.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 05:14:05 -0800 (PST)
Message-ID: <4b9b2a9a-061b-43ad-b402-a49aee317f41@gmail.com>
Date: Tue, 7 Jan 2025 14:14:03 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: phylink: always config mac for
 (delayed) phy
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250107123615.161095-1-ericwouds@gmail.com>
 <Z30iUj6DE9-fRp0n@shell.armlinux.org.uk>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <Z30iUj6DE9-fRp0n@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/7/25 1:47 PM, Russell King (Oracle) wrote:
> Going through the log...
> 
> On Tue, Jan 07, 2025 at 01:36:15PM +0100, Eric Woudstra wrote:
>> Log before this patch is applied:
>> [root@bpir3 ~]# dmesg | grep eth1
>> [    2.515179] mtk_soc_eth 15100000.ethernet eth1: mediatek frame engine at 0xffff800082380000, irq 123
>> [   38.271431] mtk_soc_eth 15100000.ethernet eth1: configuring for inband/2500base-x link mode
>> [   38.279828] mtk_soc_eth 15100000.ethernet eth1: major config, requested inband/2500base-x
>> [   38.288009] mtk_soc_eth 15100000.ethernet eth1: interface 2500base-x inband modes: pcs=01 phy=00
>> [   38.296800] mtk_soc_eth 15100000.ethernet eth1: major config, active inband/inband,an-disabled/2500base-x
> 
> This is indeed without the PHY. We're using inband, although the PCS
> mode is PHYLINK_PCS_NEG_INBAND_DISABLED, meaning inband won't be
> used. As there is no PHY, we can't switch to MLO_AN_PHY.
> 
>> [   38.306362] mtk_soc_eth 15100000.ethernet eth1: phylink_mac_config: mode=inband/2500base-x/none adv=00,00000000,00008000,0000e240 pause=04
>> [   39.220149] mtk_soc_eth 15100000.ethernet eth1:  interface 2 (mii) rate match none supports 0-3,6-7,13-14
>> [   39.229758] mtk_soc_eth 15100000.ethernet eth1:  interface 3 (gmii) rate match none supports 0-3,5-7,13-14
>> [   39.239420] mtk_soc_eth 15100000.ethernet eth1:  interface 4 (sgmii) rate match none supports 0-3,5-7,13-14
>> [   39.249173] mtk_soc_eth 15100000.ethernet eth1:  interface 22 (1000base-x) rate match none supports 5-7,13-14
>> [   39.259080] mtk_soc_eth 15100000.ethernet eth1:  interface 23 (2500base-x) rate match none supports 6-7,13-14,47
>> [   39.594676] mtk_soc_eth 15100000.ethernet eth1: PHY i2c:sfp-1:11 uses interfaces 4,23, validating 4,23
> 
> The PHY comes along...
> 
>> [   39.603992] mtk_soc_eth 15100000.ethernet eth1:  interface 4 (sgmii) rate match none supports 0-3,5-7,13-14
>> [   39.650080] mtk_soc_eth 15100000.ethernet eth1:  interface 23 (2500base-x) rate match none supports 6-7,13-14,47
>> [   39.660266] mtk_soc_eth 15100000.ethernet eth1: PHY [i2c:sfp-1:11] driver [RTL8221B-VB-CG 2.5Gbps PHY (C45)] (irq=POLL)
>> [   39.671037] mtk_soc_eth 15100000.ethernet eth1: phy: 2500base-x setting supported 00,00000000,00008000,000060ef advertising 00,00000000,00008000,000060ef
>> [   39.684761] mtk_soc_eth 15100000.ethernet eth1: requesting link mode inband/2500base-x with support 00,00000000,00008000,000060ef
> 
> We decide to use MLO_AN_INBAND and 2500base-X, which we're already using.
> 
>> [   40.380076] mtk_soc_eth 15100000.ethernet eth1: phy link down 2500base-x/Unknown/Unknown/none/off
>> [   40.397090] brlan: port 5(eth1) entered blocking state
>> [   40.402223] brlan: port 5(eth1) entered disabled state
>> [   40.407437] mtk_soc_eth 15100000.ethernet eth1: entered allmulticast mode
>> [   40.414400] mtk_soc_eth 15100000.ethernet eth1: entered promiscuous mode
>> [   44.500077] mtk_soc_eth 15100000.ethernet eth1: phy link up 2500base-x/2.5Gbps/Full/none/off
>> [   44.508528] mtk_soc_eth 15100000.ethernet eth1: No phy led trigger registered for speed(2500)
> 
> ... but we don't see link-up reported by the PCS after the PHY comes
> up. Why is that - I think that needs investigation before we proceed
> to patch the issue, because that suggests the PCS isn't seeing
> valid 2500base-X from the PHY.
> 

I think it is because pl->act_link_an_mode stays at MLO_AN_INBAND, but
it needs to be set to MLO_AN_PHY, so that only the phy determines the
link state:

phylink_resolve() {
    ...
	} else if (pl->act_link_an_mode == MLO_AN_PHY) {
		link_state = pl->phy_state;
    ...
}

