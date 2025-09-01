Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9273009FD
	for <bridge@lists.linux.dev>; Mon,  1 Sep 2025 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718976; cv=none; b=XHTH/Tk/e7rAtejgFpt/6A+xnKSsGJLQVxp4+0XW6Zt6RijRPsyP5KZNZ3iocavqtGeFUx2j+2NfUgX13GdOV9aZwMJIDPJVUXC9eUsvIj0u1YTv0UfKRkIVz7ut3ozY23/1QVysX8JJJ6492De0xFUhVgNKu1j+dZpFLtkY00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718976; c=relaxed/simple;
	bh=uz12qVgz0O6jwygjA3gniSLgHG81f9+byrwSrrDaeEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVB40p5MAdvpWVAeg/wHv0Ms202pI8qHatabyyUAkW+R5bOFFDlAgB8BK6EpJ45QTyMmSI7UdRBWfbbA2gQc3yLQbx2Nne/aqG9vPf0p9lcY8tsxxsnyJO7aRWHM1iLnWOfQr+YHZND+TkaFnChjKfcoxLu+8FwVVYJcZg8i/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A15exxCJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A15exxCJ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77252278757so610458b3a.3
        for <bridge@lists.linux.dev>; Mon, 01 Sep 2025 02:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756718974; x=1757323774; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7PXHLM5OpMogL2M5B4YLeTjEVKoKX+6lorFe4ipT8fk=;
        b=A15exxCJkWO7nA/9b2PghHKEfT1mBRsQk9I90cEBEJ519tmgpqwLWsymdPchzgf11x
         HylDX/43T9Uab728nVbpndZ4JVpEWYSeFF0rMa0mjBu5vsLLYOn4/eopGHFfPMcVbd9Q
         9NOCx1QtrZ4sQeVyR+oylFS9+8PqeGkQU2ja4jsX9PboK1pg8oNzc3/nHrX7B6kNtsIB
         MmoWkgFHDxm9/zfIIteXOWau09mge/jou5Po6LMNhkJZm28yAoQeTgYKcMPK9WQLFwn9
         BXcj003u6d5yMoKsgbGFA3AReE779eKg0Vz1OOMIzyi8xljUo5XtZL5w/SSD6ruL0M3E
         PmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718974; x=1757323774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PXHLM5OpMogL2M5B4YLeTjEVKoKX+6lorFe4ipT8fk=;
        b=eFrWlMc0D4a/9kYkmYyGJmH1Rz4UX9ks9TayaM8G2RDO1TkK80zgP+PeRZeby/Jqm3
         9NPeK10VXL5ih+UsOsFu2B3rg37p4Vkl5fXXFfX24t5yWHBJuhitvz0eGJ6ciTlTmS06
         qRlwgNvf4DLtSCDiLMjPLO3NTAkZthSydg1mXo28jnSeZFRqo7NMWSWFb72g/gm5vuQ6
         wXVxjBQiSfbzCjdw8V2CRMSKA85iNpy2PB0wrjP3Z9sUcprO7cnlUH9Bs6oe43qEehNL
         FNG1TGc5surieqpgSi3KiOkjOipxYBkOJt0H3bYTz9C6wKa6ggq4RQofa8BbqVJa9Td0
         aLEA==
X-Forwarded-Encrypted: i=1; AJvYcCUHNAn2MWpDvsgipxi9Izp4ZlGZKxmXk3EI7VqF7Y7uJ4FJmtugh9WZ7rlnoICbyn0bQJueYW8=@lists.linux.dev
X-Gm-Message-State: AOJu0YxKzlCaW9XUwatk9ry3zeN8trzMilkBTrMj47kAFUt/iAdxIu+R
	4UI6lR7w/2oQQ4jNVvw/v56+Iwz+gQqRHQ6feEfB9slhUxhz+RuT2hLV
X-Gm-Gg: ASbGnct+p5h89QhSM3fWcv3qAebfnQDqKfRi7CSOtOG8Bp7ZxdNnSElpz3Wd7PxHEz5
	rb2/RLTaPMnMcPzF+hVVhoLI/JZseNlrL64EzxJipPX+I5vxHumlOD4es+p7T7Bf92xjw+fI3P0
	JckOjpEeWF+9xOES6DsI46izyGhU1ChfnQU/br4y/InyihMAxbHbLKwyIhXietekU53DKtBuxVt
	ulPzqSZNdEOsekVEsqqUTwZu5QI8GBnI0tFlsjLj6ChZ68lXK2f4q0FsztJy5GpR7S8hATd5A6M
	PqqFKsrIwLHTUgwTVVaZLWz+SW0DIr6GAbV3/+k+jECILGMtVrsUvZTyMAn2BMqFOvPIFjNRjaG
	6RWaGohaKWAS1FvBEKZCFqdcRAQY=
X-Google-Smtp-Source: AGHT+IFX4ZU89Bc65QPsiJNa006dpfPFfoE8Cn6iBBzDXZp0agsnMmjjVtbS9GaQuT0/35gIrT3m4g==
X-Received: by 2002:a05:6a00:398c:b0:772:10e0:dc41 with SMTP id d2e1a72fcca58-7723e309f8dmr9034760b3a.15.1756718973924;
        Mon, 01 Sep 2025 02:29:33 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5014desm10124747b3a.92.2025.09.01.02.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:29:33 -0700 (PDT)
Date: Mon, 1 Sep 2025 09:29:24 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests/net: add offload checking test
 for virtual interface
Message-ID: <aLVndADX4_nffUN5@fedora>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
 <20250829095430.443891-6-liuhangbin@gmail.com>
 <aLRvoV33kUnzk_68@shredder>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLRvoV33kUnzk_68@shredder>

On Sun, Aug 31, 2025 at 06:52:01PM +0300, Ido Schimmel wrote:
> On Fri, Aug 29, 2025 at 09:54:30AM +0000, Hangbin Liu wrote:
> > make sure the virtual interface offload setting is correct after
> > changing lower devices.
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  tools/testing/selftests/net/config          |   2 +
> >  tools/testing/selftests/net/vdev_offload.sh | 174 ++++++++++++++++++++
> >  2 files changed, 176 insertions(+)
> >  create mode 100755 tools/testing/selftests/net/vdev_offload.sh
> 
> Need to add to the Makefile

Sigh, I already added it to Makefile in my local branch, but forgot to
re-format-patch. Thanks for catching it.

> > +	# Common features
> > +	# NETIF_F_SG: tx-scatter-gather
> > +	ip netns exec "$ns" ethtool -K "$dev" tx-scatter-gather "$state" &> /dev/null
> 
> Why the redirection here? I don't see it in other places

When I tested local, I got message like

Actual changes:
tx-scatter-gather: on
tx-generic-segmentation: on [not requested]
tx-tcp-segmentation: on [not requested]
tx-tcp-ecn-segmentation: on [not requested]
tx-tcp-mangleid-segmentation: on [not requested]
tx-tcp6-segmentation: on [not requested]

So I redirected the log.

> > +do_test()
> > +{
> > +	local dev=$1
> 
> IMO, it makes more sense to put "RET=0" in the same function that calls
> log_test() (like you have it in check_xfrm()), so I would put it here...
> 
> > +	set_offload veth0 "on"
> > +	set_offload veth1 "on"
> > +	check_offload "$dev" "true"
> > +	log_test "$dev" "enable offload"
> > +
> 
> ... and here (instead of in check_offload())

OK, I will

Thanks
Hangbin
