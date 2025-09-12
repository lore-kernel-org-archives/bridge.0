Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71727604B
	for <bridge@lists.linux.dev>; Fri, 12 Sep 2025 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659939; cv=none; b=tf4bF861s6G5pRUFMWWgGm6TdN0YPhcMc7Yg4siasYdA6j+XxekY71jio/LVffV6ONcDGpRDTO2N++YE155yyhdbbcNpTSh9f8DTwTt8eRl5U59RpJ7wtrxWDEfKpMo8l/j3ghnYqnp+hu8Bxikuby3Kcn8pNLKctLLC/66gF9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659939; c=relaxed/simple;
	bh=bgA7oeKcoI74Kzo7a+VO1L2J+jX4JKrjzRtTf5f6UiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFccxU5VGI8jpeuQ82SYb/zjkBJlR8hdCYXZeqSw+8qWb211igkZlDRmxjoDswdCNzf4Sa234lPI0B+FWQ9Upjg1vRes5MW3cuheczkc7S/wyyXEpVAGE175hx5E52ikYA52YsF2K3wDqnb3DTetQfkqJqbikv9jadgUamGTzsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoOGp1zh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoOGp1zh"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24cbd9d9f09so19992285ad.2
        for <bridge@lists.linux.dev>; Thu, 11 Sep 2025 23:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757659938; x=1758264738; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwSUuAEjcjTIxzZpiWZBKe297By4Ddz/ibr+mskNrrE=;
        b=JoOGp1zhKPAlju4ijf3KhBjPueRQJ6TQ5z83cxymSr7XeOtg5AR0g22mHDeeY8loB5
         4K6LhONqNjXVDDHfQplADkVFItgjxmwQTIDPPwoInPzCuF7ingOTcguJ7hE9e5r212m9
         qBekmvX8/SPwotZ4v2sYuN0h43PCwMZZZwjpzf77Lku1UVW0iM3Zgz2HJMDpcGLPi9Me
         FmjpVYcr4ZNebcVrdNZd3i57/K2RTqBzkAWC8EWhvO1EP9IFrW2L7lyamDU/8Id0ALnA
         5aG7fUxDYqpCan6yovBEg90f7M+lU9ObMOAgSX8AY4/viqYzQEhqT7ZNPlasYF1s9mc4
         V9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659938; x=1758264738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwSUuAEjcjTIxzZpiWZBKe297By4Ddz/ibr+mskNrrE=;
        b=vjk+YqSBCYVs+CXa8Jj2xOxhkk4cfqZLx6ZB02naJuujDL5nEsySS1x0JuM8hUInUd
         LIrmoW7JCsxe8MdS0ij1Ew2miwK148rFqt+kCViZbcHtL7cGd/jGNP6ZoLbunP3gcesi
         qC/cQjUwYDuWlFSVdJksyRUdzM9i2yUKZ/aaBO7JlIfjfhCN1LPc3MMcEOQXjr7JcH6+
         zO+jDNYhCjTKB6oiHpYaybdwQ7jcmXK5Hhm4ZhMU+NsY3zB2GoU053/bOP2V/rjhCpcs
         uCe2+8vbawJlQMprUzbqzHnBS++AtjF+dB91hu5kEQqiTKgsxnLJY6QjgLG17Xd0giku
         0E/A==
X-Forwarded-Encrypted: i=1; AJvYcCUIn8zzMVsyhC9r4ACrnKcNbcR3FBhgMYHjN/cK14lunrEJMjBWXQOmN24nggSfvdjM0cOnb7c=@lists.linux.dev
X-Gm-Message-State: AOJu0YzdbBEuqV9an9FTHvFIMIRGgW1vT5ui9QMSMS9qW2zHZZPkTrnj
	CP5Ymm5K5pBlQZYKh9T//Z9SEQdlmCVD6K7XITSFcaXJ+TZbJOq/wty2
X-Gm-Gg: ASbGncvUy4gsjLDNTCjFcEuWzy/wsWef7KQEwN3Cx19KhNO2t8eYQKMXPrrv3nahJ6+
	V3JGbizCzVmX/kUic6XnuIZZ1c/G14XzMJtBQASGm7+2fyQwGON7fSCsagVZT6d/bp5zCwMBSMI
	19zKMtF6mKlR3HROgK/+LXlDMjDnziTFwulJW+m69Fp2nthtAyK9fqs6t0ioLn5Fv0YYyd1epMA
	hlBeF5wHuqGnd/ob1w2dGGQvghHW4atevSqKqId3dQYJLkiuuCjOUUINaGBSvFLyhZ8N0VZSjeP
	hOtYw8rPLykXlOVh9vmfYi23eQQOeVRhcpCd7oMh6qj8qLure0K30ICskTybN5ZtW5T2PVtqdbK
	rneRJ0j4ufZLkaDn1bndrWlQuXRU=
X-Google-Smtp-Source: AGHT+IHrDf1vgwZ8m37UnyFpShDL+qgeK60YNqoW/4e1ULDVWOBg/Z288AueBN0rg3nJhTizvO2Kmg==
X-Received: by 2002:a17:902:7d88:b0:249:17d2:ca04 with SMTP id d9443c01a7336-25d25b899a7mr16236035ad.23.1757659937610;
        Thu, 11 Sep 2025 23:52:17 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a46csm39131745ad.91.2025.09.11.23.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:52:16 -0700 (PDT)
Date: Fri, 12 Sep 2025 06:52:08 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net-next 5/5] selftests/net: add offload checking test
 for virtual interface
Message-ID: <aMPDGCyoPwNTWNXq@fedora>
References: <20250909081853.398190-1-liuhangbin@gmail.com>
 <20250909081853.398190-6-liuhangbin@gmail.com>
 <aMGR8vP9X0FOxJpY@krikkit>
 <aMJyC_YNjVWcB7pe@fedora>
 <cd37574b-0c15-481d-84dd-8ccc830efd06@redhat.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd37574b-0c15-481d-84dd-8ccc830efd06@redhat.com>

On Thu, Sep 11, 2025 at 05:41:24PM +0200, Paolo Abeni wrote:
> > For mpls_features, seem we only able to test NETIF_F_GSO_SOFTWARE, but I'm not
> > sure how to check mpls gso..
> > 
> > For hw_enc_features NETIF_F_HW_ESP. Does sending ipsec data and see if
> > netdevsim has pkts count enough??
> > 
> > Any advices? Should we just drop the selftest?
> 
> Uhm... one possible way of testing netdev_compute_features_from_lowers()
> correctness is transmitting over the relevant device (bridge/team/bond)
> "arbitrary" GSO packets and verify that the packet is segmented (or not)
> before reaching the lower.

Is there a way to check the packets are segmented over bond instead of lower devices?

> 
> GSO packet injection can be done with some work via the tun device (in
> tap mode), and the virtio hdr.

Do you mean tap over bond or bond over tap?
I don't know how to add tap over bond.
If bond over tap, then tap is the lower devices.
> 
> That is limited to some GSO types (i.e. no ipsec pkts), and can become
> easily very complex.
> 
> What about giving it a shot for UDP tunnel GSO types?

I'm not sure how to test tunnel + bond. Setup vxlan/ip tunnel over bond?

Thanks
Hangbin
