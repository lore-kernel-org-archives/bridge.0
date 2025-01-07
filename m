Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C36A1EE03B
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259803; cv=none; b=JIvj3nlim3t0djwQK25kpC0+13MxUKyX/SiFVrQLup9medoVEMVDlEH3QvtrAjcJrXb+qo8I56ZHx6n1GeR/T8RSsRyq4sGCcwZNM41txfTtQVeHM37lhZmwnie9L8eHWiF8Ucc75OS941BUnekXcz9cywZuHiGRcUMrxXn6koY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259803; c=relaxed/simple;
	bh=Bm1DtQK3Zmv8psZJ+NOjFV66PEzHEkw6lMPzpKko7Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWBF/rwoqAcJnCU918w4XeG89fno6AK2PQUCWIQdoHbw2D7mTkefcJhx6ehsI8N+M/h2bRMJlahA9NMyefmI/p+uCgTUiFtULF6j6Yzz4Umyl61VjI2rio3i9di6mpb5mumup6FhgwEpcp1sB2KjxN3CZAZ1uiTkod1px1xB+2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8FawEFs; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8FawEFs"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso255124266b.2
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 06:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736259800; x=1736864600; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XE2LBycvBfRVASiRxD8GRnH5rQbRkw6izbBARG4PHOM=;
        b=l8FawEFs0be7xJHQaicPR1iiRtJQY1rTOi9FDeGOGH7MFnOm82Y3p0BIgG5KHjpooX
         p3DAlHdlMgxG/R8TOSGunodn6Q/4w3yZW0VNMZxpEKqsEEo/UsBoX+EDSnKvCHcf+3Q8
         fwzRIBTS3q1cdytFmdfHblj4ZJYNWjsSZMBC79Q4agnE6V5tPyUniqdJBpWbVYw7ilIp
         TxNPh0KlTPPvaB/W3+JSRSrG2M2COWtzrKyeF4piuV7KEYz6o22iiv0yn0ju/a8U+YC1
         f9TXJ3SDLC4xvBsOTAoelwy85/8ia8Px6xeveLcm5cZrD5O8d8w1xQ/yD1RLq8SMqL84
         ducQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736259800; x=1736864600;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XE2LBycvBfRVASiRxD8GRnH5rQbRkw6izbBARG4PHOM=;
        b=MXnT5aOqeihnUYk4hJnn7rFqn1yiMsd2xdBEwq4LgdGOxqU9OXnS4G0mEQHb2+QZoW
         ml7R2D+vkV5b/OkhSzfH1+f5Sv97GgLE9dqU5hACCvyTP/sFJNzEwI64SJWD+xB2xkdF
         ZVLfbii81C4KqwBtx94a9nIAgtaUSCRsOGMhY0BILjOuFsMTHZh7SvSqUaDlAGse7+EZ
         dVVpqSbbBMo/yDVl9+d8rKWnaN1SwjezWi48ryXwDejo32kEpf7W2EuPAIlfummF9P0e
         O4jOzHRCaOqyeGFVOf+nuJ+C9SRXuiomdUkaJm/HX9oFGry+CtZSagbjEPDgWzvUMKjy
         vsKA==
X-Forwarded-Encrypted: i=1; AJvYcCUxANBX1E6g1tAjmmaZ932a2n9SRn4mY7impjEYCKEncrP7cOtZCZCSSrBpADjZDxh95b2b2lA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxr7zlmCET9aoecnSOe04SYPRDiLaKKSdk/YhuD65xjboDf8j2i
	F6TZeLafA03CqOo3tXPNL2P8Emp5s8+sqVb4YXFLM/rz0+SUaGiv
X-Gm-Gg: ASbGncsl8F5lGxAs8IdkgpCHPDOYzfyZSJ3ABPAvYySVNDGXRD1uC/Fm7JAsq/vBcF3
	+exuCVhBe5jdbB4SHCG2UAdyYTk3S0EJOlFhUfdXKXGN7U/SlWlMBGL9X5R+vgjS5GTeSC6wMEd
	U+meqnDVpe8um6yuDn2tLrtfnRa6vNJS0ijJKLFE8prUxo5KoIcP8WrFzvQYRI+Yl5XZoIZGFIY
	ovPDBQrd/2Uvb6p754Oo2lCTF+YfMF/85fi8xUiXLl6v6ImY13iBi3vNe90fYhU6bj0d1MvAiwL
	GiAnE1rXCMIdiMtAf+3K1CtnJGI4+3Lx63O+Guq9TYO62qpyljTVjGSTJHf0aaRYHKZWQPfqa2B
	EnJk5tIrjr0M4W7s4WSqR/rGFQ4jjgRA=
X-Google-Smtp-Source: AGHT+IFTKXq+cflhxmBLnsZ30k5zI/b1GmBG/qIWiM0wUuk9AhpVGKtgpK8+7CvsgQoYKL8T/INBNA==
X-Received: by 2002:a17:907:d87:b0:aab:71fc:47a3 with SMTP id a640c23a62f3a-aac3379034dmr5727225766b.60.1736259800081;
        Tue, 07 Jan 2025 06:23:20 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d806fede4csm25126108a12.63.2025.01.07.06.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 06:23:19 -0800 (PST)
Message-ID: <b7705a4e-5559-4fe3-a302-4c60d7224e49@gmail.com>
Date: Tue, 7 Jan 2025 15:23:18 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: phylink: always config mac for
 (delayed) phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
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
 <ed29e632-332b-4af1-bf7f-97498297e731@lunn.ch>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <ed29e632-332b-4af1-bf7f-97498297e731@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/7/25 2:20 PM, Andrew Lunn wrote:
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
> phylink tries to determine the whole chain is up. As Russell says, it
> could be the PCS has not got sync with the PHY for some reason. So
> even if you ignore the PCS state, it might not work. This is actually
> a useful pieces of information. Does the link actually work end to end
> if you only look at the media state? If it does, that would indicate
> the PCS is maybe missing an interrupt, or needs polling for change in
> state.
> 
> 	Andrew

After phylink_mac_initial_config() is re-triggered with the phy
attached, either by the patch, or even with:

ethtool -s eth1 advertise 0x28
(switches to sgmii)
ethtool -s eth1 advertise 0x800000000028
(switches mac back to 2500base-x)

mode is set to MLO_AN_PHY in phylink_pcs_neg_mode() and the link works
end to end.

So the an-mode can be 2 different values, one after link up and another
after these ethtool commands.

