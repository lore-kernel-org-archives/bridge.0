Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0131D7999
	for <bridge@lists.linux.dev>; Tue, 21 Oct 2025 04:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761019423; cv=none; b=qDX2ihttaPlJBQsiTSdAsQ86i74xQDpxFM6Loyi3FbHC7vhf4UhBsmcL7AkiPwTm32bYPq7F3xHhic74M0sEfK/gJD5Z6Jt1rEE2fw6TZrDW8urQCxaJvpdsWGNpwx85/Mx+OvDVjT67vEyiuz8lmcXx18MT/mZenOqcHukAreM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761019423; c=relaxed/simple;
	bh=FGw9uKLVYLz8Atlzf9NPOuGFgink3pTJjbUmcWekYM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfjqTpOB79nEMa3bypGifoBr1Ty26ZO8d9VjVhrTS8Rm9TtVwmWdv9BLZEfV1CFkizH0Yn6Txe3rf4uTfTlNBmoo1/+wHAvGvXx+JMIRgo84Dx/Jm/qNurDMwyj2ZhIgOTnn1S0tjhRwziEYIUDiJ2kaymEFHdg7VhtWy32hjRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jpm7QJUb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jpm7QJUb"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33bcf228ee4so3794850a91.1
        for <bridge@lists.linux.dev>; Mon, 20 Oct 2025 21:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761019422; x=1761624222; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CzjId5UhLzcQWxSkjMlTd353fisikKEHJ9Xlvn4jmOs=;
        b=Jpm7QJUbi0pWTyHa+i1rQb6rq/EOU4MJSGYVFsr1XFx50H5t1EhOaHmBuJ3VUdAVMt
         flE113BZSB/SQP8e+nDlM3putyi+kRWiyZ4mHMLOQ+u15+vipJTbDtU3Ag+KS+jZWLgj
         38bYB0m9lJZSf94MHAOXVMY0ORZHzlK7vBxqT51XTLJdKPg2TPgY/s33Fsnutjeu9VPP
         23y8bMk8v3Kb3Wl+PLGRbWD4GWWIgo+zUBNZhkEYZEamGLVJZlxG0FZr8S4mz8gM8Rg7
         A1Kk+LsCvIQnVac+i3ZY4QonC85VyxagUDxOb84qUYbJIuJLNUOTIaY2fw9ez29bZtXD
         RssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761019422; x=1761624222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzjId5UhLzcQWxSkjMlTd353fisikKEHJ9Xlvn4jmOs=;
        b=HSAHVSJcqMAhSA6i9qpJyydd9ToRKyMvtm5xuDFfyu6CGkjzPRlrVAuvoscs03dCSR
         iNHix6CQG1dzHWogAwoy0XUNCbqyp3F/UH+JRGGNocWzs8gZAcwa6n6nSegPkuCUyeCu
         t61KSCYtV64GlC6OgoeBhpMSHcqPwGZa25lIU3XtEmnPeP+h6OAay+L/wlMYBCVq//yl
         ugZ1VDuc2HxXTGE6dfH02nOR8sRe6iLSjeHaNQ2QGY7c+eeLYH0H7Ug0tcmaZ6OJX2Ep
         HvqnyE86X2MZQKMJpiyl6rYgqWo4xJyVDn9lBK6YCbM22yH+fxF/4pmvKD675DRu65RS
         9IDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWysH8E+rdNHXOPWoM38TefAH1lQagcCjx4ut/T4Scti/GgtmyQYl9nMOJTgjcZmBVx7eMfFBI=@lists.linux.dev
X-Gm-Message-State: AOJu0YwozSfLj2IYm7oTHuIp8vVJdoVZamme39iWGUx/MHX73MgQUGOn
	eOk9BI+0zGGGld9t4+LScj3bKHU5DO3vLkknJCOv9idQOaKVR1YAAtzO
X-Gm-Gg: ASbGncti2OdiEGXcfiDOrPBqLOhbsALIloZPLzkHwttPVPlh01Xz/P/0iOdmhBLY6je
	u8XayZJTT3LwY2SbKfBBvbAJxZj28Cu0rCFCTOGYS83js1ObdMcM2737dqem+w2G9hCwTh4o17w
	KEXYFDouNx0NadLPe25wogo5o2MLsoixK5r5db83O3F3SAdRsvMj4dNs+dQnme2aaDJfM90CN51
	bTTAqgZzFV5cUfRIPL79FLQyziyRiap86cLU7J0IXntR/pJ/zigRDFo2BslcHphJGWGLz8sNUX0
	oxCNwDCzUPbmBTET1qd0QQPjxGj5Riw3+IrnztEA5V9AMHARaMHwJAS9chCslalnmTdaGgq891s
	pTEWhefeiueB+3zy3t4AGVTaXoilzq5m4hWcNVg+Ksstb1HDBHWt4VJgH8Rtxnt3TyQJXvC2EYV
	TIRiVhYUQv2eraVE8=
X-Google-Smtp-Source: AGHT+IEGLHBHLBcEiZkt0e0q2lpyK6XnA2EHB5p+AIeBPMFAHNsp8qccXxyZON/4GBnP34d68j285w==
X-Received: by 2002:a17:90b:4cce:b0:32e:dd8c:dd18 with SMTP id 98e67ed59e1d1-33bcf8f7617mr21437755a91.17.1761019421547;
        Mon, 20 Oct 2025 21:03:41 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5df93591sm9771411a91.17.2025.10.20.21.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 21:03:40 -0700 (PDT)
Date: Tue, 21 Oct 2025 04:03:31 +0000
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
	bridge@lists.linux.dev
Subject: Re: [PATCHv6 net-next 1/4] net: add a common function to compute
 features for upper devices
Message-ID: <aPcGE36U9DSza8xU@fedora>
References: <20251017034155.61990-1-liuhangbin@gmail.com>
 <20251017034155.61990-2-liuhangbin@gmail.com>
 <aPX8di8QX96JvIZY@krikkit>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPX8di8QX96JvIZY@krikkit>

On Mon, Oct 20, 2025 at 11:10:14AM +0200, Sabrina Dubroca wrote:
> > +/**
> > + *	netdev_compute_master_upper_features - compute feature from lowers
> 
> nit: I'm slightly annoyed (that's not quite the right word, sorry)
> that we're adding a new function to "compute features" that doesn't
> touch netdev->features, but I can't come up with a better name
> (the best I got was "compute extra features" and it doesn't help).

Ah, yes, the term "compute features" can be confusing since we don’t actually
 update netdev->features. We can rename it if there’s a better alternative.

> 
> > + *	@dev: the upper device
> > + *	@update_header: whether to update upper device's header_len/headroom/tailroom
> > + *
> > + *	Recompute the upper device's feature based on all lower devices.
> > + */
> > +void netdev_compute_master_upper_features(struct net_device *dev, bool update_header)
> > +{
> [...]
> > +	netif_set_tso_max_segs(dev, tso_max_segs);
> > +	netif_set_tso_max_size(dev, tso_max_size);
> > +
> > +	netdev_change_features(dev);
> 
> Maybe a dumb idea: I'm wondering if we're doing this from the wrong
> side.
> 
> Right now we have:
> 
> [some device op] -> [this new function] -> netdev_change_features -> __netdev_update_features -> ndo_fix_features
> 
> Would it make more sense to go instead:
> 
> [some device op] -> netdev_change_features -> __netdev_update_features -> ndo_fix_features -> [this new function]

Since we actually doesn't touch netdev->feature. I think [this new function]
and netdev_change_features() should be in parallel relationship.

> 
> Possible benefit: not forgetting to fix up the "extra" features in
> some cases?  (ie calling netdev_change_features when we should have
> called netdev_compute_master_upper_features)

That’s a good reason to call them together. However, ndo_fix_features is used
for computing new features for later use. Since we both compute and set them,
maybe we should put this in ndo_set_features instead?

Thanks
Hangbin
