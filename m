Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720071;
	b=jTiVEj54LireDR2/Ck2mMfg+ZWiBBhz+YbJTbYZVyUlwcqEf05Y8wbX7rTGnc+yyG/hF
	 k/y4nXnr7tjtnlk82hBl7Rj2WdeKzc92T7Fos/CyZOCWIhedUs0+hGei4TsLvdxJl7NZY
	 CyWzkOh+CdOLPJ/u0d8NBv91p7V4Ayqv/euGlIBNqNlbHlXqHuCv3qn3rRyGsC2xA2hVr
	 hUd+eup6qWGBMCpPS8Io3jkTTEmzisil9CFUtomTF8vkPakv9i+jBuray/tzQ7Ht99xV4
	 1k3wZCanTVjLXBoJxmzboUQkZwsH6G2Pkz+IO8VdmMnHTAaPXa4l06RRhcnNqH7hfvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720071;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=dQ7KkT6GrFWwijC1PtzIUFnfNvc0aDRF2y82iv2Uq8Zbtk5UPAk/qR0E0DWnmuXXMHOS
	 51whzgBfR3fuqdQR83rxk19aTo4AmP4hfBffMiFPbwVf/dOSfX76rnl4zBI9dbrrSZ7z/
	 jgX6CbMfuf22y/aqdceMAXLukNqIJWgqgi1iqQufE1DhOgTg/KCHbdGDXOpZrAL6QDBZW
	 cksiKkUGlpaMyu4qHpg0qqj7Q96D7u+rsOg2f/xr4H1f3U26/GyXDeV6tXbQ0w6Ja1q8z
	 WkRqOcMYNuc5Uq2a3ZmLwXwGsmNMV567ibhj+1Gw4AwQ43AI5aeWqKU41TcTa7wplJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EivCozqC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC20606A319;
	Fri, 23 Oct 2026 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EivCozqC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4951F01825;
	Fri, 23 Oct 2026 01:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792720071;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EivCozqCvOFIeZF0iWmtKjKWEbn04u6/NlCwWcs1Nr8huUwoAyIv53JA1LnLHqdzQ
	 Y1j8QwKaHN4TEGAGBzrhDP9ru/blMFyXF89rLNExAvp+Un6RsAidfF6MPl/sVwVngJ
	 9xEorUg02W8rsSl1yrfRq7vArMj+4T1ungi6A0uCLPF09KnlAEtnjudmWBa8hPCGxc
	 ad4NgHnVjnhZcsJ1X44UwW9BFlKKRdAzgGbsYKoDMvQYdzaQ+YWu+cJWFara2nTRLN
	 UgZTH1gf4uTmJz+91Oc12Ubf39vvY4ccS4RAKVM8nqoXp9MHRMVa/KMMXF42+flP2U
	 rN9+RPQhcAubw==
From: netdev-bot+sinfo@kernel.org
To: David Corvaglia <david@corvaglia.dev>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bridge: mrp: fix silent truncation of IN_ID
Date: Fri, 23 Oct 2026 01:47:49 +0000
Message-ID: <179272006987.3327.3277225611746854121@kernel.org>
In-Reply-To: <20261023014536.72444-1-david@corvaglia.dev>
References: <20261023014536.72444-1-david@corvaglia.dev>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
