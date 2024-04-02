Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C854C7764E
	for <bridge@lists.linux.dev>; Tue,  2 Apr 2024 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060630; cv=none; b=CHIf2gHKeRxjxKYA2/GUNef3IJV5UpaKx+zBIqRUX84kpyjMXLPwFZeX93PkVKk/HJrZ09EiwCi//pvQWTGJSCa4q//77InDhjxXOSJ5msHlD38BqqxdqPAKxVsCyn21/rsymtRcBbuopAYha603GhfusW3l6UAXmsj0dQrpbT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060630; c=relaxed/simple;
	bh=4QZLZAns8p7vUq4xXyL7Kp528hkrlWGkPY4oiD0R4zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNjUywvj48vF6ef7MJx/De4Nxo7BZlOjuKlWPReGwTOpdCeci49Jf+OnGnS25NhTr03LrnEwY0lKx1OsmYWw6M+WHj+EaCnkDoV8fPrNmiv95adjjsAPYuw6+9WdfwEGL0EXwpfvEFf3Lusz7QgnjeBzIWa6XAVoeg9CERfhpac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMra5lpO; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMra5lpO"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56df54f9fc4so357088a12.2
        for <bridge@lists.linux.dev>; Tue, 02 Apr 2024 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712060627; x=1712665427; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/unssVqP/tBj5M6lSsNX5+k+FjirzQl74biGWZLi7vY=;
        b=NMra5lpOfEqgJJzQsRqfkjO8M/QQFxfSvnzyXmQxdWKRaAmQqg+NgTmK81cPZvUYHr
         Suq9HRZgyUc/jI1N+tK7MsEWoAAiCHIbGK8AKoPLATBqH4nrZYoKe3/QRx4MdiVrYPSJ
         BG+2+Qm3dA3Pt47rdWEHomTN/mohLTcaHS2rkyHn6kwTFx4N2jsj9rN1vGH9PzWyZqyL
         bE+nOs4KKaoABRlp0JZpjZysBWEBbZAOkJNTGEHOk5st0AN55sDqe8/g9HQbe5pNnJT5
         0rg9VV5NuRlqIfrFZSSyFsK7lke8zrV7MesBkLtruzDMplktU33uxgap6FHP+ycY2lCz
         w6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060627; x=1712665427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/unssVqP/tBj5M6lSsNX5+k+FjirzQl74biGWZLi7vY=;
        b=iDFQYRuzCPwUjDhWnVeY8+kZNsxE02Lpekn3pGcZOC888kauqYYGhH0jAOq/p8Ef/G
         bGIrFfWUuRLgiRVowFPomcEQKOeqTjOq7gpq7RH4usdMew2pqH4XQK7KH9EGxR4tsgvN
         3uqjdH/rsZVtJPg1h7/x/bhuDGjjRkEQjpGi5RC3/A7vSlkXZCwtBTvyKPdCh+uvsEDJ
         pUdxZ9XbkuF0AR4FZGCTbHn6UKM1xMEm8rIHCHUpXSD8cBlR3dHTwrzF3ZLKj2QcdwgH
         RBSFAPI/WFCP5mnYIK2Rxi9jRldiXs4tOIgR4zvtVgFwdCubRnLOhSFvkq8sfVgMhaJJ
         Qjow==
X-Forwarded-Encrypted: i=1; AJvYcCX2n27NZxJN6IqhnMAvDJ2sm6+FYhi0IZRkapfGm2awmHblQJHuLI26hzfTecHFxRHUrNhI3vHubkV9ykT2tZFcedXgGRC9
X-Gm-Message-State: AOJu0Yxd5ASDhwBz5n78dUPns9XkB0hI7Btgnk7fUx5kKf/uurRHo2c3
	tj9OTm5XCBN5F7GFGxwEsSZ7cBnIdDd464eBiF3tbRAuv9ZdLR2u
X-Google-Smtp-Source: AGHT+IEamF/yD6pmqhtSfavUbe4xrWX+kXF6DzNjAP+lKX91t5p2IpXkzvujMeoIPm+Pgq1cmq9sqg==
X-Received: by 2002:a17:906:52d1:b0:a44:51c1:733c with SMTP id w17-20020a17090652d100b00a4451c1733cmr9691934ejn.39.1712060626861;
        Tue, 02 Apr 2024 05:23:46 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id wr1-20020a170907700100b00a473a0f3384sm6516024ejb.16.2024.04.02.05.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:23:46 -0700 (PDT)
Date: Tue, 2 Apr 2024 15:23:43 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 07/10] net: dsa: mv88e6xxx: Track bridge mdb
 objects
Message-ID: <20240402122343.a7o5narxsctrkaoo@skbuf>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <20240402001137.2980589-8-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402001137.2980589-8-Joseph.Huang@garmin.com>

On Mon, Apr 01, 2024 at 08:11:06PM -0400, Joseph Huang wrote:
> Keep track of bridge mdb objects in the driver.
> 
> Similar to the previous patch, since the driver doesn't get explicit
> notifications about mdb group creation or destruction, just create
> the mdb group when the first port joins the group via
> mv88e6xxx_port_mdb_add(), and destroys the group when the last port left
> the group via mv88e6xxx_port_mdb_del().
> 
> Use the group's L2 address together with the VLAN ID as the key to the list.
> Port membership is again stored in a bitmask.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---

Can you comment on the feasibility/infeasibility of Tobias' proposal of:
"The bridge could just provide some MDB iterator to save us from having
to cache all the configured groups."?
https://lore.kernel.org/netdev/87sg31n04a.fsf@waldekranz.com/

What is done here will have to be scaled to many drivers - potentially
all existing DSA ones, as far as I'm aware.
