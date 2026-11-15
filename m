Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794773203;
	b=OxYmcVUpZ3J53bSctqXE+V+1NU66p+830W87td94Pka2RG41lF8YsYSSwlsuaHuJVbhc
	 Z9iafLuFXRUpj5aGy9zC75IlMS1WE4Xiokq1oJND1Qh7E7wZV8Gb3n7oXh069rs02/Z8O
	 OTU0JoewLpTl9Wyyc0MZk270xod7mCPXDIlFOMc5HXOl3bmEEDOXJWS/yRaggH7SISnOM
	 ZLCKYi9KuH3J/3fTD9ZKVaZqiias/G8CFgBnPNLIDBxGPFtURldWaLYK6HNKX2OXEzROG
	 L4UNgZFma25ikWMt3w/fe/WawPhvZuh17GYL2bN8B1xiaqrHgg1kvBfPYCqEZLvHxzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794773203;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=FegrIPvODOEzqKHv8Rsml+EnC09v68w3H734EdRf0fT0aesYN+B19FsZ5wGUBNG8jiU6
	 NDJ7tof8Mg0IhheOGtaHkS6E1RpwUwoATf5pkPbRHT3b9yz8HORIMysQwKQbXDLU23s85
	 lV0R4JyvDG6kFaxcO4vbbK4HYvvVXTjrWr+KERHN0tHm2eXFcF96RgtR9WHc2RCMy8q9b
	 KidYcB3a8SfHGuPTOkC5Tg0FeACDwrCC+C76dY1A3im9xjMfUPCzoft+WQgwtbGmSIb06
	 8lm7afTz/16CqCeSl+groo7Tqy5Pxu2G46r4oG12Ldf4EelMqomvA1nb7S1v2xw3tLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkz+ZLjM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDAC606A323;
	Sun, 15 Nov 2026 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkz+ZLjM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676D01F000C8;
	Sun, 15 Nov 2026 20:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794773203;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mkz+ZLjMQQbWj3jrrdh2wqUEdfHCES6fcwj6quLYq2oPcpHhVEkpk28Ai8q13VLpt
	 puqsQB7qBEyhTBMPRydgOUgNIGieSiMGR7A0XOpJhSgWY3WrWhLoWxdeRRhUjLG49+
	 cMBpAiI5qihDdSCNzfNPUjMXd9fzaVNcERYAAi6CCDWMRJSDO22yL6XPJQsM4prkeZ
	 +prUQ215c/ssZ6UA3LzDe2LRPny3uKazM+X7Wt9AAllEJruJQdVbUGsUEmBDfxWZaT
	 uQqyk01HZNw2xUwPouzjS+lyRYlXiEnL/FUDEgrgCiTf6M9lTD4uvxpUtc8gpDDI53
	 y9XGfBdMc0N+Q==
From: netdev-bot+sinfo@kernel.org
To: Julius Bairaktaris <julius@bairaktaris.de>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
 bridge@lists.linux.dev, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: dsa: fix host fdb refcount when an
 entry roams
Date: Sun, 15 Nov 2026 20:06:41 +0000
Message-ID: <179477320197.3291.2172653342533166243@kernel.org>
In-Reply-To: <cover.1794696608.git.julius@bairaktaris.de>
References: <cover.1794696608.git.julius@bairaktaris.de>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
