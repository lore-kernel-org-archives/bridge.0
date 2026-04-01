Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBFB361DDA
	for <bridge@lists.linux.dev>; Wed,  1 Apr 2026 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056045; cv=none; b=H2hygv4vrEl5dNYZH4LK5o1xkEGmJmJG27kiXeyNLYQ4xZwA5NLHRlZlNVJg3gZh3ks94oAnJVgmYDbP0w4udx/OzYA0JTueinV2kpz3s8Raxnb1XQI12gNkmipZT/+lhdnNOg4WHpsYDRIP8MeJgexmnWn5dL6T1Oj9x6Uw9/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056045; c=relaxed/simple;
	bh=bjcwsYJwkpqzg1+Jd+PAkNPiIUaqng2IgQHyEKuA3jU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ku1R44tnczdC1ChV19bo40RoDgD1poVjw7WuLP3e3JgHdfDo0MTYRhXD9ij4zDRihBwVlHZx2mU6n7bXCZz9LAkNY1N44JJ9ctK8qmIXUeWuxG/zKmo5F93YfzDjTQcatVo1jx3SczQHO83M0fW9Mcv5j2DBwEI97gAr8Y/HRG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=fhphc8l/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="fhphc8l/"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so4203924a91.0
        for <bridge@lists.linux.dev>; Wed, 01 Apr 2026 08:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775056044; x=1775660844; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJuOxpA+gsO22gNPhXzJ2+Gj7ezb5L7fZMCH+oDlAG8=;
        b=fhphc8l/vKD969uZupBar7x/T3fgCAeEJoFL9aSd3NXh/y5jhrDiXX5liqcseQBpRC
         7Z2DOSB0XQzaNx1SUiR4HFr8RBPJcMBoSiKHlByKXqNKfxTXhVM/tmpDSKaApDZm6J1O
         W3bIrgteIDwW/3LkA0GYYD16X3aQ2JGp2wSizciGyt1e4zgzO43hO7dMsHNbnTjy0FaT
         Vd0IrruUn3TQMWk1I2jqKLBE2BY5fyt680J/2ZVIaflLXOLT6UO/bHiqN7LqkQOhP8Me
         cEuwKhuE9oD+hon6IqwH0NUqXHUjC1kQ4VzyhUXtmzfTDxr/W4hlAqChUe09FeIsH+Ex
         ORjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775056044; x=1775660844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QJuOxpA+gsO22gNPhXzJ2+Gj7ezb5L7fZMCH+oDlAG8=;
        b=rONYXUhOaxy/+zq/o9cKudlb76+lLJrsMLKW9U2jEv+cDiXo36bsx9MZvjUTuzgC5K
         zdXhTBD62Btx6S8WKkOmso/jly7rHHVXO23xCdqjt27rBaufByyB/ga1bYtZRjFE7mxr
         2Inkh2NsZYgGg8KbWgOQ/ll4/Up0rqmR0y0Ysnh+8SnWWjTFVJWg8WWdzfhviLsuZMjg
         zyI9zUusU+m36DE4MULh8KasKmxUi+bMtLYEst68hUKYt8znCkpAl+dCzeooAwxQs5I4
         7arBP5luodNqBjGcPXI5tcQKvm7rbO/D2LVI79zFVa392wADQ6/h0sOJiKd2gc/mmVBq
         XkVg==
X-Forwarded-Encrypted: i=1; AJvYcCUZOYjMmgTDhdY8LQOgoAD1JnU5PEncYq0ZB/UuezE+7pZ3y2nrq3azjIVEv41KiTNZ075QhME=@lists.linux.dev
X-Gm-Message-State: AOJu0YyhCStR5Ca5HUuH/tCnHRrekHO0HBtDyII253ywgUXN6aY5BTyH
	X9APiU5gAbnTPAYz6nIRc1T5dtiLSMYauNiy/vh5Mi8OI6Wt9EEFzjj8MskdXvhTQko=
X-Gm-Gg: ATEYQzxuhbwAWCqOt0mlKweGPeW9DEwq1rctfZ3oR1homsPzps8PDwqdLLySEHjizb5
	PIP/LYUsnNijCv9O9XZBrv+VzdVgGrhrNfpQMoBUo2m5adZMlyqwJxgm8MBEp08aCrE9/ecO2nO
	PUo/c/lgh0k3WFh/Xx2yQ7hm4juNzgQAHXtogMRjMwIyfgkrdWp8pk3unIfCamdZ/E4Jcv/vzdN
	PjTznPu1zOrkoARsgG+HBCwAF1FZ26WR9SEtC1wd9J33YLvGtLkkLdV+rhB/uvNI1ls6IfJtLX6
	8oKoXwPIn8xiHu0FHrvVuYBQeG1N7sx9LFnaWOL02uO68e5L5UdS6Tab5tgQaRdsrNeCzHwjHio
	+jEBXir4SwJPiV1d1Ss7Riy4GcOX13Z2rtX8LhYtArqV789BrcpJGuVVMRb4UwusfREfTcXZqk4
	QYgOwcs94+REl4/zhQheMje4eu73x5IZI6OMfjEwKqHC5EKw==
X-Received: by 2002:a17:90b:3e4f:b0:359:fdc0:4621 with SMTP id 98e67ed59e1d1-35dc6e9b097mr4036315a91.11.1775056043722;
        Wed, 01 Apr 2026 08:07:23 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe623754sm5043344a91.6.2026.04.01.08.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 08:07:23 -0700 (PDT)
Date: Wed, 1 Apr 2026 08:06:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Johannes Berg <johannes@sipsolutions.net>, Pablo
 Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil
 Sutter <phil@nwl.cc>, Guillaume Nault <gnault@redhat.com>, Kees Cook
 <kees@kernel.org>, Alexei Lazar <alazar@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 oss-drivers@corigine.com, bridge@lists.linux.dev, bpf@vger.kernel.org,
 linux-wireless@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
Message-ID: <20260401080657.70cd9bd1@phoenix.local>
In-Reply-To: <252823d75e9221647e7f8ccef6105432aabe8d6f.camel@infradead.org>
References: <20260401074509.1897527-1-dwmw2@infradead.org>
	<20260401074509.1897527-7-dwmw2@infradead.org>
	<CANn89i+GHkkubJp3MTKZ_r4tde1qLejfsxUh+w0gPZ3ec+YdjQ@mail.gmail.com>
	<252823d75e9221647e7f8ccef6105432aabe8d6f.camel@infradead.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 Apr 2026 10:28:23 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> > Some kernels are built without CONFIG_IPV6, so this warning would be
> > quite misleading.  
> 
> Maybe on this date next year, we could make it not possible to build
> the kernel *without* IPv6... ?


There are some government agencies that used to require that IPV6 was disabled
for security reasons. Yes they had broken old firewalls
