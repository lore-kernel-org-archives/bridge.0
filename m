Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FE91AA78A
	for <bridge@lists.linux.dev>; Sat, 30 Nov 2024 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733007816; cv=none; b=EOLw7InlfkrVxYNy3FIEXBKXhyh+1CvYdmwAAXCCO7WlThKRLHWUllw8p0i0Eo5eqi51o+qCXvI8LfwCaKBcCjlibgaEfIfFlV6JvS5HEkzmyh6z8slzs3s1L37O2NZzU0lvmNWrpDdZutDDm5NZ6V6IYJZL0UnVSHvL/B5ZFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733007816; c=relaxed/simple;
	bh=Oj23kvXML5YxbzImIPjLr7bu4A1f9m4DYN95To+LWn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eez+xYfYUpOIfDlpJm38m5/Lxumds87wNXPmjwbfoc3MMFiQxIXbvO3TNgM4Pmpms6JsbaEF4vvdS1Nud2q6/yE66gzdswMWnXupYR46Qpg6msA7bBs6BSw9Ug3pta+MiBK/ebiuC+g6uw1d8OxKf7V0XE49UR+PKr8dTIAw1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=bn4lj9E4; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="bn4lj9E4"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3970ac2dddso2348979276.2
        for <bridge@lists.linux.dev>; Sat, 30 Nov 2024 15:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1733007814; x=1733612614; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+lZDk59n4UHv5yZ4bNmxMnAKZtUzjiM3soOA0zJRIR8=;
        b=bn4lj9E4dYyaBxaytvu2gB+mCfTI+kOI52i8zM1yS8Es5WxubEMiAjVTWPE1rRHMQA
         YtVqOOVEYDIi5zgKd5CCs4S8hjI9QJFGn2dRHfLXwmUx2uv/kRGaFJx42X2Ux/bboDtK
         LbDm1c52gFLHX0OxRBMbea/KMZq3J9FLu8Zyuje1MOBMkfT26MGV3rSKmZfiOfCwojVN
         AL+RnOoLb91b/N15gnsbojMNroLAsybTIn2z7uq+HNKAa5hyAwMvT+lWkRXgVkGs0dfE
         hQEKmxD/vgleZT4zEN0dCda4XgYDb4kXKk/q9OtFmhQL2xlobw3e8TRFstNP/3HDVQRT
         feig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733007814; x=1733612614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+lZDk59n4UHv5yZ4bNmxMnAKZtUzjiM3soOA0zJRIR8=;
        b=k9LXw228GP+jgMiZCOFmkcWnviULWr7YPq0fo1/AJNlt5b4WELYcuk5KX7H2BIjxQq
         bS5CzLaX2/12urHeBed6eqW8cGJfNd4XcaNhBPtBzveBjCnTt1lWsRvlFeIev0EJGGmJ
         K7GS+zLXG6a+x4Z+FouCXxmo2co7ypjNfDOZXFoFaYve36EcPT4YNlGzCmpkvWaPcG8y
         NklOCFgbGRxqC8lCxMWFonppRG2PxL7PSYIKhtbjSWhszNRSvoL1u5eNSiStJUliCANK
         DzRuUPfPHlaUb7/ytr8GoqXOQVyVtmGr97UTANdigbIh5m8o8lzt5UGWTP3judkG9A4D
         bdlw==
X-Forwarded-Encrypted: i=1; AJvYcCVWncvIIHvIgjlR9/Ig0ITmFLpkn60/JzKQDuC5QEnLhs15CEvDeoxlqX4ysFwIna+1Fn7dIUo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyk7oMfAtJT4DnJQ2uwgaHujiuQYohPBt4ra+vbDe+8klhH8jZ1
	H46mCu4fyw8QyHvKRzLKCweUmCbmaO4zlZwMQ06mU9yQN262PWdrVMuQpJmY6KXEFG1vrzSGIaE
	98IchkNooQikYcIYcLVK4uDav2SZSj1Qr3NAm6Q==
X-Gm-Gg: ASbGncsIfLjbNb5W/k3JrLNeNs8TXIOJrPnIB29cSOKq1tLNQqdbFQV9MeHzN5cTlwG
	00we/S2w8axC6KGAZkpD6QLUHdkhS6sg=
X-Google-Smtp-Source: AGHT+IH81R4XFg2CPj0gwX0HCIBF9TK4lO6eQU9i9Eh6UvUy1XLoSg/49272JtHDhspwSlHmAL7DhLTLqjgun/Hp2yM=
X-Received: by 2002:a05:6902:1549:b0:e38:c692:14a4 with SMTP id
 3f1490d57ef6-e395b93b17dmr15727852276.36.1733007813990; Sat, 30 Nov 2024
 15:03:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241130000802.2822146-1-andrew@andrewstrohman.com>
 <Z0s3pDGGE0zXq0UE@penguin> <20241130160815.4n5hnr44v6ea3m44@skbuf>
In-Reply-To: <20241130160815.4n5hnr44v6ea3m44@skbuf>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Sat, 30 Nov 2024 15:03:23 -0800
Message-ID: <CAA8ajJ=Grm47nKZ+Yp-TEXAFfyoDOkJ9Kbc+NnUOx6ehg0o=vg@mail.gmail.com>
Subject: Re: [PATCH net-next] bridge: Make the FDB consider inner tag for Q-in-Q
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, 
	Shahed Shaikh <shshaikh@marvell.com>, Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Simon Horman <horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Roopa Prabhu <roopa@nvidia.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

 Thanks for the review.

> I was also going to plan asking Andy what is his plan on making
> switchdev digest this.

Since switchdev switches don't seem to support this, I wasn't planning on
making switchdev digest this. I was thinking that it should just
be disabled for those hardware switches.


>The switch ASICs I'm most familiar with can learn
> on inner VID or outer VID, but not both.

I don't know of a switch ASIC that supports this.

Is that a problem? I thought that it would be OK to add features to
a software bridge that don't exist in any hardware bridge.

I've tried to see if anyone else was facing this same problem.
All I found were concerns about the fact that the provider bridge
needed to learn all the customer's MACs.  As a result, it looks
like 802.1Qay was created.

It seems that 802.1Qay is primarily addressing a concern about TCAM
limitations, and decoupling the provider and customer networks.
I think it's possible that 802.1Qay has inadvertently
fixed this issue for provider backbone bridges. But for my use case,
I'm not concerned about TCAM usage. I just want isolation between
the inner vlans.
