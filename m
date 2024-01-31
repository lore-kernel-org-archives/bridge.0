Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12679DD0
	for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706654; cv=none; b=iw6qsE6sf3+KdaEblexCJqlC/vxcW6GzVeyNgSQ5FyRv5cgVP5Hc3BGqDFC1Cv2uiXs6XJwB5TWfDaX0GJMezSsXFM2OAMoqEI2Co/F2fdgzc1zy0QSgapc79DZxeUSdNjiK4oT0Ob9cHEWOT1vRTqgQcmBYuj3hSlJm+VEJKEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706654; c=relaxed/simple;
	bh=d9djXh8YHyVzsz+5SiwPrTgVQxpKPQjTgBSMiG9miD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEJQTszoyZvbG+x5yMRpFQnuqI+rDs84Uh9iWNG19d85SB9Hvr4rEdzstIn99Bz7Y6bPHPdIpPe03Ir89M+ocACPYrK786sR24jHoTF9FCtDaKtLpR0x+xG9Ik9WqTv6R0Urht4M70FseCWfaMiRQwCfMfCkKIv1gQjgmPRBXWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beIARqXE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beIARqXE"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40efcb37373so19801385e9.2
        for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 05:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706706651; x=1707311451; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z63eJUVdfgj6U9DgTOj9Nxua6onnJk5BZ9w81YFRoNU=;
        b=beIARqXEY0Op9jUI2VZOBSgucC1LjLcF2wEdaGZJsgawAmag+d7BoAXLtYGhz8OCyE
         Az9jF42vg0UMbvNU32FzzsdrKse+TvmG8K5wcyRhE/kqmspqFNkce9uj11dqt847HAz8
         iNOVJSk9CJq8rMGvalHCb1F0tOmZ6nx0mIXPVlav2rMOd56664/xPDyp6I5mvFlPLwuC
         8DU1sj7Mhf5273FmCcPYrXLv20CPcOLe0lo59KOClAxIf30591aVZSMSDrlGFqCy64Hj
         Jq+XS2yG2CjdgosMxsiHRfZV0aILNWCZZruWusLARkrm951AfW5VdbY6zhzz7H4FMHVa
         YQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706651; x=1707311451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z63eJUVdfgj6U9DgTOj9Nxua6onnJk5BZ9w81YFRoNU=;
        b=uvAT9QtHW4BE/8S7xSxz3/5FwjrU2ENKJNxTw3REtnBy490kq//Um8q95i2H2dnXDf
         pC6wibGUfF+w8sGyRpbRhyaIIhOKt0p407wyLiOghcva91kxthv/nk5+7xfIS5G8HT1o
         lIAITlUz0B6HhaSjc7hRoG2MNnwSzs2gZ3MZVGAd8Jx4KHkc0829CN508DhilukptJza
         bSht6qV/CQCRduTlBNri+oUX9kGfaVfDaHQyEO6AId7aBZeNM33Igtut872bFDmIF02S
         CfwA2Ew+WImBalyXJ+3S45lNyli86/lyws1yZ+ZsdpRrmbu8cd85moVwu0lQqhMQq3hZ
         8P/g==
X-Gm-Message-State: AOJu0YxzuP0uIpF0NymxjOQ52+YYKYD3TnfrzDpHSg12AtGmPMm0zJui
	IrPGKUDCVhJn/+aQdUFMDAwfj8lI5ZWORvCF/81QTfhlAx1mbqcO
X-Google-Smtp-Source: AGHT+IHI5lJ3ZaUC/kHnExkVNW5swAto6oeg7CQXEKlBUyvkob/axCNt5Fm/9ar1Zf0nd11we9OfqA==
X-Received: by 2002:a05:600c:a384:b0:40e:a479:fed1 with SMTP id hn4-20020a05600ca38400b0040ea479fed1mr1385982wmb.7.1706706650987;
        Wed, 31 Jan 2024 05:10:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUZaxNtDeNFnK21vACUdSHGOsGaKEK7/7wLg+/Hp4wG2i1Wf+pA3lPCCfduA+9ztlJoxwpKXPF0MwsIu9uQqWhyKiaYn9HcarBG3oMt7lwUrE8t4V3PiE1bJlnb6SGJJLK+l8faCjZbFScXlNCa7clCrdB62eNnqiA4kTJLR17rroQcu0TLjWIzhFJ6uiZpsKwwJXc6vh5EOos=
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c450c00b0040d5ae2906esm1590900wmo.30.2024.01.31.05.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:10:50 -0800 (PST)
Date: Wed, 31 Jan 2024 15:10:48 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: jiri@resnulli.us, ivecera@redhat.com, roopa@nvidia.com,
	razor@blackwall.org, netdev@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: net: switchdev: Port-to-Bridge Synchronization
Message-ID: <20240131130003.bpqd23eepjlt7di7@skbuf>
References: <87fryl6l2a.fsf@waldekranz.com>
 <20240129121739.3ppum5ewok6atckz@skbuf>
 <87bk927bxl.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bk927bxl.fsf@waldekranz.com>

On Tue, Jan 30, 2024 at 10:23:34PM +0100, Tobias Waldekranz wrote:
> On mån, jan 29, 2024 at 14:17, Vladimir Oltean <olteanv@gmail.com> wrote:
> > I'm thinking we could do something like this in br_switchdev_mdb_replay().
> > We could block concurrent callers to br_switchdev_mdb_notify() by
> > acquiring br->multicast_lock, so that br->mdb_list stays constant for a
> > while.
> >
> > Then, after constructing the local mdb_list, the problem is that it
> > still contains some SWITCHDEV_F_DEFER elements which are pending a call
> > switchdev_deferred_process(). But that can't run currently, so we can
> > iterate through switchdev's "deferred" list and remove them from the
> > replay list, if we figure out some sort of reliable switchdev object
> > comparison function. Then we can safely release br->multicast_lock.
> 
> That would _almost_ work, I think. But instead of purging the deferred
> items, I think we have to skip queuing the replay events in these
> cases. Otherwise we limit the scope of the notification to the
> requesting driver, when it ought to reach all registered callbacks on
> the notifier chain.
> 
> This matters if a driver wants to handle foreign group memberships the
> same way we do with FDB entries, which I want to add to DSA once this
> race has been taken care of.

Yes, not purging the deferred items (for the reasons you mention), but
as I said, "remove them from the replay list" (the local mdb_list).
Similar to what you've done in the series you just posted
(https://lore.kernel.org/netdev/20240131123544.462597-3-tobias@waldekranz.com/),
only that instead of removing from the list, what you do is you never
call list_add_tail().

> > The big problem I see is that FDB notifications don't work that way.
> > They are also deferred, but all the deferred processing is on the
> > switchdev driver side, not on the bridge side. One of the reasons is
> > that the deferred side should not need rtnl_lock() at all. I don't see
> > how this model would scale to FDB processing.
> 
> Yeah, that's where I threw in the towel as well. That issue will just
> have to go unsolved for now.

I mean I have some ideas for FDB replays as well, but they all revolve
around making the interface more similar to how MDBs are handled, while
also maintaining the rtnl-lockless behavior. It's a lot more rework,
potentially involves maintaining 2 parallel mechanisms for switchdev FDB
notifications, and very likely something to handle in net-next.
