Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1913D093F;
	Wed,  7 Oct 2026 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791353043; cv=none; b=RMUEVn347QtmAN7JuVdWU8ytntfFkkp/lluORChxim44X58AcZnHVTjTbItxj34z5U/Ai4eO0YsLFP5XXgNGVzidrLiHoVyvlT2G1DMTk2XbOquHJScAp5mgJsIh2BA8MpJLfqkjQqMzFAUSVwAyaBqbYf4MjHsslCLCaHodjcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791353043; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XtNXrmovjOOW14A63mgC9qGjxa5kYhVgt4M46BYnXERe4t67AJ+X04A9QmE8ZMAK5VHVYPTuyexQHQH+5WRihf+b+sSTe0kxr+j2VxTIz8EwPij50MX1SWT4+0FCxE6Tw8NynR0BacBZKCG4MDv3kybqruTgNvVuBIkVPyEDG5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrYImYwf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrYImYwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024F81F0089B;
	Wed,  7 Oct 2026 06:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791353041;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mrYImYwfb6HlFitrfKZqxlOqgSoAK4RGLncabK3gFo6N2SXKlmmntQXNVOOG8Fmg/
	 rhy5XPOkLsJdlSywR5FIE+N9LmVMYI7mqSJCVrj3vMIsZkUNlUQtwIAdqoLJvCF12Q
	 +q8rPhAXKqZzHkHjL7rLczoHTR6A+to2JbZw3DLnVgDuIMsN0pNZ34r8rZQaMGVQVD
	 BpOsdEEDhK1FFiUhgMr2+TsmId8eLqkmQ9qd3FjgLbFX9xu9kCdp2XGn0/g5A1PpL8
	 bV8F01J2sUulc5llp5LXrT21au0tlFHCGuFpq+WSMvDWVVhUTVvQMZVRKN04pp6V3v
	 /ads8hMbua3NQ==
From: netdev-bot+sinfo@kernel.org
To: Yiming Qian <yimingqian591@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] net: bridge: don't under-estimate the VLAN tunnel info size
Date: Wed, 07 Oct 2026 06:04:00 +0000
Message-ID: <179135304050.2527009.8103377902303247171@kernel.org>
In-Reply-To: <20261007055939.63100-1-yimingqian591@gmail.com>
References: <20261007055939.63100-1-yimingqian591@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
