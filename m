Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5EB407574
	for <bridge@lists.linux.dev>; Thu,  9 Jul 2026 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592021; cv=none; b=fyCC9gpWEd4dq8M+5T/RXpfb8OW/kcYJuh0WsPWgF3yAjIXvsuSuHEU5vrwrgl03uATec6R2zLgQBNzgQK0m4onBwRL1qFSJDFhJFNn8SuNIblwibSiRCByv6y6NcKTwywkNVSbn9qEx0cLCzWUnGw6Fgb/rB44aaQEWCRd/IQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592021; c=relaxed/simple;
	bh=xQmBxphDa1xFrmI6W+JXkKRcOnX9uJkuJ+MRhIqYj0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUzwwkhm78xmq+l6/sdIg9JVYWrgOdjaohRdXZU+bfuZPOsQsa4cK0AuXY+GY4tW9AxABAA31YNoN9aNEqbXWxltgCpdnUh7HmBdED0qr8f0QKnC2rQGPcI128698hPanKoSXIyESCQ1yxecFZ08Q6KaN5h+c26rOHJYtN6Ltt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATyqZWGy; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATyqZWGy"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1373061a91.2
        for <bridge@lists.linux.dev>; Thu, 09 Jul 2026 03:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783592019; x=1784196819; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xQmBxphDa1xFrmI6W+JXkKRcOnX9uJkuJ+MRhIqYj0o=;
        b=ATyqZWGylwWDIIzx3R1mh2LTm+tB/na3s09QIs3JD5sx8WzbrOvfrdMTPXfh6/65Br
         bY1gNPTUcwQcrbyGlDm47WXuZcsdLR4HliCKRtiuJKwkq62qnCFGALrWBPjDQsGqPf0F
         73gHh45xOlY7xCb/xlaGmhG8g4yJRXVReILbNHfR+BUodplCsz/AHr4lPijl1NEptdk/
         fy0xAoqAs3YVRvnEHjpNIzSN0JR6ZoSTvLixvpTvLGSMgxBPKiVK2aZ/xVMGF1eSzbDN
         8DA6U6bolc7cmn4zHFxb8aeFGdQbUjS1SrFBVR7TzwdBBny5PL2skJdOyPxUATLAUFU2
         SnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783592019; x=1784196819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xQmBxphDa1xFrmI6W+JXkKRcOnX9uJkuJ+MRhIqYj0o=;
        b=Y+RnTLTLy80ORc6xvLnHrLcxdp/qTda+VnQgmQuHw5g4EH7aXHXb4VgK1Sx07Cuyf6
         9JXBF6KSGtt/gl+gFzE6PkXuYTTeIhZgImQnWGl3TaskVd4sdqqJMHHuMzyZXq7he1E7
         wV1JiDBc48rAZL0ThljVtF+2VWmJrlgtLtmg1tY2jTw85VxlkuWmNWZS0F4s+wODtjmR
         QmzDQji+hQpiLZ24tkkMtxlVst/QAfM5FE2H3UKX+9ECI5sqT+fZr/uht8q3etqxg/Fk
         GRbiGN3xaC6Vj9Oj+VJT5yZrv8AOG6x+shNoe3xYFGSdR010bNWdkiefHglWxYVpB/qv
         H04w==
X-Forwarded-Encrypted: i=1; AHgh+Rq9dcZyvmKZ6nDfEQrkBA4nRGZTvNSRJq88QbOYQHJLYFnD1quGr3a0e0rLc7h5ajeSDwAaWgA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxfx2ZtLftf2BiqfI8psUVT+4/YBGVQR3RVsxf9Dtr+Zasangc4
	WQUYaZZK3bqnNNZ7ce/RY1ZJ+bZB5DAIoU4DOCh0piKpD5ZMJj1RaM5x
X-Gm-Gg: AfdE7cn39gWxV9fkN6CDsDzwiXedGyxVQdHZHZNSeC/tTGW9s356clEDcliHlI7DYBy
	B0PORELO8LnUKHkG4kTUtGemGojrorRYX8bZVHrhYxU+ARxSvGR5v0P5UCsPuOgldcpkgD93GXy
	6AYruD3Za0KDUF3gMDqRZIgA6ZEQdiQh+3NtxNA0AjlZ69984Uf+C1kSORBc9Pm+1odbBjHFK9l
	rCjKYtgoSJr7UP9NYeEH+vWC+h3mOHZO4YlcWqbh/9Ibqia2JYR9B3i64/JfOcoAmSajyfj9vUB
	L1adBwk69N3bXxTeTpiFEryY7wCBctPheIBWSQXe3qfuV8yFghu7MDCDXIuG9jNKX2EJsfyS7M1
	gubW82C5/hcOpyr5TngvgNDw5tkkcnQBftMyPx4MDa7odyNo1DUbfTycBf7R6LVgAMkUXB3fBrp
	WEw6zHYS70o0oOehvYPXjGOm8h7lcDV1vGgarVzg==
X-Received: by 2002:a17:90b:3849:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-389402490c1mr6834337a91.10.1783592018896;
        Thu, 09 Jul 2026 03:13:38 -0700 (PDT)
Received: from DESKTOP-82PPU4A.www.groyaloy.local ([202.8.116.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm32071423eec.31.2026.07.09.03.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:13:38 -0700 (PDT)
From: Ujjal Roy <royujjal@gmail.com>
To: Linux Stable <stable@vger.kernel.org>,
	Greg KH <greg@kroah.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Please backport bridge multicast exponential field encoding fix series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
Date: Thu,  9 Jul 2026 10:13:27 +0000
Message-ID: <20260709101327.9508-1-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

Please consider backporting the following bridge multicast fix series to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.

726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation")
12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()")
95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
e51560f4220a ("ipv6: mld: encode multicast exponential fields")
529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field encoding tests")

This series was merged via: db314398f618 ("net: bridge: mcast: support
exponential field encoding")

I checked that the above upstream commits cherry-picked cleanly onto the following stable branches:

linux-7.0.y
linux-6.18.y
linux-6.12.y
linux-6.6.y
linux-6.1.y

Thanks,
Ujjal
