Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252DB253951
	for <bridge@lists.linux.dev>; Mon, 13 Oct 2025 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358181; cv=none; b=UgQG4+obQjHjLC5klHP7571ziFsB+KLuDiDEQ5BGaB11MXv78FDwCoKHoiKqPuAAoCzafk7PN7Q1ckEoWhE4H0ZjpkIsyAw67c4ywmCHI5dg3/4Xhy1foyV7sgRfE54Xw4pyZuBGhrh7wv/SadMgNh8eHVUjKF2ZLE7a8SVrzbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358181; c=relaxed/simple;
	bh=Gn0eEfF7GOLkPlHIsKqjmnlwl8WmOTEyVrNvqmXwSd8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QwD7L5bZNTJQouf4t+8zOFzrPCwNsGgddly/7nDKM26zFzHNlPgf7ETQKxOclKaa1bLo578Xo7QgkEVe/GNiX+r7dSs44rIKreMTH2WyoLqAGgmSJ21mRAdbajeNRM54Ikj+hxYUFemjUK0P+RrdhnxnsZsim9HG3soaq+f3vLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JMPkFqBv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JMPkFqBv"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so4850768f8f.1
        for <bridge@lists.linux.dev>; Mon, 13 Oct 2025 05:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1760358177; x=1760962977; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=okdmUYlhFmHY6EW7sFMaABJgU4BMZvhN67KKvXy1How=;
        b=JMPkFqBvfql0ZTcRsshtVC4rwibDZxA1uXQ9MCNE1KJbw+m/HstJxa7+43dwRSzIWU
         rtKedR09Q4+tA73iOmFq+6w4QR1YvZHl3vJ1uecPFjYx09UgxU2zKzcgCBVuYbiiicxN
         8GRNPkERlpMKgZA+z614ZKbOXApfljyPb6k/p62siEuc+Wf6KfKjMGGXK1Gh2wD+60cS
         2dLc6f0wp3zunRf3/MG5cerAbu6jZDNMmvCHwGLM8MzosYVWZkMgL9/dg8JF2I3YMDY8
         52ePt01jkRhWNJxbPrsU5Y/HW/Kq/TKgk2EWABI0BOjS6VQuCK3pq1s2UVzfbGJjwq5W
         KFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358177; x=1760962977;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okdmUYlhFmHY6EW7sFMaABJgU4BMZvhN67KKvXy1How=;
        b=DLBGOWaGVo9vM2D1SjhYTy5JvOB9pywJGF5i7R7NmZg9i8dJzRkXHjGUrC52o+kKeP
         /wuTjNif7lKLhpDjQcTtm8zIgJmLJTh+DPSDtKRVvgqzmWNTEVXpnJxKVcAPthUZl9k5
         60lV7scIMWSJR+sFvUJkL7SjK9X2uvn9PCgna5EhBoVcSdbJ1dcug+Itb1fg1SMHiB+8
         y1rVExQpiH/rGdyBhhnscjYvDbxu6QUfzsjvakmLyZ+ql5AsLyPFp3/oCR5LtENrFB1x
         z3C1ycr0SLj81P1vB7HPFp3YwbHmuKNFL2ms53C3Ow/bqzk+LVabY2w+d7Be1YIsrGHi
         X3cg==
X-Forwarded-Encrypted: i=1; AJvYcCVgiIJ7xDaQir6awT8wyHCvL+FGYM1KZCr2xn91TZz4bP0Nh5z2fX5lQCkFBbn9rxHolRK6pNw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yww9+a+PD0yU9WuGnwYo4xz+zbrVHRDjAEmnD6h6hES22gJXvrT
	WXEB+7pmW7cWcIEJ7YoJoqA3rmcM1EG3/tRfM1i7Fs5cXK+wYOfppAiB2/64QUhbS5I=
X-Gm-Gg: ASbGncsB2iMc02+ue0KQLTSF+0FLA4gCKsmVE7aB8d7FyHYvw6Z3zFF4SXJKk7Y1IwD
	/P8oBddyhi3c0JLyl6QD1JHRAORiLUufJrU2xEEFaWDk+RlvPOg3X9a7KsRof7rJZq4snLJy3qK
	RMLM2FusB1+wElLodIPOqUhZoBl7R4oULazI8Bt2l2okXxHr6E3NxDJD/SdCHZ0DAgTGmZa+nu8
	p53F+I1IA1AgfJFlyWaRwpoVdcw/P+5JFjuwJAa3NZZ+5MmNL3ZeniUbOGhMn2lMqpyxXwFuSAS
	xdSIX44zdCsoi8Oa/4H5Lknpwd/ZYVFa56mdSkpxWYLKH/3PJr8UjK8rWiqivld7ksrq1FLYG7U
	gfnzt1ReXfI0YFtG9DzfPwcTs0qEwBJs6nSsjZ+2DWTK6q279og==
X-Google-Smtp-Source: AGHT+IHr+wgXBWFp5s45MhtPrwaRVRuqKDLgoBhkzcLLkcJ0zROOkiOZDmrmpFdhFhrJJpDhZnRrtw==
X-Received: by 2002:a05:6000:4285:b0:3e1:2d70:673e with SMTP id ffacd0b85a97d-4266e7e0012mr11904012f8f.37.1760358177089;
        Mon, 13 Oct 2025 05:22:57 -0700 (PDT)
Received: from ehlo.thunderbird.net ([149.62.207.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e81d2sm18220967f8f.49.2025.10.13.05.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 05:22:56 -0700 (PDT)
Date: Mon, 13 Oct 2025 14:22:54 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, bridge@lists.linux.dev, netdev@vger.kernel.org
CC: alok.a.tiwari@oracle.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next=5D_net=3A_bridge=3A_correct_d?=
 =?US-ASCII?Q?ebug_message_function_name_in_br=5Ffill=5Fifinfo?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20251013100121.755899-1-alok.a.tiwari@oracle.com>
References: <20251013100121.755899-1-alok.a.tiwari@oracle.com>
Message-ID: <14468513-2D16-4A19-9173-80559ED580F7@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 13, 2025 12:01:16 PM GMT+02:00, Alok Tiwari <alok=2Ea=2Etiwari@o=
racle=2Ecom> wrote:
>The debug message in br_fill_ifinfo() incorrectly refers to br_fill_info
>instead of the actual function name=2E Update it for clarity in debugging
>output=2E
>
>Signed-off-by: Alok Tiwari <alok=2Ea=2Etiwari@oracle=2Ecom>
>---
> net/bridge/br_netlink=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/bridge/br_netlink=2Ec b/net/bridge/br_netlink=2Ec
>index 4e2d53b27221=2E=2E0264730938f4 100644
>--- a/net/bridge/br_netlink=2Ec
>+++ b/net/bridge/br_netlink=2Ec
>@@ -467,7 +467,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
> 	else
> 		br =3D netdev_priv(dev);
>=20
>-	br_debug(br, "br_fill_info event %d port %s master %s\n",
>+	br_debug(br, "br_fill_ifinfo event %d port %s master %s\n",
> 		     event, dev->name, br->dev->name);
>=20
> 	nlh =3D nlmsg_put(skb, pid, seq, event, sizeof(*hdr), flags);


Acked-by: Nikolay Aleksandrov <razor@blackwall=2Eorg>
