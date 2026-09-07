Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896934921B7
	for <bridge@lists.linux.dev>; Mon,  7 Sep 2026 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788121; cv=none; b=SZswUUFqoJJvrwoiyB5I0/MIyKDmL4flhLLnxQvpHMdN3AWQI2IS68BvaO5s/5w56CRkIusxd2k/EgP5zfG1qX52OdmlthRFKA+g3Vo9wP+jf+NAEriOJhRJqusowvP/5/kbxcSHJQdACUZNDSpNH+d+Zs/GWf1rkZyb8Cmn/Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788121; c=relaxed/simple;
	bh=LxVaiSZFYdCWw5o76jR+r64eg9BGglyX0nY8xxuVmIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l09maSoRV3HwQaCvnLZqkGDgVRaMUi08tKW25yfHRWwYFxucPExikG7emjk+UrSiJyyGIxWT3xczIwkpGvOXD1XgjwywDX0qPT1EkG3+47+oGGNAKMgBnUlYRAPisi38LGjHekEQ0P+PxrsGXfYqFbzwqgw3cR+wvbMyG4UpOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBL5fcJh; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBL5fcJh"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39faa67fab8so27335881fa.2
        for <bridge@lists.linux.dev>; Mon, 07 Sep 2026 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788788118; x=1789392918; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LxVaiSZFYdCWw5o76jR+r64eg9BGglyX0nY8xxuVmIA=;
        b=lBL5fcJhIx5aETocNAlg7ORDJyinc91+X08fuKuVgy9ObMm4Q7VnOmLj4q5VA27jfP
         LJr4kVxVL9a/tQrzIlzw9tCQqOjHKkG6TnaJdgjVUkers4bqbuPUCac9LtQNcyiZDRd5
         SlO73skSzPwtT62vn1UnB4Uc57U75aXb6mmxotaq4LlhM3kVeGN9zEPTk10Y/yGyLB4J
         pc9rTFf4/5IBzHwWKU1OclX2L+UTmGTP/NnsI0JUvpG6SCfKrOqoJHzceO7QG4ZDNtR0
         ksXGC7csjjPhKbAv5OZzwLTIljrsEF2H/bM3xg3h2VFQ/hpYkI2CWeqxxVEguBImDpoT
         kMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788788118; x=1789392918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LxVaiSZFYdCWw5o76jR+r64eg9BGglyX0nY8xxuVmIA=;
        b=tZCuPYUGal9U5CMbxEMCC15c4rpuPUX6BaMhpZRGrHKuZeHwLo0wHQHsW8IoWfzNtt
         ykJwGLVWh2qPNA1A9XgEEI3mADPa0iX1LFiLed13vKC2AzbtXhywm5kXEOfKyArl9gYL
         Y/VG16IU5DZ7YlsqzvKv5/aKAdFTKkbesnwOIa541fNGxsHil+1lwMhvmotkglXbR+Rz
         jEKUNaVh+lKftfD6oMBKpf1UHz9L/TsHjPxGHD+AKbsXBGiq78/MC51ug5VB9eXSKpLq
         o810jJ4Yj35CyQo0TVqvKF5LRspscUrDEj3/fb+9BzLE/R/v7HRLmo6TaiSG1dmACmY2
         n65w==
X-Forwarded-Encrypted: i=1; AKwUvBwv0rUXjKGyfU/sKEoZ7WazOp/Cp5EIGQxrnBVYiD63xq8yfgJXhojVV4Di3W6byfyjVS+SX84=@lists.linux.dev
X-Gm-Message-State: AFuF++mfsMQaCpdpXf9ISCG37deIc4nPThJ/CIcsvo1A38cz5pEEqePj
	l9RWceJ4ECdkXga3aRNf1NqUKR5Fo4OKCMbEtmD+7oQxV4ZITR5nNInh
X-Gm-Gg: AYBFou1ULueY5Hj1UViVxZ59JbAzxqTCPd9eopIKyQ1OjULx8EQeFmAT92c8MVWhtlo
	yWnHIU0y2QIMlvr0QBOm0S4QRk827T0UyhZiC8KSUMmIRK9SCJ6AKA1UE7TvnD8tl+bHmIT4Uiv
	kb7YG2Jw2+Gx5HwtLyW/YUnp5Ov5foDem3Q8je4CG5lpTjQ7W6V2jwRG+PCX17SGtKObbVCdfz9
	wcgcwoa0FLJBb4P9GOYguNQUw8djOj5BhA7IQZD7K3IodFM31BjeRRXCnbnmCeD8xpOiSHJSa+I
	GulGZAeBNyBSKFBeCTe399eq99H7YrCxThbZjVtql7f2bfXVH+SlsEuHz/P1mBwQbYSycMM/ugf
	ztqguZeHx6M+P7iHeLL1UisrcE1zhnVFZDfdbmpfSsEahwhyL2hUpg6A9ifGoxZPERCoQCjRVCj
	ZvH/UTKsV68FIzozcEQRpjqisZedjmVsGOFFNGiQ7DotVI/nAMS5CyV+3SobCONL7aF3nZKP4Qi
	jH/ACNp9Go0ouGA50QdajWY6ov++bcElR6VMsuAh3j5fGENaqASr29OIA==
X-Received: by 2002:a2e:be1e:0:b0:3a1:edd7:340e with SMTP id 38308e7fff4ca-3a371995b91mr42775031fa.0.1788788118329;
        Mon, 07 Sep 2026 06:35:18 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a37058669fsm26853201fa.17.2026.09.07.06.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:35:17 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next] net: bridge: bound the port VLAN lists in the IFLA_AF_SPEC nest
Date: Mon,  7 Sep 2026 16:35:04 +0300
Message-ID: <20260907133505.5291-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ba2dcdb6-923d-4fc1-9c92-7a77c0b61a09@blackwall.org>
References: <20260906224246.21719-1-iprintercanon@gmail.com> <ba2dcdb6-923d-4fc1-9c92-7a77c0b61a09@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 07, 2026 at 11:47:24AM +0300, Nikolay Aleksandrov wrote:
> I prefer a more explicit path - return error for both (RTM_GETLINK and notifications)
> you'll have to plumb down extack but then user-space will know there are too many objects or lost
> RTNL_LINK notifications and it should resync (e.g. use RTM_GETVLAN to dump the vlans if needed).

OK, v2 will do that: br_fill_ifinfo() fails with -E2BIG once the nest
would pass 65535, kept distinct from -EMSGSIZE so the WARN_ON in
br_info_notify() still means what it means today and the error goes to
rtnl_set_sk_err(). For the dump, rtnl_bridge_getlink() can turn -E2BIG
into the extack message itself, which keeps ndo_bridge_getlink() as it
is; or do you want extack plumbed through the ndo? The size clamp and
the doc text go away.

Artem
