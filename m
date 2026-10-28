Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207494;
	b=jdYGtNCSYG8PC+B8w4QtX6iK5jao5un0Mg2Ml78McNaCqLaGghAuDA1fyfQoM+GkYdSq
	 Y1yWwpaP41L5z1tHAlHaHFIAotAHA74s6Y2Gh9mJnJIY7+AnvCWmPG3DLMYOcExp+lvTF
	 K7nU37AJqprrm9NFKql3aZxyj/n1Ni9iBMnRdUCg6QNtUeCFCV62bOGFQqfLyytH8kgAv
	 lIHZ6R8UNnHzvnUtom4H3d694874LlCMaFW9TPMeLzHdO2sOGdgb0p6hK/sYYAFcOuUMG
	 72tctqywkONj6IpwlnKFca/KoM/mUFbREsvI7/B8koTRfYsIyqgjnHgcz1xbkr/ARAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=+Bj9TlgMdx89QuvYDbkkZB0BkYmkkE60v8E9W6mG4wo=;
	b=kL2nnU85LYLXuFf9ZGGufrS01w69cRj6BwmjGDxHVhHaa4GWD10XP6oI+UogcPeFrQXn
	 jeMEmciLdVWdKxL2nfvarqQehVbGcMZihMO8XY+bOWeJKYvOfzOt7RAbriQe/W+qCtWmX
	 x+OpvkhOmZjmNeXH9jTWk2iSwa5Vu3zCkNU/p1H2ROBX91vEnnP+krVTYvOvL8H9FbgTQ
	 qaHQC7HMzBrA8QFEwXFj88fOVXIPx0wMGUyBiV46HlvjqMzyRnLeiS6cb0fas0+yxPZXS
	 4+VQyJS2yWctdN3I54pAT/fhpc7pQ3E6sOiCiN9lF0pGt+78h/658hpubf24iLYjL0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OF8qhDWZ;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB31606A320
	for <bridge@lists.linux.dev>; Wed, 28 Oct 2026 17:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BB31606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OF8qhDWZ
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36a121bb8c2so1532023eec.0
        for <bridge@lists.linux.dev>; Wed, 28 Oct 2026 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793207493; x=1793812293; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Bj9TlgMdx89QuvYDbkkZB0BkYmkkE60v8E9W6mG4wo=;
        b=OF8qhDWZHMQNEuLa0p/M/BSZkaUu20WarhO9SR2k5U0boYJEkhtgMNPouws8TEAoOx
         2iHue/EZdkSk5sAJPANzGWcheUjfprLljisKgHPxCXz/cSkPzNnHRHjT7yMvdty78H5E
         T0FH9nq0Fymh/gDNZwUGPbXZWkGhuqy3js0aww5dqMcM519aioar1yC3bS2y5GCje3aX
         cZ1Dv1TrHVvf3a8YPKMkVVsvpb/uIDaoFLbcAK7fMHXI4l6fjz6xY/xCfyqsERM/JEex
         jZJbEZSTLCTtTlNYE+r3PlHZVOujNW2iOrUpR0RdTitvEsWTDl5eKCDP07FWI5aoIspe
         K0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207493; x=1793812293;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Bj9TlgMdx89QuvYDbkkZB0BkYmkkE60v8E9W6mG4wo=;
        b=MjG5agd4PXP8ZrWGWeZjO7mKvOrsZ91KyCvkekJu3s06VRl+yzB74ri/VZkkkBbZ/h
         hzZnOjo9BQ2IcNwVSypjofrr5q2jbQIrlbaQaCY+bykVCZZ32pYeCsJP1IUWtA8Ycx4y
         +jr0UNiQk/ndVcApLMmX6kBvZjxsIpRAXuwrm0ztpYLuHsCU0R8gevUVjXTj94dOWgox
         LSg+n9fhnB5DO+6hFq4bqZxGFIIOvNiwvPGf7GsRgbmw6MjBJYJjrYho6lpWaI/wbRLI
         f/7u23yB8C1sKqzSoX7HISx2NcjU6uVjFPKR4YGIPiV3bMClrjQxYBla+Jv9hhJgWHCA
         856Q==
X-Forwarded-Encrypted: i=1; AKwUvBy7BGThDLv+K/JONJuL6OPvFSnQ8j/j1is2NEIN6PmWfYe9ejLw/IvVGWlVbzC29rz03jLhM4g=@lists.linux.dev
X-Gm-Message-State: AFq9FYIveVRmqcqJD7GRNKTXYDWNIgZds6DI6TqNXn0g7DVu+q7E+V2T
	HzZeluBCKc5jp7ZsrrWqvHq9IDIVLsAkRlrNUIto/D3EyGBS4AjDYdw+
X-Gm-Gg: AYBFou3iGhGAHlWWV5ANDoOpEXyeKr2tJB8k5UmZGALl4lVFJGx74b3AN/qlUgDCmi6
	enWAQdb0+BCu7c04lx9B6A/RR8zi8/PzJoZLmsY7PmuyPuJ09Xc+EXqct5NOoXY77ls0O+Cj9/n
	asOecqjkCubsGodeUHXLhpODV2ib+VBoqPo1SQJVQNuwScy6gKilZ8Wu94zQLgKsNBx+0GEdmX0
	EzWteh/ut9Sxn6aToQ+MPaejWw4GkobK6owHU2bHGZrZGG/YhrfQrwEsJJ5+dY4hYalCpD8uKLP
	5dnDnvR+pRVg541r24aYEVR+jbXWqB08QLc3/K3QGFc+tMg1r19KgV5uZmX/2FWy18rDO3qfdvY
	dLmOZxTFvB0RrHxVGx6BnsF5wk89t//gdY8+N7kigny+AyehUWyu6TTd6Xrs2vRl3OmnW9anHCf
	gzPuTJrKxeI34OlnDyHMCdKKKK2Xhz44mMJ4mAtcZNoy/c4hTMjCn6MvhmX7yya3vFpqBxUHc2R
	Eqj2Cp/jpcUYCGQ1dlCk8EnTBZuqwKVOtbTOVx3KRdGFT6eO28+vqHucTbhtg==
X-Received: by 2002:a05:693c:6393:20b0:359:3991:ce1a with SMTP id 5a478bee46e88-36a30051a55mr162933eec.16.1793207492976;
        Wed, 28 Oct 2026 10:11:32 -0700 (PDT)
Received: from [192.168.45.62] ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239198c9sm7789683eec.15.2026.10.28.10.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:11:32 -0700 (PDT)
Date: Wed, 28 Oct 2026 10:11:32 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net v2 0/2] bridge: cfm: correct CC receive monitoring transitions
In-Reply-To: <179320630061.3327.303082876376528510@kernel.org>
References: <20261028164730.253238-1-pocj8ur4in@gmail.com>
 <179320630061.3327.303082876376528510@kernel.org>
Message-ID: <179320748112.254617.2096305115405815674@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Both issues were raised in Sashiko's review of v1. I had also identified the stale interval ordering during an earlier manual inspection of the CC enable path. I validated both changes under ARM64 QEMU/KVM while preparing the two-patch v2 series.
