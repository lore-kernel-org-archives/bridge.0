Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E442E8E08
	for <bridge@lists.linux.dev>; Tue, 14 Oct 2025 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434831; cv=none; b=UVxACEHRJRQ/2QO42rSy+8QY9PgtUeH7U1fA7AQheM5W2SEWLDPsVI2mqIyBhRe9NsEXvVprMNXNIV034d4/7AVyhZ/6TWCYJzEIn4S6ZOFAR43u9MBUwLoLStv+0Gf9B7kfMsosvF2yJLoo3nphJwIXXDc7CgmaVg4NXNvDWPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434831; c=relaxed/simple;
	bh=wRKvHPeq0IjJrOaHI66asnH+YnrNb0PTfpXzCuY2EDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzqxJh4dElzck1Y4TWRcCWqGRA8i8nT1K6TsDARGVlNHNtpD5LlaVL0yweDcViEQfQ+s6wLJ7oOicfjJfzqBS7yDCCZIphWGtrMvrG3bI4sye2M58XF69CUGv8JzYY0Cs9maSuj1GHEVkuEC3ycHNlh2QKchVSmlvT0F6ZGndi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CPkGKMfb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CPkGKMfb"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so55058215e9.0
        for <bridge@lists.linux.dev>; Tue, 14 Oct 2025 02:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1760434828; x=1761039628; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwcAcEVMFbFagSHujABEn/5LkWsDvenqWgEz+Q71K50=;
        b=CPkGKMfbFQZ/R/2bCiNEZr5Qs29Q32xWxB7uaUTjeyjI5sRNTECqLiKanTueWnmXBs
         xoWQvVHn3KntTgAJW9k/HiGlpcZ/UAlEnPQJnY5Jlr5gZhqaXp1v9EnQjpBuzKqePSlH
         otPSq9uNlS7NR6amCoiElk1Jw34ELKSIkFNxgE5z6wsUH3POp7G2RKIKATCnGzn49c8q
         kbYdClQwSr4kQ6sXf7d4GlUVddl0QeI2hqj7WMead6eHUWIriwyLC8dPLF473I3JnSOh
         Vgg6wigRS248zVgNzYsedq9RQRXPPK5k7cUpMAQ8GjE5m4g7BlL+su1YLOvjvwbkPAfh
         Ik/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434828; x=1761039628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwcAcEVMFbFagSHujABEn/5LkWsDvenqWgEz+Q71K50=;
        b=rK612GVQo7iuhC6yc+FwThnCK1IzWlTbwA0ksdQn4HxmgM6hv/ZdOScVNkQr79yGZ8
         0WlTe5M+w6/a1CHV6bdveu34NHpr5jkhJfjaxi0+xV6pYbWs3jtN/u0eJ2si775NPhwo
         6PDvMV7zznjHSckVYDUcCLfei/Z+AEF6ubegzqlMSJidDFPT3d5bYSQ8h/H9etLZlnjN
         XLzASBwRO1zhFqPBXHTBIxU8LTJ4Ac71vD+Y3QZ9NPLyDkjf6JkCbOk6yWlfLPUs1bLT
         +3aFOyH1554XtZE3k83UOLbqLkO66GHCVY3/lAm48F/kCMdbVUp4bLG9ZjhZpnlE7uIc
         IMkw==
X-Forwarded-Encrypted: i=1; AJvYcCVf8tTn5uSxYvNF/H7AZl0tOZAwI4hVcS29vO03EgDSrudcEllUsrC0OAMSEdV6lQ4OMAPlx3o=@lists.linux.dev
X-Gm-Message-State: AOJu0YwvK4BFzww/MbAhGbJ+izCmlv2oqjuAia18+0nCvtX1vCuyihTB
	249CXtNSELXosD4tu+RtdxGCD3nM0PeB2MhYyQiRHVRcbgNNQYMEpj3qY3BvIr022Vw=
X-Gm-Gg: ASbGncsa+uxjJ77pyXNVCntHzsuD7/ZdYZ4EVdIXWv8F1Vu+LkLqLgtKUpfGDCVuEU3
	tz5xGGQt4899dOh0pDGQQSfcHZu+Nf81GDQGAjvKDmWSzwbyMUtIGnj1TzV9Yt00Hrkd9lfcjO9
	pC69M7UMfb6Oc8i1UkR+I+tNPWtGK7lRb2zwhVsV/hDv0jG7uGTUrsighC9WO+lrA02q8b87IIE
	4QO+Xj/g6zV17EYAoJZtsT+hv+fqbic1oSavDp9hmhgwrrxoSUSOPa3uswBxmnmf5OyDjOxe3UH
	oMuO4He5GuCi7OcaB8FYZGBEVMlEdOEku7k5AC8Cu0/Gd8lDFtXd+RJW+SxIv2lur/PPL7362Es
	k+KF3SGP0wFlSCrMSiwxaDjqd6a7XkflwZLvsR/7YnkktwWMBZkqCYLGt/EiIvy/kPRk=
X-Google-Smtp-Source: AGHT+IHXmiUu6VVSyfoi7gU/XjlYIF2/0bxO4RUXhVMSkCCmaHjzamtRFltrBIEPIqHHZ3nvWstrgQ==
X-Received: by 2002:a05:600c:468e:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-46fa9b092femr190108795e9.31.1760434827487;
        Tue, 14 Oct 2025 02:40:27 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([128.77.52.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d49bsm23512241f8f.10.2025.10.14.02.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:40:27 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:40:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sdubroca@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014080217.47988-2-liuhangbin@gmail.com>

Tue, Oct 14, 2025 at 10:02:14AM +0200, liuhangbin@gmail.com wrote:

[..]


>+#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \


I don't like the "virtual" naming. In the past, we always tried to avoid
that for lower-upper devices like bond/team/bridge/others. Soft-device
was the used term. Please let the "virtual" term for vitrualization,
would that be possible?

How about "master_upper"? This is already widely used to refer to
bond/team/bridge/other master soft devices.

MASTER_UPPER_DEV_VLAN_FEATURES?

[..]


>+void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header)

netdev_compute_master_upper_features?

