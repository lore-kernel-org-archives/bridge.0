Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE3430BBA2
	for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621105; cv=none; b=KF37POGLuF64WPlBp8pu9RY2H3Di5PeSF+CgcWptjLEQ3xCEC3MZOOmkOZK7tygTlPH/gZgLj8PArH31mzT9sT++V7hZc1AWXRIA4pGOJAaeYLfxqo7rs6f/h+Mu/w+iV1j8HiFiIRmwCbgnq6bBVa3a9FKGrHZ475OBVrgLsoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621105; c=relaxed/simple;
	bh=VruJw1T7uhapGa0jtAj1x3LRy8FHdBE1j78JBq4QfOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXWaqK0KriVRlqoXFKCykuzyhRtex4/C9kZcuv6/Ph8EXj3L1mH8iaCmVQ/Bol1lpn16SsSZnte5y6YGwC2NhoAX/b2w6pdxlD4NjxMyWHakuX8ZC8dA8UlURvkNhvWZylSr6Eo+ixtiGcxx2gdM4rGUhig88TYvogy0NDQCLJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iPCRwEnx; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iPCRwEnx"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso761164f8f.2
        for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1760621102; x=1761225902; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5caMCGtD9UUSs38IuhvfLESxQ7eNkFDvoe0zgcyA7Q=;
        b=iPCRwEnxBlE0jg4wmPib3NEkr7IO5GJMAfGTBiQBAWEluIKQ6I+1bTQdJ+QO0BlJNb
         t75HMj9xVVRrzynJrwrzk8D9Z3jEY7aV9/iMkJJZETYSeR2ywETRSGgTOFmOxkmk8+uI
         ABBa067zU8E6ZSf67YwrR54ce23+eSjQJ5bziNOabQ4c6iMXauDSgCdNevUS3k8sAOU8
         yp4wIAYb+iLerA5NdMbqGRGokwJEr1XcRHC9jSw34pGjZ4wTC62k5+eVX7omZBDO0syy
         PkGO+3drS3Qm2phFY76oPVH3qIYJlBghzJzNCf/wtpE/W9bkYPG6s9P09XSwlbsca48q
         xhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760621102; x=1761225902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5caMCGtD9UUSs38IuhvfLESxQ7eNkFDvoe0zgcyA7Q=;
        b=GXYjcbK+Wuq6KeIoW6ZbhtiojGXxUsI86hQNUms2Bht8jsv4x0KXXToVw0xjnVvwOY
         uNKTanS7SKiIrQ5mAv99CP4ktsykG7ORYDwBJ4Rl8HFlbhXMGHIaYbONz+B++mqFwu6R
         XGcQa2xLBcqfx1E5b6E+peZSSH0twdhU25MwHD2A5dSZ7LB2XbTaQRYkv4nJaxoua2k8
         +jVtydl/jUM96JmRo0MnTZveZZLHlWcSNAilMPzzOlAfNpiXquVginZrbAT2Bj9XzFhm
         YMx2MLXrJNhXgsWJNmv3pD6brpZcfLwDvjGuBEKvGJtF2VxESQ9bgP5yG7p0sc9od4Rn
         /UNw==
X-Forwarded-Encrypted: i=1; AJvYcCVsZLYlIGiZMdB74AAYg+ula8m7vKOb79Q+dsRrHrr0ieEShlHJR3xAyLEzjwV6bk1Di+s8Zzw=@lists.linux.dev
X-Gm-Message-State: AOJu0YyANbZThgP9VbwxYT2Qv8H1LP/2WscXdnDMYnH9+efVqLaKjT66
	6xgUOXDwo0aW2rkFAfdYuG6Z+8PdIkDem7QQI04YTKJrFDTGR2vG7zBtR5EmpGe2fpk=
X-Gm-Gg: ASbGncvptrVyjtr1tgyCdBTMuGq/q4snpmXLec+hjgjuxRsz5JTTHifAz3+2WAK1CKx
	8vibYOQ0tp48Wlny4yAy7SUHs81M6QNnUTUjm2f6PogRF4/jwGXm/jX2t1Ms4PGuJu5cN25jCHQ
	tAjEyoH+tt5Rq9SGsQL8g9ju6iQhwAfOOBFQmRZJnJ0x/eo+EDVaQaZdH6P1aajQppSRE+/Rd1I
	P/jKwWgkLzzom0sTbeG+3zvrxd5ieiwk7Lz5eedINFGfrOuq6oZkbYqE97oe6Q1CV7MWvGA3xPp
	50WzX2yS5+lCnygl8hBd2kQfOQz2X9/S2pAF4Qm55+G1AepK8Z+abA9ybwVPvOg4mQvt3PgGk6m
	oJ28+akT1ZKPt/ZxfL0lp9BALjiVHvq21PcOb0JkMGJVJWude71DI6KLkIjtlUAjwc7JUk5IIxT
	Bkk+Qp2xVIQSlRscftMR07GLw1Rj0=
X-Google-Smtp-Source: AGHT+IHylLhegH8EBHKyKNx8tuKkwCcVBihVX2MrfVK0KP+2FLw+1osRi3z/tz/c09s6arjEO2JRUQ==
X-Received: by 2002:a5d:64e4:0:b0:3ec:dd26:6405 with SMTP id ffacd0b85a97d-42704d900edmr77046f8f.26.1760621101900;
        Thu, 16 Oct 2025 06:25:01 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144239bdsm42268005e9.3.2025.10.16.06.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 06:25:01 -0700 (PDT)
Date: Thu, 16 Oct 2025 15:24:59 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sdubroca@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <fw4pvt7morcydktpqmmotab7pyvbixhrszgdfpl4dut52rfesf@4fztqcywdwpm>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
 <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>
 <aO74J20k16L7jS15@fedora>
 <to4zjjo5wfd5suootcy2v7n7kuc6rym3ld4jov26nunnarji2u@2hr7jyiq36pj>
 <aPDnN072argrq23q@fedora>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPDnN072argrq23q@fedora>

Thu, Oct 16, 2025 at 02:38:15PM +0200, liuhangbin@gmail.com wrote:
>On Thu, Oct 16, 2025 at 01:27:00PM +0200, Jiri Pirko wrote:
>> >> How about "master_upper"? This is already widely used to refer to
>> >> bond/team/bridge/other master soft devices.
>> >> 
>> >> MASTER_UPPER_DEV_VLAN_FEATURES?
>> >
>> >I'm not sure if we should avoid using "master" now. Maybe just UPPER_DEV_VLAN_FEATURES?
>> 
>> Why? We have "master_upper" to point exactly at this kind of device.
>
>I mean try not use "master/slave" words. I'm OK to use UPPER_DEV_* prefix.

If you don't want to use that, change the existing code. But when the
existing code uses that, new code should be consistent with it.


>
>I will update the name if there is a next version.
>
>Thanks
>Hangbin
