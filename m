Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6F421B9C0
	for <bridge@lists.linux.dev>; Mon,  8 Sep 2025 04:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757304950; cv=none; b=N/JKWNiR0X0pzZj6Q3BfJo30UGQpShm+hQRE3lyXi1wXKmF7X/4PA8EgpaeXle1iEqtjkREBwzvDMbY1OWw9ihLpisOfSZA0r12Rs0ZPISAntqoUv8J7J6eDZNILlTdyiz3zfg9ncUhI4Ifw6QyaGEpcmhQSyq311Ma8UO1bGyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757304950; c=relaxed/simple;
	bh=UCdNo4tJLMfRG2ThjczsmLh1pxSCdjn77qJ/oH+Pgh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEkOz6TVkWgs4rqKDUO5/DQ+vVHc9+SS1ZxDTFrn9xcGaX+sw9Y/uRmkHX51+7FRrA3BS2dS3oHJC/gPW+AqB3gImEu00D058mTR6psSO8wL40NBFnx8SNbdFCZds7UeThDIh1/xA5lk38JUVwgrujHY654cLdIfh1LIAWH/JbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5wajY1B; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5wajY1B"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32d6c194134so1259733a91.0
        for <bridge@lists.linux.dev>; Sun, 07 Sep 2025 21:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757304948; x=1757909748; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QmVHYdYnytQawmE/GlyC7TmQ4rj+TZYEN+n5OB2Z78=;
        b=N5wajY1B3A1BBGVRCf6obLVzmE7uD+25rrIc046Zq3puAST+QRtxxz/Vcb1/JW7169
         yg4KvWoTWpLjbrIFmRFYXsf2atCSDTlyqNe+knNgzGnMhHx/cf1237dtJh7a1O62N2s2
         v/EHNYl6E1adEEZBZ0Rwlc9gU6uXtYcgluEWC0QoNqOP/F7pyOWogHk2xqMtu5kwZgPX
         c2ESHxK/OfnTcJj6YOdk2tqs2baqIriN3E4762PUn5eS9E9KIWWoE38I31I6NhPDBqwf
         hkEb0CCrT7h3T0iezdMJ84NLtZRZ1BETgVe0LoyrifjsboafgcNskSvIqH2A0oLaUjlY
         1snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757304948; x=1757909748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QmVHYdYnytQawmE/GlyC7TmQ4rj+TZYEN+n5OB2Z78=;
        b=ZbWmBtv090GIA93j3gJNLHB500vZ5qWfEPYDDcYGikMWUedK7U592OsgLHXNfckzHJ
         7ck551D0n8LaXLcLv9H6BUjiPXGo5a4ZAL9U/UMCOM4DOTx9IToaCZSnEHR9rUABoFMy
         IkasdEcNch+VzBFHNCLRPeNkf5Mye6L+Q9ediqQIbUGE7atgw+xPbM1NEdzJwWeegCk6
         AA4dwbiHGU4vCw/AygQNSCwgmnzaL1ar90udSLQidtjqlCAljGHEuLIfRxpTDTz/amf3
         WeVa6YJ68RQHDDCqvtbM5VwuU/f6jma06VR7cc228womc2JU/9pqHKZjqz369WBNZydr
         Jfug==
X-Forwarded-Encrypted: i=1; AJvYcCW4/CaKehSRppQAK+o7DICxButGKQz5byB0lHoHGuDMy4Xrl2b3//ztK/lGaR2zcPp4Ochj5NA=@lists.linux.dev
X-Gm-Message-State: AOJu0YwxuXLMY2gxT0mpr00YvPz8PL0hHV2PjqiTqQjpe4x895Kibt6+
	K5r3zCnB9+aUCGrY9D1tkSzhI5C+xkUa3ung++yyQMK4Vajc2lH3T3sy
X-Gm-Gg: ASbGncusqNVJ/IcPc0h6MfjCjZj3BDOP3Sk8p+HYK2VQBfz4Vulqt5JbnBWrL9JWny0
	q21u8zWavujn2uCFOqNHIbBPBeEvkN8gEMPWA2Bk5/UcamiIcbpwy5iFamdPUNgXimToqh0d6rT
	BzL/Nypi3fAlBWefScWTtREs6yF6qOA0a5pXhd9wihS4YtrovfXtkLBNS2HVLgQWYiejg+CkTfl
	LrrXp9Bd/AEOZeJ5QhG9+aakSv7LAD7dRmRuu6VL5sIWVJI+A/ubTy7j0oaqSpe7Bym0xaED0Z5
	48hfaDw2MPpvlg5CNPVdFTeJDsgZ0ZvAJV0imF5y9ynlLG2Pi/0xW0Su0rlFQ24DWbPzFKOLUVf
	QnX0Yu6c7IOoZpxxpIuZ0ZkONhjY=
X-Google-Smtp-Source: AGHT+IGFie3VQxK6NB2GC5r4dkSoil0H/yHLmWPqvuY/cl1GmZ+3lR6o3zidk2O+qIHaVF5KClDjCA==
X-Received: by 2002:a17:90b:1646:b0:32b:7475:2aa with SMTP id 98e67ed59e1d1-32d43f9346amr8616078a91.26.1757304947965;
        Sun, 07 Sep 2025 21:15:47 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d93317f0sm29097956a91.6.2025.09.07.21.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 21:15:47 -0700 (PDT)
Date: Mon, 8 Sep 2025 04:15:38 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net-next 5/5] selftests/net: add offload checking test
 for virtual interface
Message-ID: <aL5YamjbZB5gsL30@fedora>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
 <20250902072602.361122-6-liuhangbin@gmail.com>
 <aLyoEiWnuvQ-5ODz@krikkit>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLyoEiWnuvQ-5ODz@krikkit>

On Sat, Sep 06, 2025 at 11:30:58PM +0200, Sabrina Dubroca wrote:
> > +check_xfrm()
> > +{
> > +	local dev=$1
> > +	local src=192.0.2.1
> > +	local dst=192.0.2.2
> > +	local key="0x3132333435363738393031323334353664636261"
> > +
> > +	RET=0
> > +
> > +	ip -n "$ns" xfrm state flush
> > +	ip -n "$ns" xfrm state add proto esp src "$src" dst "$dst" spi 9 \
> > +		mode transport reqid 42 aead "rfc4106(gcm(aes))" "$key" 128 \
> > +		sel src "$src"/24 dst "$dst"/24 offload dev "$dev" dir out
> 
> It's maybe not something you would expect, but this codepath will not
> check that NETIF_F_HW_ESP is set on $dev (you can verify that by
> running "ip xfrm state add ... offload ..." on the same bond+netdevsim
> combination before/after toggling esp-hw-offload on/off for the
> bond). Why not use __check_offload again for this feature?

The esp-hw-offload is fixed on netdevsim

# ethtool -k eni0np1 | grep -i esp-hw-offload
esp-hw-offload: on [fixed]

There is no way to disable it. After we add the netdevsim to bond,
the bond also shows "esp-hw-offload off" as the flag is inherit
in dev->hw_enc_features, not dev->features.

It looks the only way to check if bond dev->hw_enc_features has NETIF_F_HW_ESP
is try set xfrm offload. As

static int xfrm_api_check(struct net_device *dev)
{
#ifdef CONFIG_XFRM_OFFLOAD
        if ((dev->features & NETIF_F_HW_ESP_TX_CSUM) &&
            !(dev->features & NETIF_F_HW_ESP))
                return NOTIFY_BAD;

        if ((dev->features & NETIF_F_HW_ESP) &&
            (!(dev->xfrmdev_ops &&
               dev->xfrmdev_ops->xdo_dev_state_add &&
               dev->xfrmdev_ops->xdo_dev_state_delete)))
                return NOTIFY_BAD;

Please correct me if I made any mistake.

Thanks
Hangbin
