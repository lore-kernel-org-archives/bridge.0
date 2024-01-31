Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AC78288F
	for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713608; cv=none; b=acVcGIFMpnNrGOJGR1uRfDpoTGdVE7JWhpDYQh7XcxKLZP6P/axpLlFlkM9pIcubYVypS5b6CPKCPcA6E99cCpG7YNoZGu0U6wAT7ZJK6FZnPNxvJ7TbK3hnOGRt58M4IGyLyVkr3mXp/02dwZ7bk0X7TZPPlKy0mgDi7ryq6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713608; c=relaxed/simple;
	bh=JKswgWfJZBdtmIeko8KWMNuj6Qcy/inlP+BGa8aajbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPhyzEPsh9+jmuG1jKN/Ls3EGjFF/kFHn8OjTOhsAibfJXozyDtVOzjZln40eeDteY7ypeeSyobxLNg/Udfgvzo28eOefoyFgkvvQMkMSPsu9Q502HpbgJiEK4EwWc43gygXWnCpc6CMPponUJ1527hpmB2urlbWX7gbqfmxAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/av7JYI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/av7JYI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fb0c4bb9fso10235385e9.0
        for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 07:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706713605; x=1707318405; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBVPi7n/ictw/t00XJIGW3x01xrwKWQ4gYT/CyEnd8A=;
        b=L/av7JYI1/gX1lGyk6QHtO58lm3Z9+tOH7ZBr9nJWPRAVFk/orXo6FEz+vI6R703MF
         JZOwVPtsOekk1Q+t+el8ew+nwHuIlfzqNTHs+P/IzYEGiDi7L1K2PbIrTurgsrxDcuft
         3CFuHB9SAq3RyMi/lacAi9d++Ozr4KwQCAiJgrsAMfP/mfvTsxUS+nbK3WO3YwdlvGRS
         oyGWOHBrMVb+asTxGyO0boeMxHpqqd/EI10NEx+/c16BaE9Ple47dk3/Y0QMUihmDUqm
         K6K8UHp9AEKF5Xcl8gns9OSYmrKQbT3iAkjdQJFTnE7RW9j4P/oQZr+EFXjvPEjIbc1j
         O9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706713605; x=1707318405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBVPi7n/ictw/t00XJIGW3x01xrwKWQ4gYT/CyEnd8A=;
        b=r4j7Hprx/OS7JuQYjfEbRy/ugZx1yZSezX6WCptjeAnOOMW0RDPQBbzz3d/h1GD641
         /WxL8b73reQGeVs7xxOza9dy+ietEZMu6to17eLXpWi//iJp0d3BHYGrW/uvPFWwoLDO
         /ycwLFSgr+uYzMDhg5VlyDwxvMMyPbJ9uu6MhjB9uwm1cNbJmI+pmDmUgkU0yG2qssu9
         fTjQugi4T4CFBgjSngg/mk7ahjl1N5G+IY25EOYXs/HtdhA3qzpRXxxh5up744ACJgaQ
         CwXMgAwYpRvfbXRNDlhkhYq40mnJHJWOC0cYjsbIUuJRlzMZ+GL1fowFdsv1PGG24oMY
         vSOA==
X-Gm-Message-State: AOJu0Ywt2p3cBcrv+tTSIb7nVfMbztrKfHCI1/wgZdH8fdpgPDNfLJDJ
	/8vmjaDcgGqMwu4w3HpPnh7DOoMpLf7rX06bNkjxFLkpwvmaByubTy1mis3bhMY=
X-Google-Smtp-Source: AGHT+IGiPoUnJ8P5vNtErB54OdVWsBM1JqyZNoTTI4pb+oGNQSvMiZkX02utUlDRvS6s0kGjUwFv3w==
X-Received: by 2002:a05:600c:5109:b0:40f:b45c:85a5 with SMTP id o9-20020a05600c510900b0040fb45c85a5mr1374110wms.22.1706713604721;
        Wed, 31 Jan 2024 07:06:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVbcKo0Qr9DO0LxZunuvEOwIWqWEwOsIBHjNHHasl9y0GDJzI1QkS4wFtT8gBqqvQ15W3cZGytxXNOQU89wvtdcpz0YRlYHafuRF0mSfxf2Xg0mFGuaYT0yQzttWy5Wx2s7LRYjqAtLy7hydQ/pyznFvgURi+2KYExUIpiVP/0ZqiLj52AHAo9HFBtmWMTzqWmdgjcPUCVnNb+cTj/Ti/ycon64wWyiNnsrtBsJZXLB3YdvK+ydRSZbw87H4g==
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id eo9-20020a056000428900b0033ae9e7f6b6sm9541782wrb.111.2024.01.31.07.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:06:44 -0800 (PST)
Date: Wed, 31 Jan 2024 17:06:42 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com,
	razor@blackwall.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
	jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH net 2/2] net: bridge: switchdev: Skip MDB replays of
 pending events
Message-ID: <20240131150642.mxcssv7l5qfiejkl@skbuf>
References: <20240131123544.462597-1-tobias@waldekranz.com>
 <20240131123544.462597-3-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131123544.462597-3-tobias@waldekranz.com>

On Wed, Jan 31, 2024 at 01:35:44PM +0100, Tobias Waldekranz wrote:
>  	list_for_each_entry(obj, &mdb_list, list) {
>  		err = br_switchdev_mdb_replay_one(nb, dev,
> -- 
> 2.34.1
> 

I think there's one more race to deal with.

If the switchdev driver has signaled SWITCHDEV_BRPORT_UNOFFLOADED,
it may be that there are still deferred port object deletions.
If the switchdev port is under a LAG which is under the bridge AND is
leaving the LAG, those deferred deletions might run too late, aka after
it will no longer process the deletions, since it has left the bridge
constellation.

To fix that, we need another switchdev_deferred_process() call, after
the br_switchdev_mdb_replay_one() calls, while still under rtnl_lock().
The existing switchdev_deferred_process() call from del_nbp() will not
help, since the net_bridge_port (the LAG) does _not_ disappear.
