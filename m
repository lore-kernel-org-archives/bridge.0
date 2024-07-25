Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79BA77104
	for <bridge@lists.linux.dev>; Thu, 25 Jul 2024 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938310; cv=none; b=S40S1IvRYxQn9LRmZSuoj/oBvi0KVfi2lcatHzVYovWBr63t8Is7fOIuU/p6zWMFdwIzBinVSa5OOdnel9kmE6aDA9xH3JtKvyntovbr1zd88UKi6EImeG7OiYRCUB+wJYA8Eyay46PUwfO2KypDbLYQA+wIthP0UJDfxXTuAec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938310; c=relaxed/simple;
	bh=IvdqZvTacjy6MAQ5qDRh4fw3aGKlpJ5TgBBkoXVfd24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtNe52E3xjIZEqBUM/tC7maNPhLRTFL8HJUHYXTuN1OREZqmj0g4XfzhFGQYGDO5IlvVyAPGbJct7FnFtTGXij/h6twZ4nVmHWZo/jLKcusSBfp7Fz/wzQ1qhjZDWJMorNDKeHgDCd0ncT4dqF94FkvP7BMedcmOO+jUoZO29qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d1nHNUeG; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d1nHNUeG"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f025b94e07so6579171fa.0
        for <bridge@lists.linux.dev>; Thu, 25 Jul 2024 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721938307; x=1722543107; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=d1nHNUeGgw3W9YGmij77NpH5urGBjjB7jwIftMYCA6h0Ce3quDem+2kdSyrtbqkZ4e
         BB5DiNP1Im53et4u9mBEtENey8uHGKnMQjs9MO9Gxygl+HGKokHXN/30NKxRsV8AB+Sl
         eVeBLklAHuW0tiwOAezuBen3k6v5W+tSOHD7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938307; x=1722543107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=meVBptqwMbqc2yp89CfeWHip9PUFbNFIeqpIiG7YoFq8KDXbEZicQ6LT9FYd/oE15Q
         BFKmC+ZcR9Q+9r+ZLv5yQ7xlp/PtBuXKQXRcdaAdwjxmB5qyXrtfDS0mXTIzakKb+FFH
         NWYJWvTIZKX9wYYmdWjg76WJfveTpFSsqQqYjUeoWEUaI4p6bcyWuYNxZwV9IildrfgI
         82WL/iyX719jVS1IYe5f0WAQbgz7vVy30ZwW1WPo5jJDRBAF3lOhY+QHKyF5JNXYmLFy
         fMt5nz3xT1F0vWg4lO+M391lAjFaozzmce24e3LyflO73GMP73VfEUKlWXmmPIoW90zC
         6pkg==
X-Forwarded-Encrypted: i=1; AJvYcCXJZTEQNa4SvMUwI0CG7etaibdNXVuKuDG2/g8pxA2TrYmBQTIgw4xZWmYKLnj9aWyCwqQEjcclwQX4t/+vnSlR7JP+tTFL
X-Gm-Message-State: AOJu0YzjjcuJ/j2jRZvIzQE3NZOuv6gG5+FKSuF353f4Hm7R8nKjNNJ8
	qqV/hkX5k8+nSrqqa+L6cpwTnbVRFHEomVPbX73gAe4FR+1z3WyWeRhRqGL3IK/oLG+7u+CLDnT
	UeGw=
X-Google-Smtp-Source: AGHT+IG1B8neMreCB8W1LzPiofH2ZWeybEhOBWehw/Tc6l9QCWnBg06rRDvgzUMGigVQ2gqDF3mvpg==
X-Received: by 2002:a2e:97c8:0:b0:2ef:265e:bb8b with SMTP id 38308e7fff4ca-2f03db7dd2dmr22412221fa.18.1721938306849;
        Thu, 25 Jul 2024 13:11:46 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3cb8sm1105777a12.77.2024.07.25.13.11.44
        for <bridge@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:11:45 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc3447fso1625017a12.1
        for <bridge@lists.linux.dev>; Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBzFVxann3ZmiwB2ztdvVNoOLI1BgoXDSg6DUnAmu8VxpM0ui4V+T36yUUCtCoQULPtnQB5ZjmYDozzYAGq9HMzfwgJvp2
X-Received: by 2002:a50:a686:0:b0:5a1:1:27a9 with SMTP id 4fb4d7f45d1cf-5ac63b59c17mr2468749a12.18.1721938304541;
 Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61@eucas1p2.samsung.com>
 <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
In-Reply-To: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 13:11:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
To: Joel Granados <j.granados@samsung.com>
Cc: =?UTF-8?B?VGhvbWFzIFdlae+/vXNjaHVo?= <linux@weissschuh.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bpf@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
	mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 14:00, Joel Granados <j.granados@samsung.com> wrote:
>
> This is my first time sending out a semantic patch, so get back to me if
> you have issues or prefer some other way of receiving it.

Looks fine to me.

Sometimes if it's just a pure scripting change, people send me the
script itself and just ask me to run it as a final thing before the
rc1 release or something like that.

But since in practice there's almost always some additional manual
cleanup, doing it this way with the script documented in the commit is
typically the right way to go.

This time it was details like whitespace alignment, sometimes it's
"the script did 95%, but there was another call site that also needed
updating", or just a documentation update to go in together with the
change or whatever.

Anyway, pulled and just going through my build tests now.

              Linus
