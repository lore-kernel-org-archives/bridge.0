Received: from mail-qv2-f0.google.com (mail-qv2-f0.google.com [74.125.230.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA2D3E0C57
	for <bridge@lists.linux.dev>; Sun, 27 Sep 2026 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790537741; cv=pass; b=PetwmdHkFh41G9ERiKD6cgPsYUgxfumEVKs1yckoEqf8cR6Flmox5X7wOaVpirVa7kCwL2O1yh1YEumWUwORNCElh8v8S9igzxrE6IIZ4/GxzQBrPTqWS4YSaHfwlJcu+uLDRgVelOvQTDXkNUKqmEe1SysKSSTCNUCT8XrVuEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790537741; c=relaxed/simple;
	bh=mrOC+K0YOCPbrTmQM9IR744v9j1UjcD4tQT9sNiYbXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLi1chzRCS82JMG1RS91M36PYnqRNgyj7YhhsQd6sIlCYBUpLsZnBUZYKY1lIZnm4LQUVtFjKCSTuBmOOG0T/3WipCU/BDpFd6nXWvYoKICixYfNOZ9SPP4TrwLYFaRVLF04L9Gi+AZlafjsWYlFhOv/H7lC68AvH0PkxgPdZtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTiuhTJC; arc=pass smtp.client-ip=74.125.230.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTiuhTJC"
Received: by mail-qv2-f0.google.com with SMTP id 6a1803df08f44-910603aa531so10136826d6.1
        for <bridge@lists.linux.dev>; Sun, 27 Sep 2026 12:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790537739; cv=none;
        d=google.com; s=arc-20260327;
        b=Q3MyKi+rGk6wwllqwx1a2SWSs3pMR4eS/KzY2lhtFaB2tvAwMYdNOQ7MGYkK7k/qtX
         kD65eEE6GVFEXmy4uOsmjPhB0kDstw7Yek8zT3uROWhgrRckl4exws5J/CSHvUnYtP2V
         cLPBVaN3oyZLA3/zt4jH9WwXUmELePgsTjnvwdBj8voLJXYEX7WhwDh7yYCjOJYKSxUe
         cnxXrZvyzIay0fDnN+5mRiM+an1vN2uqxdS9H/zQht55efX7AW0+KuLReJMh3VS8lNIs
         BrTgw9W847gSzeu8+NV7ddgGC/5CEUHo2QvxKoHskHI8DiS5dK2rv6ecsGPAPuz3xKxA
         q13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mrOC+K0YOCPbrTmQM9IR744v9j1UjcD4tQT9sNiYbXw=;
        fh=+ps5MkrSw3MrrRG8wHCCSCNldg7iM2AEut2A5ql/A48=;
        b=rYj+7DrAv5gspkmyLQcH6l4CSXZHxE9iuZmH8zfup9ucQQO9497fSJXRG9Vx4enwgj
         L7FyXnS5E14eUK7VHDY+sIRiVeV0r/Wo6I9jr9dgKDfPIo4jUug76AYd1h5hignp/FGc
         2J7bNm8r3HnPJaqNoQ9PhASn/wkgsgpATu1GviQlrlhM+GqXAKrqNjJq71B91LvDU3wp
         0xeMkDVHEcMrN+fEA3DJcuMRTS/TEIsfG9xXEWmv1cHBC0CvJxhmlH9VdoFPjKsjCKxh
         BKyOba7V9hEuY1l7B20O+y0CDtkfQDxTzKhJKI9zJK2A4HFjCbLpia0FTXOFD9T9qZ+1
         BhrQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790537739; x=1791142539; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mrOC+K0YOCPbrTmQM9IR744v9j1UjcD4tQT9sNiYbXw=;
        b=ZTiuhTJCcXu779QaiDdKEOISD/sVuH2b59OL1zajdPfCB6QjktAYgKBhKA0jAnqz2h
         Xyu78TaHmjabzQ4OoIfmu7a5tiZ1wZPqxfVWU8AvIfS2j0KKa/uCcdTLouxS6cL3YWkx
         5SgpVmor0H3414SQLFg98eepJ2BykxhvtmD8VxipK4dFIHmgmyvAHUI2jUuY7JOECZiU
         P3zoGJwEcz5Nblp1+Tr+RcbSI5H0cDqsEhYGdoS9/SeWlNEuZ6brrZ5iEQjNuN+UgTKe
         Nt7Ox/oBO5AZwT6vdxtjtxfEkTFQ2+zmzyYklI05ysR2dWzTds3AO01hCGqWxY3yve5C
         biZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790537739; x=1791142539;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mrOC+K0YOCPbrTmQM9IR744v9j1UjcD4tQT9sNiYbXw=;
        b=PPRbQr8uqmtYgW2WFXX7ani56mHSPPhBXW75Y6NL3wiBRKbV7/ClvX/zaXHklPCIBx
         PlxsHUL7vLZeeDr3Tg/gixSWdzHSXF2R+BB269WmtxXNKgsrs7VGe+66tWKlsS6NhorJ
         L277Q8TSwlOGngkacP77ZHXUN0zgA+pz88P1HtgpLI6MTE0o+t6nPnyobXHg9eX6ECJb
         Yk8l9gAml6tlsDGbf3AMv5oQ4oTDlEZmQWIYkwP7ygHjvTNJEtP/O1Un7P6xxM4h/dO+
         luYSOEXX7C5N6cCw4EspKV3f7uZMgXZOIB6tAl8wO0jFl9G67X7Ru9abW8gqumKmc+nQ
         FfIw==
X-Forwarded-Encrypted: i=1; AKwUvBxbEv9bAJTu731cWLuh3Xp1q9D0yaXJecWHIYQDcgIO8F005Dz+2jN3WbGLcpQJ+XRIu2tHTnM=@lists.linux.dev
X-Gm-Message-State: AFq9FYLJgJ//giXx78v51rfzKy4N3yPj/+eQFkLy1NXx03JzWiSQ2Q8g
	cOORgPHpreMFop4pH7pcGsArkrDGfoiVvnhNeKH4/mV7CbfYyAEllGjKaQQILyX3buVT0zPfKC5
	1je3/pMFcColXXaeVgDZeyzB0OjdEfYM=
X-Gm-Gg: AYBFou1Rhl4eZJxE/OFgkkUTRld4qRvwweDH62LAhT7jFzOUxGgpZ7qvj1G2sAguOiC
	uy+A6jjYQsSdccZXmXL0ySG5rFMEXWzndriLF6uf+V/eNcO5RAqDllGfAgr1muBuVpivgDfBobO
	ik+9y1JfkBflauVpP1c0PQ4FLhsA4zqPYIP5pniOyGuRiydiGfqCR8Z1tYKWpylxwHFUoAsKBqy
	cXv7/kBcnIgsoXm0QkCtJo+zdPKPp23mu5tr4vD3NsO5sUtpXFXllprbF/x6c3a33AMbAH6RsuQ
	U9AMCFVJntneRAHR92Dhpk0i5BpEB6xRp7lDfHSQL92Sqkib523xJKe+
X-Received: by 2002:a05:6214:590f:b0:914:2c1b:7d29 with SMTP id
 6a1803df08f44-91441fdca4fmr122933726d6.6.1790537738641; Sun, 27 Sep 2026
 12:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1790323012.git.petalzu987@gmail.com> <156c41b1-fc86-4ecf-8181-461944734be9@lunn.ch>
In-Reply-To: <156c41b1-fc86-4ecf-8181-461944734be9@lunn.ch>
From: Zixuan Chai <petalzu987@gmail.com>
Date: Mon, 28 Sep 2026 03:35:27 +0800
X-Gm-Features: AclHuK_WZK7MrZ0bZXc1PSjSrdd-S31NImpwP6KMGVrKPrjwr_b812NLnM_khgA
Message-ID: <CADTzadLbmd5E73RG16kQ1rFmwYESNuQqgc-JCX2RVhY0FRh8nw@mail.gmail.com>
Subject: Re: [PATCH net 0/1] net: bridge: avoid recursive multicast cleanup
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ren Wei <weir@nebusec.ai>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Sept 2026 at 00:31, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Sep 27, 2026 at 01:04:38AM +0800, Ren Wei wrote:
> > From: Zixuan Chai <petalzu987@gmail.com>
> >
> > Hi Linux kernel maintainers,
> >
> > We found and validated an issue in net/bridge/br_multicast.c. The bug is
> > reachable by a non-root user via user and network namespaces. We've tested
> > it, and it should not affect any other bridge multicast functionality.
> >
> > This bug is tracked at: https://bugtracker.nebusec.ai/f/4342
> >
> > We will provide detailed information about the bug in this email, along
> > with a PoC to trigger it.
> >
> > ---- details below ----
> >
> > Bug details:
> >
> > When an EXCLUDE (*,G) port is deleted, br_multicast_star_g_handle_mode()
> > removes its corresponding temporary STAR_EXCL (S,G) port. For an (S,G)
> > entry, br_multicast_del_pg() then calls
> > br_multicast_sg_del_exclude_ports() to remove the remaining automatically
> > added ports. That helper also calls br_multicast_del_pg() for each port,
> > which re-enters the same cleanup and adds another stack frame per port.
> > With enough ports, the task hits the kernel stack guard page.
>
> What is the value of "enough"?

Thanks for your review.
By "enough", we mean 151 temporary EXCLUDE ports in our tested setup.
This is the smallest number of ports we have tested that triggers the
issue.

> We get lots of bug reports for theoretical issues which in practice
> will never happen. And we get some reports for real issues which can
> happen. You are more likely to get your reported looked at if you make
> it clear the issues really can happen, give todays systems.
>
> > The PoC uses unshare -Urn, creates 256 temporary EXCLUDE ports and a
> > permanent INCLUDE source entry with IGMPv3 enabled, then deletes one
> > EXCLUDE port.
>
> So a hardware switch with 256 ports is on the high side, but this
> could happen in an SDN setup.

We also believe this is realistic in SDN and container setups, where a
single bridge can have hundreds of virtual ports.

Thanks,
Zixuan Chai
