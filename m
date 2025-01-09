Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D642F2D
	for <bridge@lists.linux.dev>; Thu,  9 Jan 2025 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412984; cv=none; b=R4jlvkkJKR8ptfZMsaUdQcAvcNdDxKKLJBWxHkSWM2EltbDoKcU9vkWvLZUcZTunwxUSZVFZMPAOGqHTjMQA+X4sO2ioeTxrNPT/o3xM1AejVuZD6mLjEu3FIU/oV5OP1Qe/llCzVbukp6P71l0+Awerlgvp/mgCPWL+CFKKMII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412984; c=relaxed/simple;
	bh=wp2CVqXaTLMEhu/P0gxP9vMepAcXofaZ9f1o56WSI8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWTUiwh0wOk/yNo14JL3YFwMP88B1dt8/b2Q/4hQPtOCAXHOr38gsV24xZ5C0xgLNoQFlFaNX5+kSTH4vS/kZqcEAo92i37H8NmKgR0OihQdn9ifs3xQ3mH4W6Felm6gs357PhTFmhysJxpbD8D6+hGHpBqs55yuPT24NPEMTzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6Ju6Ead; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6Ju6Ead"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so97878666b.2
        for <bridge@lists.linux.dev>; Thu, 09 Jan 2025 00:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736412981; x=1737017781; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XS6TlRWyTSRfC4D8CM7324D8iXz+6nRl08PCaLYh1SA=;
        b=O6Ju6EadED4/oozR472zaznzUa0vzDH3P458gEj9Bz7VmR7ZsI7uHoWsFebELHHu/d
         tYErvfK+W6flqXaoLj33nE6hsidR706ytTJ0ohFBPBU5Tk/tHS1X/AcHgKWY979HJki8
         nG8FemQVWP7vdSO4Cnc7DMrDpQjNZ7khZPFVmvWtNuNL7cOMRhjdQEX7nT44ZALTCr3D
         /b1Ki2rwPs0nos6YgK2rg/R9JxNbUbuqBrhTj55bf1RuvQF8cHmKXqDPlgY1MgujrgOI
         3I5llR4sqx1GAPXuiamiCcgrHYpDXtv+Ax8rbkTjREI6s995sb2Zrn1kyiLJHRzlwIjA
         zWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736412981; x=1737017781;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XS6TlRWyTSRfC4D8CM7324D8iXz+6nRl08PCaLYh1SA=;
        b=lwT26licVF3gQvZe65zPSlvnJ4AGrn3WRUrgIsKtZIZ1/kn1B67OsiLNvVnhAPkvGt
         DpdDNzjy9ajT8D1AuRIrbjhFRHUfe5OtXw0mx481doB7NYwkxOxjttB9PGveQ3hErkVG
         Ohoxl9Fntwx+tsyz9IHw/JeOm2F877jJx4OjlhiCVrjNtG8HKOsztBQirzu0ZPNPOtDp
         U9o4+uVy9ecqBqqJB43m7yhth6DuqUeK//Db9q5mpfhtGrpBHXZTA+iJl0LUevmJ5MSc
         QB8yVbSqqUhSAUDR+67Po2MG2BvnJgxbcPqn41hxHpGsGTql82o7CSHCwj35axqI5bul
         OcBg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2tTCJDooesdyGF7IzfBNVUm9pVHYiokawFNVe16plKlp2orpAP2yjx4asvzxWDHFiw0ciys=@lists.linux.dev
X-Gm-Message-State: AOJu0YxsPvDWs0fyGG5tVTBr/AZXKoy72CJUdz2fZnj+91FzlSc2RbGf
	tnnQEd0ZBVvvWvfFISj9hTSFPimZVIZ50rxignOyMC0tyb0mn9u9
X-Gm-Gg: ASbGncvl2GBgvalTyINm4Xu7cjx3R56r895/iZA4u5QA5d6ZgGAvA+thFfSLtRQJPnZ
	79v+BIVIEIITouixCt/aTCUkFM0cIHmmIf9D2ecAdaZbDjt/vLbvNBKeQSdFXQC4ig5tT684Uk5
	aHKq5GkBzoyjop1Xexmvb2zDZ3LRbzvXatov/SZKxPOzeMkxrz3vJz0GkydQzefEV+BUNaZLgRX
	lBj1qH/dgNiW3yHnhccOAXB3pqRN4Zh9GXMlRixSJBQbp7nhFfn6SUFvmr5ihQ+VeT/5FXPKWYD
	/661ZN5+YNkNZ8vvVpUTEFDLFdYHl+jwg2JsCbIz6smFcXX8sLj1tlxbdyGsCMIEkrXL5m6cLef
	dx0fFr5/TysG8wvAfkqk2c6KTuGfLpCg=
X-Google-Smtp-Source: AGHT+IH3My3UUh3xFM8ZgIgF0aWMNmsqTttAtJxwpSIcvfI0XILfisWjLOFCeDXh+SXgbl3J8Hxz3A==
X-Received: by 2002:a17:907:3e24:b0:aac:2298:8960 with SMTP id a640c23a62f3a-ab2ab6fcf7amr446231766b.35.1736412980929;
        Thu, 09 Jan 2025 00:56:20 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9060a4fsm50179466b.15.2025.01.09.00.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 00:56:20 -0800 (PST)
Message-ID: <98234080-946e-4b36-832f-113b185e7bca@gmail.com>
Date: Thu, 9 Jan 2025 09:56:17 +0100
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
 <4b9b2a9a-061b-43ad-b402-a49aee317f41@gmail.com>
 <Z31CJS1YUvPGiEXs@shell.armlinux.org.uk>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <Z31CJS1YUvPGiEXs@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/7/25 4:03 PM, Russell King (Oracle) wrote:
> On Tue, Jan 07, 2025 at 02:14:03PM +0100, Eric Woudstra wrote:
>>
>>
>> On 1/7/25 1:47 PM, Russell King (Oracle) wrote:
>>> Going through the log...
>>>
>>> On Tue, Jan 07, 2025 at 01:36:15PM +0100, Eric Woudstra wrote:
>>>> Log before this patch is applied:
>>>> [root@bpir3 ~]# dmesg | grep eth1
>>>> [    2.515179] mtk_soc_eth 15100000.ethernet eth1: mediatek frame engine at 0xffff800082380000, irq 123
>>>> [   38.271431] mtk_soc_eth 15100000.ethernet eth1: configuring for inband/2500base-x link mode
>>>> [   38.279828] mtk_soc_eth 15100000.ethernet eth1: major config, requested inband/2500base-x
>>>> [   38.288009] mtk_soc_eth 15100000.ethernet eth1: interface 2500base-x inband modes: pcs=01 phy=00
>>>> [   38.296800] mtk_soc_eth 15100000.ethernet eth1: major config, active inband/inband,an-disabled/2500base-x
>>>
>>> This is indeed without the PHY. We're using inband, although the PCS
>>> mode is PHYLINK_PCS_NEG_INBAND_DISABLED, meaning inband won't be
>>> used. As there is no PHY, we can't switch to MLO_AN_PHY.
>>>
>>>> [   38.306362] mtk_soc_eth 15100000.ethernet eth1: phylink_mac_config: mode=inband/2500base-x/none adv=00,00000000,00008000,0000e240 pause=04
>>>> [   39.220149] mtk_soc_eth 15100000.ethernet eth1:  interface 2 (mii) rate match none supports 0-3,6-7,13-14
>>>> [   39.229758] mtk_soc_eth 15100000.ethernet eth1:  interface 3 (gmii) rate match none supports 0-3,5-7,13-14
>>>> [   39.239420] mtk_soc_eth 15100000.ethernet eth1:  interface 4 (sgmii) rate match none supports 0-3,5-7,13-14
>>>> [   39.249173] mtk_soc_eth 15100000.ethernet eth1:  interface 22 (1000base-x) rate match none supports 5-7,13-14
>>>> [   39.259080] mtk_soc_eth 15100000.ethernet eth1:  interface 23 (2500base-x) rate match none supports 6-7,13-14,47
>>>> [   39.594676] mtk_soc_eth 15100000.ethernet eth1: PHY i2c:sfp-1:11 uses interfaces 4,23, validating 4,23
>>>
>>> The PHY comes along...
>>>
>>>> [   39.603992] mtk_soc_eth 15100000.ethernet eth1:  interface 4 (sgmii) rate match none supports 0-3,5-7,13-14
>>>> [   39.650080] mtk_soc_eth 15100000.ethernet eth1:  interface 23 (2500base-x) rate match none supports 6-7,13-14,47
>>>> [   39.660266] mtk_soc_eth 15100000.ethernet eth1: PHY [i2c:sfp-1:11] driver [RTL8221B-VB-CG 2.5Gbps PHY (C45)] (irq=POLL)
>>>> [   39.671037] mtk_soc_eth 15100000.ethernet eth1: phy: 2500base-x setting supported 00,00000000,00008000,000060ef advertising 00,00000000,00008000,000060ef
>>>> [   39.684761] mtk_soc_eth 15100000.ethernet eth1: requesting link mode inband/2500base-x with support 00,00000000,00008000,000060ef
>>>
>>> We decide to use MLO_AN_INBAND and 2500base-X, which we're already using.
>>>
>>>> [   40.380076] mtk_soc_eth 15100000.ethernet eth1: phy link down 2500base-x/Unknown/Unknown/none/off
>>>> [   40.397090] brlan: port 5(eth1) entered blocking state
>>>> [   40.402223] brlan: port 5(eth1) entered disabled state
>>>> [   40.407437] mtk_soc_eth 15100000.ethernet eth1: entered allmulticast mode
>>>> [   40.414400] mtk_soc_eth 15100000.ethernet eth1: entered promiscuous mode
>>>> [   44.500077] mtk_soc_eth 15100000.ethernet eth1: phy link up 2500base-x/2.5Gbps/Full/none/off
>>>> [   44.508528] mtk_soc_eth 15100000.ethernet eth1: No phy led trigger registered for speed(2500)
>>>
>>> ... but we don't see link-up reported by the PCS after the PHY comes
>>> up. Why is that - I think that needs investigation before we proceed
>>> to patch the issue, because that suggests the PCS isn't seeing
>>> valid 2500base-X from the PHY.
>>>
>>
>> I think it is because pl->act_link_an_mode stays at MLO_AN_INBAND, but
>> it needs to be set to MLO_AN_PHY, so that only the phy determines the
>> link state:
>>
>> phylink_resolve() {
>>     ...
>> 	} else if (pl->act_link_an_mode == MLO_AN_PHY) {
>> 		link_state = pl->phy_state;
>>     ...
>> }
> 
> Please see my reply to Daniel. The PCS should still be capable of
> reporting whether its link is up or down irrespective of whether
> in-band status is being used or not.
> 
> While it is correct that PHY mode needs to be used here, your report
> has pointed out that the driver is not reporting the PCS link state
> correctly when in-band is disabled.
> 
> Given that the current state of affairs has revealed this other bug,
> I would like that addressed first while there is a trivial test case
> here.
> 

So I've narrowed down the problem a bit:

At first state->link is set to true, while looking at the bmsr.

But because linkmode_test_bit(fd_bit, state->advertising) and
linkmode_test_bit(fd_bit, state->lp_advertising) are both false,
state->link is set to false after looking at the bmsr.

void phylink_mii_c22_pcs_decode_state(struct phylink_link_state *state,
				      u16 bmsr, u16 lpa)
{
	state->link = !!(bmsr & BMSR_LSTATUS);
	...
	case PHY_INTERFACE_MODE_2500BASEX:
		phylink_decode_c37_word(state, lpa, SPEED_2500);
	...
}

static void phylink_decode_c37_word(struct phylink_link_state *state,
				    uint16_t config_reg, int speed)
{
	...
	if (linkmode_test_bit(fd_bit, state->advertising) &&
	    linkmode_test_bit(fd_bit, state->lp_advertising)) {
		state->speed = speed;
		state->duplex = DUPLEX_FULL;
	} else {
		/* negotiation failure */
		state->link = false;
	}
	...
}

And I can confirm, if I change the part above into the part below
(removing the if statement), the PCS also reports the link is up and the
connection is functional end-to-end. Not that I'm saying this change is
the solution, only for narrowing down the problem.

static void phylink_decode_c37_word(struct phylink_link_state *state,
				    uint16_t config_reg, int speed)
{
	...
	state->speed = speed;
	state->duplex = DUPLEX_FULL;
	...
}

Also worth mentioning, up until v12 of the pcs-mtk-lynxy.c
mtk_pcs_lynxi_get_state() did not call
phylink_mii_c22_pcs_decode_state() at all for 2500base-x.

