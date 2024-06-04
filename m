Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC329CF0
	for <bridge@lists.linux.dev>; Tue,  4 Jun 2024 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510260; cv=none; b=O2Mkhs9887GZ0WyxkTRjyDiL8w8x8eCzbKSfv7PMw5G8LnBhPiOVB1A5A/r6GyPWOhxOgh+YZAa79oaGtBNBSEeJhMprO15BJsfq6+StkSHWtm1S4kuMcyCW1vM6AGlrjcejMdT7qk01PHBGRViybUgWcaolFsseesz7/Y8ADz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510260; c=relaxed/simple;
	bh=6cmXp3he9brpWOBwHop9iE26Md4KGRFmH7CoNQVbpe8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=g6qw8HXRRPeDvOny7TgFaysBgeSUjMH9vy0KnbssnrFEv4cZWqaF4i6gA7sXbsfzf33h9E6L+ipWy1y0flcWP4ioQw2kFcta/5NUX3b7NBJt1iZIVKWBaNMxyERJLkHf+dfYhRQ6MQbZGOEq1QZiQ5Xaxv3QSdTTIaSg7XcFDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=VKFgDAXE; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="VKFgDAXE"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eaad2c673fso37978621fa.3
        for <bridge@lists.linux.dev>; Tue, 04 Jun 2024 07:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717510257; x=1718115057; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=baFFAijHHZMbMbOiyZjBKnPAuN2EF/pC6FwbCPVRy04=;
        b=VKFgDAXE3gSe4nuYFvzUE7ri93yyrP2nF83+CHcAiPf7rHYfl7ubeRlhnk0v/+8D5L
         wrz+YRgH2ARUAZBG4/q0P+GHHxz7Q/zXXzUBb/jIuN9JSZHcjuUpnUum2Y4Ygw1K0+0A
         amO9AiG/bqHmZyQtLWoMuu+oWqh+KXKZSwtZwNWQVZEcHT1h4+mvAlF0iqGWpAXPXPIO
         eZKHHBeVRQ0ZirTAjuzcovWmH4Abp8fzjxKd1Z4LG2fljlhT1xdqbKZ418mab29qB5/s
         E7YfxNzmQleHY6GA52/cGzAsFz0/uRwY/cpZsHJvO8pZArIr9hDzLPnRyJRSMozX8sot
         QVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717510257; x=1718115057;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=baFFAijHHZMbMbOiyZjBKnPAuN2EF/pC6FwbCPVRy04=;
        b=P729G/i2r2kwu8dvhSas26MBs1KLDry4TxcOLSP6K/9+6ev3UXO/JWfnLZXX8jkIp0
         i/LLV06pZadtbqzWi3JPRTk9gDxbCrv5qR3Hs+WdDIxYNeFHW1gIynvZ9NZ+eTZ1kDBr
         +JXZyC6pQu/zhX5Tx3qWzjPiYYGCjEyVdqXJGGQDE2M2wyeb3q8lX9oX5JhMx+8igTDC
         rMQUvV+l/czVzq7Wv0owA0EcwzMd3pCkH0TGba4BLj8aOpTX3J84jyyM1kFuFRdRXjlP
         u0GcXLyEGUyqPFfDFrQphT4IJqGWXm3I/kjFf9WVxY8AVzuNY700YVmziDP+9ZT3QbcF
         8b5g==
X-Gm-Message-State: AOJu0Ywfk9oeydEhvbnK0HqcRS2CJyupJyLagR0MCkLet/xxg/Jf6MgB
	opNFgm3Yl0TaU4ZCAeakkfB6rB+S+CMYldMObOduNitTAVA3jwJFCdrVlrgMe0Q=
X-Google-Smtp-Source: AGHT+IFGi/nRxSt8VzqDMp2GUHMUGUhYLVn6chJnQfDA05ayGELL9N8JVnwgFNAMyYZXf4dXOXeVNQ==
X-Received: by 2002:a2e:2a43:0:b0:2de:8697:e08b with SMTP id 38308e7fff4ca-2ea9515426amr88035371fa.26.1717510256849;
        Tue, 04 Jun 2024 07:10:56 -0700 (PDT)
Received: from [127.0.0.1] ([94.131.244.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68c5c523b4sm467216366b.11.2024.06.04.07.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 07:10:56 -0700 (PDT)
Date: Tue, 04 Jun 2024 17:10:52 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Paolo Abeni <pabeni@redhat.com>, Chen Hanxiao <chenhx.fnst@fujitsu.com>,
 Roopa Prabhu <roopa@nvidia.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
CC: bridge@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: bridge: fix an inconsistent indentation
User-Agent: K-9 Mail for Android
In-Reply-To: <179c9ada55ae686f8142f3fc78dacece2db4f407.camel@redhat.com>
References: <20240531085402.1838-1-chenhx.fnst@fujitsu.com> <179c9ada55ae686f8142f3fc78dacece2db4f407.camel@redhat.com>
Message-ID: <5C3E0B27-B3FF-44EC-98EB-FA43B0790957@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 4, 2024 4:57:12 PM GMT+03:00, Paolo Abeni <pabeni@redhat=2Ecom> wro=
te:
>On Fri, 2024-05-31 at 16:54 +0800, Chen Hanxiao wrote:
>> Smatch complains:
>> net/bridge/br_netlink_tunnel=2Ec:
>>    318 br_process_vlan_tunnel_info() warn: inconsistent indenting
>>=20
>> Fix it with a proper indenting
>>=20
>> Signed-off-by: Chen Hanxiao <chenhx=2Efnst@fujitsu=2Ecom>
>
>My take is that purely format changes should be part of
>larger/features-based change, to avoid any later stable fix harder for
>no real reason=2E
>
>Thanks,
>
>Paolo
>

This is new, I don't see anything wrong with fixing bad indentation=2E
Waiting for a set which touches this code which hasn't changed for a long =
time ib order to fix it is doesn't sound=20
good to me=2E It is very trivial to resolve for anyone=2E

Cheers,
 Nik


