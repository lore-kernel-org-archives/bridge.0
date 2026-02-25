Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0A1DE885
	for <bridge@lists.linux.dev>; Wed, 25 Feb 2026 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990729; cv=none; b=oyiuCrwkc1sopLH9Vz6ZbMPK93s+vWlfdrYp7GbCJkMJAS8A6XdZYjwmWZuWZNXiG6oKHsKZbbb7ECHPeRfPNV48d2owbs6BGQ6BCCuTSs/xBYuKaCbbPtXTzxsfYMiIbgehxu9LoTUO00OxurERYg0HMhGdcG7a5g7X/Kz4eN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990729; c=relaxed/simple;
	bh=CgQkRKZi8n6qzzxkB9hjDn8pnf1PBXTxjcBXQQvQt6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBtrig2fFJwpTN+TOFpPieo5lYMl61Zj4mzXirtxIZtBr4MT5hJM7+HB7t1LMATAvRcFRnvq3xQ8EsMHVL1YpYPtui4GEcHCaDG+rVCV7dVRiNyWu2yN0R2eQL+ioTpa8p+X1Y4LChnxC0JpC8rNQdJ7O+L5oGy8UrzUOYJrF9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cz9w8wyR; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cz9w8wyR"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-35851eadc17so3498194a91.2
        for <bridge@lists.linux.dev>; Tue, 24 Feb 2026 19:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771990728; x=1772595528; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIBkt8Uip58Gmu/ZZcPFAEjJpU3JU8q0pJGlTo8qLYw=;
        b=cz9w8wyRxWkUgjgZHIiWbiiWVPnNGAAXojnj6EOmj2doNHVnK4ouzMNyrrrJFvwjs9
         jMiScuQeeG5/ENcEZ0SRDtm+bfBUbllNO/5Zhj0QYRmmV+shIEOLmYREBzihnFzIM+kJ
         JdrklK7nRIUvqm/kYk5A+ZBP1D56lpYNuLXW+EZ7Mo+lKhfsBfUiBpOzImqn6oLvac4h
         p1QtyS4tHY5Wg1YIrwXIaaieJ4FMSIYz2yKxzZa6LTRF07VD19QmAq3YzxTbwvYmeEvu
         YIBsx2qLIaSk4whb3jSVaBwrwj+5jRwvZVO+MO6WvNA9O49mDPq8PnpKurjcqWDX4TwA
         2a1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990728; x=1772595528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIBkt8Uip58Gmu/ZZcPFAEjJpU3JU8q0pJGlTo8qLYw=;
        b=upRQJsLEmDPQ3ZB+tc2TjMmHDSelC4OLRb0yF81tJdew/2D0+Pu7AeMTvlxJ8Nswbn
         qwcUnPsFtOIeMXAsK/SdnnMeFv3z0kiat+M3weV/zyZMpogXjgOsYwZeMvQsCR/CWGLN
         G7qv6a0l5la2EnIG0c/wo5t5LJBdEvfiEjeuqsSLjVLPLYW9CeP0a9xepLqmgkcv4qvC
         Njyu36qgcxHqN6Sdu+tU+6Opa8boCxKokE2SprJAz+Gu2EVNFFGjGbU4WGBrXrAHWoWh
         Bhp2+j23Oi0pr2ZFCn05SiTbmykW6qjEcV8D1Vm7/wkZInC3eyaSFe9JtcqyFbNChaKm
         7jMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0H/knSQmI/WtXzM4Ga/Kx4+hdIQKCoBx0iTUxNb7g7GKwrAjn8P+0ierwLJq+Mt/bjsFQQSM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzhBkpE4Wl3E+syqhx+36tfV2KWcePKL96vcVEGERG4ig860Mi0
	Am2pmy3y6qNIqBfrZUQ4gUGrdCpr+7IXNz9NIQFa/oUzszS7j5UcHN36
X-Gm-Gg: ATEYQzyKjNOtU10T+LkN4jW9USj5v00fTF3Ze5gtg8w9lWiKq9rglaXZE8N7o4iiqXG
	04ao03yI/TJL9TTriylmFqqpEEUEe8ukTbm3Vnqh8PcDDg2zXI3VjSIxeyWhYEDiCIY6LjLIdIs
	00wZn7rvTngpWUSgOpM6HMnRtswNwAZbqRI6OXUrXq3yvzI4QPUymH/14ta64Pvk3MiqT4RuTMf
	91yrmSeFQQPPbRbB6lFQT5wPvmFrmPdARSJjFT5T9OlAqzB5olsMY7zGikCRxmnMYGB+e5UEfUK
	kGugJr7ixH4H6cZnygi9lftBfVhN7Ue47aW7ifpiuKCR85D/KDKOCIAFaHJNLw9pu9NugAnyR40
	OCR6EjtwhwZUCM6FHK+gBe7Pqr6kZGXnonM9SJ7paG2uVJihJrrChBkeFxOaB7U6e8vrfqIw1GT
	MKvZfSJBVztRZjjufywhIUz0CA0Q+INJVNrlDKwpQBhGyPoscSA0Y/XHW+XuR7kmWs6oJ3Eg==
X-Received: by 2002:a17:90b:164e:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-358ae8d80d0mr12854544a91.23.1771990727568;
        Tue, 24 Feb 2026 19:38:47 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359018838b2sm1161746a91.5.2026.02.24.19.38.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 19:38:47 -0800 (PST)
From: Eric-Terminal <ericterminal@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux.dev,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v2 0/4] net: replace deprecated simple_strto* parsers with kstrto*
Date: Wed, 25 Feb 2026 11:38:36 +0800
Message-ID: <20260225033840.33000-1-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225010853.15916-1-ericterminal@gmail.com>
References: <20260225010853.15916-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227; i=ericterminal@gmail.com; h=from:subject; bh=1tb3uAWyvMrtFX3Irq/HFgcUiWj8AVbAWEAlYdlN66k=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWTOy5PjOL2xPl8orDiN9Vn/QSb/0BUXPKvm3L10KPZa0 znOjmuuHaUsDGJcDLJiiix3/++bm+t1a8517sO5MHNYmUCGMHBxCsBETn1i+O9fn/J4q9KXlT41 l/z2/fnWJGZ86GTOW+dJyx3eLk7MfLaM4Z+Ozll1w1OGChuc1/+1W/D54UbVPp8HRzkuSX/dd+p zfSQnAA==
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit

From: Yufan Chen <ericterminal@gmail.com>

This series replaces deprecated simple_strto* parsers in net paths with
kstrto* helpers and keeps parser behavior strict.

v2:
Split the original large patch into a 4-patch series for easier review.
Added a prerequisite fix for xen_9pfs dataring cleanup idempotency
(Patch 1) to ensure safe error handling during the parser transition.
Refined the xen_9pfs version parsing logic to use strsep() for better
token handling.

Patch 1/4 fixes xen_9pfs dataring cleanup idempotency to avoid repeated
resource teardown on init error paths.
Patch 2/4 switches xen_9pfs backend version parsing to kstrtouint().
Patch 3/4 updates bridge brport_store() to use kstrtoul().
Patch 4/4 updates sunrpc proc_dodebug() to use kstrtouint().

Yufan Chen (4):
  9p/trans_xen: make cleanup idempotent after dataring alloc errors
  9p/trans_xen: replace simple_strto* with kstrtouint
  net: bridge: replace deprecated simple_strtoul with kstrtoul
  sunrpc: sysctl: replace simple_strtol with kstrtouint

 net/9p/trans_xen.c       | 77 +++++++++++++++++++++++++++-------------
 net/bridge/br_sysfs_if.c |  5 ++-
 net/sunrpc/sysctl.c      | 24 ++++++-------
 3 files changed, 67 insertions(+), 39 deletions(-)

-- 
2.47.3
