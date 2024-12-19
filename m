Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5872C2163BC
	for <bridge@lists.linux.dev>; Thu, 19 Dec 2024 05:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734587685; cv=none; b=VgDNhM0s+PsxZqLCOj/tF4gI9vCicMICCzFDW9waZL/xeLfT3NU2y0i3pzdWHq14bCaGeqINlkRlba39kxTUFdgIb1w1KuLR93Jb2q9l6KgQ76Y8NfqnFCANrxKhjobDC5l9l6OnR3+41gNb6A+j5dx6yogJEdgn3rgp9LGnTac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734587685; c=relaxed/simple;
	bh=VsNY71lG5lYULBvFXVp0KhrDlqgduRP+ORPVKzySpuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4TG8q2+fM+C1GGV8wDPlnogH8WkLThbfP4//vTctqqkUP/XcGXbDjb0KMptYl3zCV1EeKuncOboS1JwqfNFcVKrngKDNHO3voZ6AP0e0ji4qUR2bfuSIQR4CL4n8oeJyMNTmaR/7gvyKamgkA+jDvPgWsKVY23t1gGot2D32Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwVwvmbA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwVwvmbA"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so4487335e9.0
        for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 21:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734587681; x=1735192481; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfCpfOoSh8ogvEFAzzK5Sh/fDzaPC/IoHjTWRLgy2Xc=;
        b=VwVwvmbAS4W81S7rOaC2n71lL0Y/6I5VeF6EqMpP+29XZyDXvIzNZPp9RyOe3ukiZX
         udYEeVONLsJ33H9v3kRejr4gqTDPNH44N19LJizHXxKKZWghg2/rqz5QXLDH7iG8xrit
         hLqJy4oQrNb7qL3UlAgnm6wPVhpB57Rlqt2v5ZTTqXlBpXvXHm2jLvdx/J8UHYjs89vn
         U6PQ2eEacwWcSILZnDhYAc4KZOQQQ+NhZ78Qj1isTC/VGBae9SE1Sujabt1S6nS+jX6w
         b7fCEPjF6cNjncBV4651H7AdYhMWJQC3O6AbfudtD9ZRScS3yfqX+Z8H6GTNIpzs+thT
         4SCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734587681; x=1735192481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfCpfOoSh8ogvEFAzzK5Sh/fDzaPC/IoHjTWRLgy2Xc=;
        b=GNogfTRcSiC3HHneUF44e7XHX928BJvGNy7/p/OmWCL0f9xOvQDatd3KmFl1toS530
         4qiAq+WHKUWQFd1WQLmHPNrNw4gCa+pKoCsNTq5Zr90M4+1GbU121hM6F7UBwLx9o8yd
         Wq0U1ABmWdBY+J0F3sNdjb7oZLZv0VHlc0gtbtQffxJpsfhs6fw527yxeGkhqMfGyjsx
         IfKnMHiNIlaqp4qvQHVCtzWLXsr1pscIGJqKgthTlffoGw7CRlBTeoFdSioNHkb5b7WG
         ga6x3sUxvZSEDW4n9ZXHU2OClBR7rsnugtIZBnR6tqkHqdhtsuBsGMkNfDtGwojGJHw3
         BZZA==
X-Forwarded-Encrypted: i=1; AJvYcCVotKLmeN/tSYIU/bJFfQZrknr/x/5SPAD3LZ1zPrFVZrAUXoG2cWWcz0hCVtHPjnUciFW8ui8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0HLHthM2Yhmpv2SXlYMknhj7Kg13LaohRzQcU2jOVdBDB23og
	+K/jE0ZwbokEQnxS/cXMkTiTI3+DE1quiNjzcaiDNjYD2P7qCCo5mdS5tCCBnN/rCK3gtjxDgtC
	9flpSJMy1RiUD1fylZc8lSW+Pcxg=
X-Gm-Gg: ASbGncuxCQT6HHGdU0PawGyxM8+pOjg7riFfSfXCWRfdS3T5/JKhvLD3fHLz5FxLaaw
	GBz7IsFz1Ub5OI4q7nK/fOWPCZQdwPWEYISEW
X-Google-Smtp-Source: AGHT+IFXswhNY3wf74HiVRQ6mWtI+LQ0dYPzH2WDbrTkg0k3vCjw9PHsmFSj9uux2yKPzKWzDIYRJF3gX8R2i5iXHRM=
X-Received: by 2002:a05:600c:4ed2:b0:434:f7ea:fb44 with SMTP id
 5b1f17b1804b1-4365535c6a3mr52447275e9.14.1734587681279; Wed, 18 Dec 2024
 21:54:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241218130909.2173-1-shaw.leon@gmail.com> <20241218130909.2173-12-shaw.leon@gmail.com>
 <20241218153759.672b7014@kernel.org>
In-Reply-To: <20241218153759.672b7014@kernel.org>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 19 Dec 2024 13:54:03 +0800
Message-ID: <CABAhCORszq9ao3OCVW-1EBsxsnLxbQ096eV+cbs12Es2HvCgUA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 11/11] selftests: net: Add test cases for link
 and peer netns
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Hangbin Liu <liuhangbin@gmail.com>, linux-rdma@vger.kernel.org, 
	linux-can@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org, 
	bpf@vger.kernel.org, linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com, 
	linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, 
	bridge@lists.linux.dev, linux-wpan@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 7:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 18 Dec 2024 21:09:09 +0800 Xiao Liang wrote:
> >  - Add test for creating link in another netns when a link of the same
> >    name and ifindex exists in current netns.
> >  - Add test to verify that link is created in target netns directly -
> >    no link new/del events should be generated in link netns or current
> >    netns.
> >  - Add test cases to verify that link-netns is set as expected for
> >    various drivers and combination of namespace-related parameters.
>
> Nice work!
>
> You need to make sure all the drivers the test is using are enabled by
> the selftest kernel config: tools/testing/selftests/net/config
>
> This may be helpful:
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-=
style#how-to-build

Thanks for pointing it out. And vng is really cool. I will add
the missing config in the next version.

> --
> pw-bot: cr
