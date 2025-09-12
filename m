Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16215168BD
	for <bridge@lists.linux.dev>; Fri, 12 Sep 2025 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757639315; cv=none; b=KfGCUriOBD7mAD1ai16xXV3ooUsbKB4Dxz1vfMCd++Oy4229Pbu39IwRgq8TayrPOYhTy3x3mlSEHHJi7cvWLm09suPcK8tQFVE1rYMcBmxdJRGvf0VqS2iXeuXfZRZ61GzG96QyLYbqiYTStABvL1Suq2XdsVjvH4Y8+5Otlxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757639315; c=relaxed/simple;
	bh=eQpv6kBWgXwZ5ymPbOOxPwWf3GOU0exmn3ci7k/yrAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnOUb8jdgSScFkcMTRcS7ZQkMD0y/yNsb/0GEsyfbI2Psg50QIVEFMHPxnHr/N0JkeBWpt/URNSb8cYCtkqmRLy9SAMWQZIA8cY9aZywScL3l7O2MQqg3FIx/Hwt8Ntuvr3/PrU4LtzLYTNH3f3scJ+X8+19i861I3XTJRrwB3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEM2X+GC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEM2X+GC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-25669596921so12742195ad.1
        for <bridge@lists.linux.dev>; Thu, 11 Sep 2025 18:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757639312; x=1758244112; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r3q/WZRKTStLm/cr3Bpe/8OXQEdqzw7U/XTO1V+fg/A=;
        b=YEM2X+GC9LRZX3rkkLyYfPSlVc8nfPxBehxBjivmvMizTLoz18N21BaDEGXzxZKBVD
         4l595n25/pYDiEdIa8B/kYHr7ZNvR80MSPM6FdukvkkX7R8b+5vG5r9lZqHXeRqKX/xv
         hFSe2gE2qHiRtvmU9pQUuCXn+g1K1vrbxJZGBF/+yeFoKMsdoiBuvE0G8aQ2t5XxE3xl
         bT0R0f6rkUgx8IZGqpjsonWWp+v/gAPlyGwwJ3PU2Jusz4+tDJAYEr9HDPNoz+qTa7yL
         +kwmd6MhjlOUIvXfm2zvogEdDPTz/XvBBEPHGi6TxXr6gZ0dcBhOCGz1p30kPOX05W09
         k2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757639312; x=1758244112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3q/WZRKTStLm/cr3Bpe/8OXQEdqzw7U/XTO1V+fg/A=;
        b=WZQhJz1ps/UqORDDgkKHsl/dyqufQxrvvZS+swr4xIkGtj2vw0G9ar0oTcUJi4rs7a
         kA9MfpV7tDXScFOAQJduL6TESnl8YV4fftj999f7Cr0w3v3ps+fJ9qFV0aaa/vGowI2Y
         N6+KvljrUcHxBwp1r+IGO40b8ksGcurv1v6k/0QK60lSupULqBWhumWTXyplexbbviQd
         y5Jd1qUzee2XxiCmZ0EZBPQfF00weFZeNJAang+Aizvb+rUr2ld5Ug2UjuwBEPAfn56d
         X4EgbGLBpmZ7GOYygoaaJCKNfmT96srpiCBnv+d1q5Zd5NDxFZjaIHcQNXrhg+HE98Jy
         AOAA==
X-Forwarded-Encrypted: i=1; AJvYcCVs80c2L34YEOG/RzNxlkmC57B9Z4qUSu68PNFs6CXEb7KE4B5lzAqws5L2tJF476D3MXHpS0M=@lists.linux.dev
X-Gm-Message-State: AOJu0YzkzvVmkDeZVwpYxGHaDAmSazHvJsFYb5qEheOy6Jvl9iBcXK4a
	QHRzERr1cy7Ke6Pir1GOM/X/Rg7pExZbiyxc1Ij9LCvaN3lZIEjQBcmt
X-Gm-Gg: ASbGncsqKTo5/HIN/Nixn1U91GAd3r9Rdh/sa76xNfRUBoGbRhALksZK1TPUvurIWRj
	FK2f49Zw0mVTsTL8D5adR0y7S2P303N8qsDhtfilJEJ+ie4soIKWoKZzKkxx8Vcoa3q4Q8Wp2sF
	ZJRO/c8VjIMwnKmHxwMz4mapZPZD/qvIbu+O3dCiHWJXTupIVQxXYjzBYzxfi/EqQbSEy7Z5sPT
	v1am95eNULyUl9Ww/8KFIPJA6f9QBtHJFpN7l/+t8ynosm7Eg5jRRRQ7/VXgW02jOwNiqSDJ54+
	QnlzEc7YnCF8vfeBbKLtFJF7dn6fMKeotIzfxqdTtcvCMC/Qp/bPx2CP2W3ddwdMfQ7/KK8twVh
	pQKF5nkuFh66nPcDWzvPjsk0juutq7TlGcPrsKA==
X-Google-Smtp-Source: AGHT+IEaxnOMPBCkONkI1ijeqyKr/Allx7jl1xU+fododaurhzB5w02ghEn38iBkjsFdGUAg4fAuYw==
X-Received: by 2002:a17:902:d4d0:b0:24b:e55:34b with SMTP id d9443c01a7336-25d2665fe69mr15407845ad.31.1757639312270;
        Thu, 11 Sep 2025 18:08:32 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37295f9dsm31783235ad.55.2025.09.11.18.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 18:08:31 -0700 (PDT)
Date: Fri, 12 Sep 2025 01:08:22 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: add a common function to compute
 features from lowers devices
Message-ID: <aMNyhuC1DJsajuqs@fedora>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
 <20250829095430.443891-2-liuhangbin@gmail.com>
 <aLRr1W3jKRDYsRSq@shredder>
 <aMGLTzACsKLRIsVb@krikkit>
 <aMGwcyKTvmz5StN1@shredder>
 <aMG4W9xUGxjLAVys@krikkit>
 <aMLHz0P4KhHPNIcc@shredder>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMLHz0P4KhHPNIcc@shredder>

On Thu, Sep 11, 2025 at 03:59:59PM +0300, Ido Schimmel wrote:
> > > It is not clear to me why we are setting hard_header_len to the largest
> > > of all lowers and not needed_headroom. While bond/team allow
> > > non-Ethernet lowers (unlike bridge, which is also adjusted to use this
> > > helper), they do verify that all the lower devices are of the same type.
> > > Shouldn't devices of the same type have the same hardware header length?
> > 
> > At least not with VLANs. Both basic ethernet and vlan devices are
> > ARPHRD_ETHER, but the hard_header_len of the vlan device will be
> > larger if we're not offloading:
> > 
> >     dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
> 
> This looks like a remanent from the time before needed_headroom was
> introduced, aimed at making sure that the kernel has enough room to push
> the VLAN tag when the hardware is unable to. I believe it should be
> converted to adjust needed_headroom instead. Otherwise, looking at
> __is_skb_forwardable(), an skb might be forwarded to a VLAN device when
> its real device does not support Tx VLAN acceleration and dropped
> otherwise (due to a smaller hard_header_len).
> 
> Anyway, I'm OK with keeping hard_header_len for now, but ultimately I
> think netdev_compute_features_from_lowers() should be adjusting
> needed_headroom and not hard_header_len.

Thanks, I will add the needed_headroom update on my todo list.

Hangbin
