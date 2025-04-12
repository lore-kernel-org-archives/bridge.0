Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6921865E2
	for <bridge@lists.linux.dev>; Sat, 12 Apr 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744464870; cv=none; b=XHEzVFxyViQ4fykwu78oOqHTlOtxxINJU7hHgsy6l2JP4GbzMJAyFjQkKOq5/RRmR41t7BXaCb3w0j5nnlXsKxMnmVnuDAsmvKzFC9RvBPnB+8RYgRG0PhSV17KHOhmOdvdxYWT/aGFL3yUhdyQAl9Jf6qY0mA7AklqYdrfpDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744464870; c=relaxed/simple;
	bh=NO3DxyBYoznn4Joy7NjNSpMDaDjRCQbpBwtMJpvWSGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToP0GtQjMtB1nnGuxYmnYrLhSNCjB76yNq4lLAisJY1r81LE+azUkhqWoHxkmex8fCgOKvQMxE92eXImtIDNXRIrdLOjNQavT1364/Fuw1G5TNt6RRCzKT8hk1RVUrHhpmZ7zu3AcuP1bQyIdPKpCQkYHRaaE0BKt5my16SVQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED0D1I/5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED0D1I/5"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3912b75c0f2so261747f8f.0
        for <bridge@lists.linux.dev>; Sat, 12 Apr 2025 06:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744464867; x=1745069667; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WfJoT6PRSs94k/+btljFzIPdD4QWmfmkTqVitM7k/U4=;
        b=ED0D1I/5Ffy0+uLHxtVFxENENUD2n2H/gzInYPFhBGpIwcn8VbxpPgdVVpl3tMjgkV
         U6zJ+y8GWxsjdPM3a+sYbo3oYppM4wzY4n+NrZ/sFOMhBQr9rUTvqPc70Iu2ycF4beUB
         9sDXv8pkWRt/s1fzEi1FIfJwTOyvlnodqrfuR39zl/Vo7AmaVtRNYKVA1CDlt/cjzZp0
         Z1OZFIyavHXW8u0tAYXDLbCocDjhhPS5A0tTnjoHMfXMgUtQqgXtKftTSQtTy96uZW/x
         K2vevFkUuXRDzfrdSfjuiA+ympQ02Fj/dWoIb9V7UV5eoD1mztTJk7tXfa5hAFteMhEZ
         D13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744464867; x=1745069667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfJoT6PRSs94k/+btljFzIPdD4QWmfmkTqVitM7k/U4=;
        b=GZ3A7Pn+7sb7iwZmdnEsgwQ4USgBT0Z0TwVHByz+RsCCw3EXwInAspxWWeovAp47m4
         v5jcdPEYkvzsI4fl3heQbmHyQH5I5fqDkrFmgTQaCFDSJo4HfGeePIEyAltnTCCkeyQQ
         yPWjWigZiJ0UPZJ4wFw3lt8ygiK/jkZQml6yxe2UC6HEur5yG94cynxjCRLTX2vMfx6C
         Dwub8TcT8k+ScaGHVgf2VWcU5LAoiaDpcgjbxkzYB3RQGccBgTocjt9+4amYqCKi0Fdy
         KYoFnvcsPnKgdDgikC/jzNfl00GnbiQc0g3b/b+77YmFfY/4+5yPZqAf74NPBB1Ktz+U
         Xkpg==
X-Forwarded-Encrypted: i=1; AJvYcCX7WrQmq6onubMowKa6ERyYvmUBcwRoP0yb3JxQZxM/YyJlp8M6pZ3S9r1kT03Lhab87Tm5J5I=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyg5QdbpSALoLxS+bYojNSzfhGXFuBYUtC6qzYH3XugantAQpjg
	ExSxUEjoeNiHCV4UQNcbJtkswGNs8XrW6dyStyNcXFGOuZK5VH9t
X-Gm-Gg: ASbGnculf8lFIPKP+gIm5j9nguX5FmbPcb+3idcPrgTmYy0Up3HS0pmb4Q+VzawWHfv
	e9QFyQ11EO4IFAhRQvRNG0Q10PdUSSwN8qw93+bBTecDGqOwHZwvleoOLZOamTKSEj15j1DfxnI
	YannP4pmPB7iL1Q7yTIjBQdT8eUm/8ViW4NyE3gpJp831RSDgpDeARaRlG5VRNNc/e15pVd6AR3
	LSHuCOPX+pdj1HL8Qo5Px+YK2jrJfysc1QnznxgR8Oydu5BBdcDeuELnUWUC2wCLIrpJWB75h2J
	uwrnz1g7P5yf3pJHmtYlrLIiOOcn
X-Google-Smtp-Source: AGHT+IFbgobwEpxneS25gPpj0QOmulKDiFpAZ+O7Q8yZ2Fwz44EBlrgCDGaOiI2rP+iH4TAaMMJGlw==
X-Received: by 2002:a05:6000:1867:b0:386:3a50:8c52 with SMTP id ffacd0b85a97d-39ea521d69amr1869543f8f.7.1744464866659;
        Sat, 12 Apr 2025 06:34:26 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fca5sm123160565e9.32.2025.04.12.06.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 06:34:25 -0700 (PDT)
Date: Sat, 12 Apr 2025 16:34:22 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net 0/2] net: dsa: fix handling brentry vlans with
 flags
Message-ID: <20250412133422.xtkd3pxoc7nwprrb@skbuf>
References: <20250412122428.108029-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412122428.108029-1-jonas.gorski@gmail.com>

On Sat, Apr 12, 2025 at 02:24:26PM +0200, Jonas Gorski wrote:
> While trying to figure out the hardware behavior of a DSA supported
> switch chip and printing various internal vlan state changes, I noticed
> that some flows never triggered adding the cpu port to vlans, preventing
> it from receiving any of the VLANs traffic.
> 
> E.g. the following sequence would cause the cpu port not being member of
> the vlan, despite the bridge vlan output looking correct:
> 
> $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1
> $ ip link set lan1 master swbridge

At this step, dsa_port_bridge_join() -> switchdev_bridge_port_offload()
-> ... -> br_switchdev_port_offload() -> nbp_switchdev_sync_objs() ->
br_switchdev_vlan_replay() -> br_switchdev_vlan_replay_group(br_vlan_group(br))
-> br_switchdev_vlan_replay_one() should have notified DSA, with changed=false.
It should be processed by dsa_user_host_vlan_add() -> dsa_port_host_vlan_add().

You make it sound like that doesn't happen.

I notice you didn't mention which "DSA supported chip" you are using.
By any chance, does its driver set ds->configure_vlan_while_not_filtering = false?
That would be my prime suspect, making dsa_port_skip_vlan_configuration() ignore
the code path above, because the bridge port is not yet VLAN filtering.
It becomes VLAN filtering only a bit later in dsa_port_bridge_join(),
with the dsa_port_switchdev_sync_attrs() -> dsa_port_vlan_filtering(br_vlan_enabled(br))
call.

If that is the case, the only thing that is slightly confusing to me is
why you haven't seen the "skipping configuration of VLAN" extack message.
But anyway, if the theory above is true, you should instead be looking
at adding proper VLAN support to said driver, and drop this set instead,
because VLAN replay isn't working properly.

> $ bridge vlan add dev lan1 vid 1 pvid untagged
> $ bridge vlan add dev swbridge vid 1 pvid untagged self
> 
> Adding more printk debugging, I traced it br_vlan_add_existing() setting
> changed to true (since the vlan "gained" the pvid untagged flags), and
> then the dsa code ignoring the vlan notification, since it is a vlan for
> the cpu port that is updated.

Yes, this part and everything that follows should be correct.
