Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E408B17F5
	for <bridge@lists.linux.dev>; Tue, 30 Apr 2024 01:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714440126; cv=none; b=bICqDIcSMYKovThwB8ijE3UpbaQVV5PBlHZ9upAmXodFaRXI1Weu0YDMHSjlWuKaAA0xLRZH1HhXPo1rO1BNJlhxZt8b/6x+4Isue08E/Rt1r71icWmwBChM6/DjydVaczkzPw0VYayyCFjxmuhloyhI9qwTTNcHKURfOTMSWAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714440126; c=relaxed/simple;
	bh=UMqhj0rTdZLGeNTxC8kWhGYjzAOidG4Koh9u9oR661A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg/Zz1gf7ZqGz337zzaoedFD+CwMrbb1BB8zPNm7DKrOwXRGoI33tPB47ybeNRrlfwsaf77XHdNl7WFVW5sN5m+PrPjQGMzrvbbAQ6i2LXMgu/UfAmF4lK9rYKP8OA6A+cVnRse2IGw6QWUdEbimqNdIjJEJ7WdmhMGE7PVkRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNR2vxUa; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNR2vxUa"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5878caeb9eso632364266b.1
        for <bridge@lists.linux.dev>; Mon, 29 Apr 2024 18:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714440123; x=1715044923; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mRqa2ovWjws7B2sIgD6E2HvQPUnrNYKW4I30w74FzA=;
        b=QNR2vxUaZ/43w/mRLMvUAHN2q6sfW966AO2O33bdE0sWHlGP4V0sThWsaQvQ3FipL8
         QoDg8cbQwtUQIZmSHhM20lXKUQNjy5EItCfdhm77adrw3QKzTbxO3KgbPfapbeqm+iYO
         4FJhOqWe27kT+Kkz+JBX8Cuo94H045sCsajKUy2HSIOYxYVs3qmbqAFQceKKyP+ZOZVg
         K7qiaEGyj4PwI3cIRaqhBihadBj5czs/FTazDMMJcy+QGquZ8OrSwYuE6NjvkgVK7Jan
         vAcUQMsPw+S40jTKytXm12SMd+Hc5IsSNRwMnYwMolMCBSTdfBxGhpt8HMc9ydf7myGK
         AwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714440123; x=1715044923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mRqa2ovWjws7B2sIgD6E2HvQPUnrNYKW4I30w74FzA=;
        b=Ogp/0VwamH8tBGwjemN1fD+ZRfUvaa9VEtlnESwXkzjfVafLponsSDg3iN7yUH0TuW
         9yNJZwPul6AEJkcBJNQX23ynr+ywxUUg2+3v/NFpDlN2+4Kj/l0y8DdyO5/Le2K19h4Q
         btJtWay1FGRnLZvUdp90OfMbjUaC7KVV/8LipI4sClwzqCTffGyDUSJ/THpG+W+Bdmzg
         8KaeLW8smWazJDLsbFjNybuBI65/uBw/6Fpdz8SdeYj7CAhd21idBc/W6g7gGe470d2V
         pQT5kjrT4itq+B4MduLr3+1AiNgw0gFNQ1etMhVuxUMo8x+ZFRcJ137D85dJHd5CluhW
         MOBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy6CitMAGc7HG9lrljcMTJsS109lEkrPxL7ynB8u2e/2bl0LJSj3L+KCh7M5kTfYLPe7qluW1MMluExxsCnX0LlN8/Mgar
X-Gm-Message-State: AOJu0Yx5u0LMGXfwZ0GsUPq/NUweNX/EuvltUK67V9ipYPpFvWHvVh+d
	Bx0a3cOrLrMptNAdKVng2OlIz0FSdELXlSfDykv+qNhtZ0aD/N6s
X-Google-Smtp-Source: AGHT+IFsFi0wMgKpgdlzgdLNfkp5iSSMe8elCVig3meaXHcygogd/Vsp/vWvDxyBkmV3BaICI9gqfw==
X-Received: by 2002:a17:906:c252:b0:a52:6fcb:564a with SMTP id bl18-20020a170906c25200b00a526fcb564amr788676ejb.9.1714440123077;
        Mon, 29 Apr 2024 18:22:03 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d70a:9c00::b2c])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906434600b00a518c69c4e3sm14388210ejm.23.2024.04.29.18.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 18:22:02 -0700 (PDT)
Date: Tue, 30 Apr 2024 04:21:59 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Joseph Huang <joseph.huang.2024@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Message-ID: <20240430012159.rmllu5s5gcdepjnc@skbuf>
References: <20240402174348.wosc37adyub5o7xu@skbuf>
 <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>
 <20240402204600.5ep4xlzrhleqzw7k@skbuf>
 <065b803f-14a9-4013-8f11-712bb8d54848@blackwall.org>
 <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>
 <20240405102033.vjkkoc3wy2i3vdvg@skbuf>
 <935c18c1-7736-416c-b5c5-13ca42035b1f@blackwall.org>
 <651c87fc-1f21-4153-bade-2dad048eecbd@gmail.com>
 <20240405211502.q5gfwcwyhkm6w7xy@skbuf>
 <1f385946-84d0-499c-9bf6-90ef65918356@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f385946-84d0-499c-9bf6-90ef65918356@gmail.com>

On Mon, Apr 29, 2024 at 04:14:03PM -0400, Joseph Huang wrote:
> How about the following syntax? I think it satisfies all the "not breaking
> existing behavior" requirements (new option defaults to off, and missing
> user space netlink attributes does not change the existing behavior):
> 
> mcast_flood off
>   all off
> mcast_flood off mcast_flood_rfc4541 off
>   all off
> mcast_flood off mcast_flood_rfc4541 on
>   224.0.0.X and ff02::1 on, the rest off
> mcast_flood on
>   all on
> mcast_flood on mcast_flood_rfc4541 off
>   all on (mcast_flood on overrides mcast_flood_rfc4541)
> mcast_flood on mcast_flood_rfc4541 on
>   all on
> mcast_flood_rfc4541 off
>   invalid (mcast_flood_rfc4541 is only valid if mcast_flood [on | off] is
> specified first)
> mcast_flood_rfc4541 on
>   invalid (mcast_flood_rfc4541 is only valid if mcast_flood [on | off] is
> specified first)

A bridge port defaults to having BR_MCAST_FLOOD set - see new_nbp().
Netlink attributes are only there to _change_ the state of properties in
the kernel. They don't need to be specified by user space if there's
nothing to be changed. "Only valid if another netlink attribute comes
first" makes no sense. You can alter 2 bridge port flags as part of the
same netlink message, or as part of different netlink messages (sent
over sockets of other processes).

> 
> Think of mcast_flood_rfc4541 like a pet door if you will.

Ultimately, as far as I see it, both the OR-based and the AND-based UAPI
addition could be made to work in a way that's perhaps similarly backwards
compatible. It needs to be worked out with the bridge maintainers. Given
that I'm not doing great with my spare time, I will take a back seat on
that.

However, what I don't quite understand in your proposal is how many IPv4
addresses lie beyond the "224.0.0.X" notation? 256? Explain why there is
such a large discrepancy in the number of IPv4 addresses you are in
control of (256), vs only 1 IPv6 address with the new rfc4541 flag?
