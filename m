Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF51DF97D
	for <bridge@lists.linux.dev>; Thu, 11 Sep 2025 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573655; cv=none; b=CxbCHcakES6wK7HBiCGUkCbup1bgmJG5xxWbT33WiWBMbAezwUK6d33C+At0SuqImkrrXUw2llNQ41skHF3R+MMhiS30GPWs+AkvlEGwI/iZT328BzydHYzQbFCprykOVqz+3qjCo0d0EC6O/DHKpFwj9a/u6znPnGbNKQCEdRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573655; c=relaxed/simple;
	bh=HsSbvPpiinyCihIb8Sgvopg+FLqWOWFxbriOrPtZk64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI56h0XSZuX4ggmJ8RjsZb20fwe3vBvSTAb2jWHfFUJk2zOvZlzR3Xf+zOvIN0NfUx+yfvsCGdqBXq155Pj8sMtb/UnTIR4fgR1Y3jVHdzme1QF/mTL0DW8zFDd4FIisiknURd6iLs8CbvF8rJ+Mx5eq5DdoUdAKjLblZhtrcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgOGcA/q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgOGcA/q"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-251ace3e7caso4741485ad.2
        for <bridge@lists.linux.dev>; Wed, 10 Sep 2025 23:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757573653; x=1758178453; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FX2vgtJaxZj2A6Z1GumM41ujOH8A5gIx4cxENKUfovg=;
        b=EgOGcA/qB4u67mj9H7+lU5DYnGJhSj315mm2OU1ruLG8LbI+QoLfVVbpleRngg7XW4
         Lohp2DMv467wgNqLcSrLjf/7DNxEWw2ytLaeHtGxoB+mLyn33N++/rlreUEBRVHeojoA
         Tgy+dn5XYEKqBQgTtI1axuwnbMvsd07SP8cpPEsDrWZoselDauZMKFE6e/GmrZXmYg4C
         XvOkNAut9o46k2RJz55Xo/tX9HDE78zFD+J6EyQSPUiQUZNTCTdM7QS0QsoFqoX3AqHk
         59/mccri/akVEZFm5kJFVQERU5XoJB5y63tAtUJ8RYFpwPKm8uS3JMzHYeJJdkrUeD5B
         i3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757573653; x=1758178453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX2vgtJaxZj2A6Z1GumM41ujOH8A5gIx4cxENKUfovg=;
        b=eA7hvsAEPDRDP4301bWxVGtjy/QIsgNKAJGA1xn5mCqcuQm1orE734SakfgfPCLGzk
         ojlVmqpKJNWNdnTgdM1g5vD306GBKEKjZk1yxl3fKunyNRfJE0c0HpjHZ0jhby8zUq64
         6TbEDY1SlLKbYS8+8WhZW5o+Y7BL4GdtLArr61/vIJphSoDRvBR9FWPcipDgYayZC7q4
         GMfn0ex9VSfYPp5IGKwXnRrTKXsm7q9MtqlwCRvkGL076DxWI7zV3VSMAqAFdlJ4Liab
         iq2LqfDBiNcau2tNzl94wLkC5tjUjrMQQsAHd2Vy8+1xKo8eKGi4IYPuyj1VTNFI6zJb
         mAJA==
X-Forwarded-Encrypted: i=1; AJvYcCXKri7s0k73E+HtHpG2NMt9siTjKfkEKH8E4vggPUlpf8AhqS1cviwI6ckrn+/HZabcak27w7Q=@lists.linux.dev
X-Gm-Message-State: AOJu0YzMkdmdw3MKAMWx/3VzG1kcfClKY8ofZ6G/orpEWrK0ICunjyJR
	AxXXOg6Fzsj01HjxcaQJH5wO1Nw/arowrPDFBbLXTjUO5l3gAYJnbZVd
X-Gm-Gg: ASbGnctx6N389WGokoTfFmjm1AaEnLhvYPLUrtZWJf5YxiKO1ZItOdjQuvSis1ghiid
	4MdVjw3nAtvw42JPyvuBHczvnD/I1V/5HPOlezWNcJjOBQEwvyN8q3NxBshbx70z6G49QuBonHB
	OEbO/4URByejeuYB0wD/icC8A4WGzf4wxwCrghlHAQkQglMkl+CpuBJDa9m4uqhHG854DguxRJv
	W5frTqxhmEr11B1N3jYvD8FKH51z5AFCGyj+5LqbS5qfLCF3gCvE955a0LGmzFdzX6d7VoPwL5b
	h855b/RgEg8VYhQR6Ji/89icKQ2XU2+eiVSql4hruKxrQESttVIphEt/YybEmjKAWPa0EsJPYbK
	r7wd9rDhH1vAEkgzYMAY7POj/NvJ1eOcfy9EarQ==
X-Google-Smtp-Source: AGHT+IEYR2a/LixxA6LHlM/R7UE1JLK460Ev1Uo20oFsmsItEoJidUORFnKkRGQ4z29RFi6EVRTcOg==
X-Received: by 2002:a17:902:dac3:b0:24a:fc8d:894c with SMTP id d9443c01a7336-2516d81824fmr247971415ad.1.1757573653055;
        Wed, 10 Sep 2025 23:54:13 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b20dfddsm8452275ad.125.2025.09.10.23.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 23:54:12 -0700 (PDT)
Date: Thu, 11 Sep 2025 06:54:03 +0000
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
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net-next 5/5] selftests/net: add offload checking test
 for virtual interface
Message-ID: <aMJyC_YNjVWcB7pe@fedora>
References: <20250909081853.398190-1-liuhangbin@gmail.com>
 <20250909081853.398190-6-liuhangbin@gmail.com>
 <aMGR8vP9X0FOxJpY@krikkit>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMGR8vP9X0FOxJpY@krikkit>

On Wed, Sep 10, 2025 at 04:57:54PM +0200, Sabrina Dubroca wrote:
> 2025-09-09, 08:18:52 +0000, Hangbin Liu wrote:
> > +__check_offload()
> > +{
> > +	local dev=$1
> > +	local opt=$2
> > +	local expect=$3
> > +
> > +	ip netns exec "$ns" ethtool --json -k "$dev" | \
> > +		jq -r -e ".[].\"$opt\".active == ${expect}" >/dev/null
> 
> Sorry Hangbin, I should have noticed this when we discussed the IPsec
> test, since the problem is similar for the other features set in
> netdev_compute_features_from_lowers:
> 
> `ethtool -k` does not test the dev->*_features (mpls, vlan, etc) set
> in the new common function, it only checks dev->features and
> dev->hw_features. So this will not test the new function.

Hmm, that make the selftest more complex. A very easy way to verify whether
the feature is set is using tracepoint. But Paolo said adding new tracepoint
is not welcomed.

Since all these flags are fixed after compute from lower devices. We need to
find out a proper device and test the features are inherited.

The next question is how to test gso_partial_features, vlan_features,
hw_enc_features, mpls_features (maybe also tso_max_segs/size in future)
effectively.

The veth device only has hw_enc_features and mpls_features, while it's 
hw_enc_features doesn't have NETIF_F_HW_ESP. The netdevsim device only have
hw_enc_features.


For mpls_features, seem we only able to test NETIF_F_GSO_SOFTWARE, but I'm not
sure how to check mpls gso..

For hw_enc_features NETIF_F_HW_ESP. Does sending ipsec data and see if
netdevsim has pkts count enough??

Any advices? Should we just drop the selftest?

Thanks
Hangbin
