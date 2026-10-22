Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685614;
	b=eFbUAMS4qXlFjWTYqe3muIigWmC8h8i00Alw/U6wyBzmqipELzBLHEzO8g13hS+Z4Usp
	 CXZoRoKBNJcOybNZGs3g+3dUxXFXCu0Il7rj3pAdFI34tE3wWKh9fLzKdJTWOjSlDn6di
	 l2gM2x+1lL9SK3hgkj/gRZG9N6y+D28C8R9EpigmNza2fQ7JoWfHpRYyZJrm74MLei4MN
	 b7jDz9rp7ar1goyNcQo0fl4rRXOvmb5XN+9EUflZ4QojLzKwpDzsB8UN7nwovlq6+/M+U
	 cotnpuE+ukpbM/t2cJdXoyTNfSoREgapaynF9EwrAl7AoGojWPfcF2jmi9pxSz6reRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685614;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=V0+NYhdZz+0+nK8vHQf39p1Q4t+KjPeBW6Fj/qmLCMDf//eS24PWBfVw88coEZabRu1z
	 R0Eeng9j+db6mxZTWRfXWHP8KyUT1qBroBQTw3r3J+hqrjTcI+TcdFqybXaFZlL0i5cFv
	 6JmjT32u3imwX3X5hbKwSr4rMrE03uNGtQc3Ji+ic7MyIj1xKXJB+MV4xo5RUsjSDZXqK
	 fTEe6/CZFM3Dwcfy2m6Fc3YJCFOTeUR1bWAaHU8LjR0Lh4gHnbXe+HUDOFD1TJcaAJ2TW
	 MPfQG1BzWcVxgOvcmDIW3dBWEAneFqPtOxNyqTmbL+f5XxDLASfHW8nbGbkKoIktOiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Js74pIVz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B3606A32F;
	Thu, 22 Oct 2026 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Js74pIVz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3751F031E2;
	Thu, 22 Oct 2026 16:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685613;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Js74pIVzFWnQT8PFLmiLS1pYM1SiEA9d9CnXf6t+5PPTyrt4TIWo86pVNljzdeNR+
	 aLOccAIPC3uENYB5Jm9csHJn3VQZ2iu+MSADCSHinU4LuwiHYCY9X2fbmBagfqYZSB
	 B2PW1lCrRmj6/bLLqcm3H9CDOAA0g4/lZL98wmuMjhxMFUsHLXS90rvng1X9HzN8zr
	 tAYAUzqKR78ZrjPJ/9+A3GNR44UzPNFy57HXSroQBJn8AI4IUkCpDtZ/vuKd7aoPrl
	 H9w5xOxVtYMiUOW3DrDM3s2G+iIfCxqKF6MrApK4UdF9WLgQUwzwpYXbtY4KkCAkmb
	 VjW5h0xcq0wuw==
From: netdev-bot+sinfo@kernel.org
To: Cheng Yongkang <teel4res@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH net] net: bridge: do not bypass port state for MST without
 VLAN filtering
Date: Thu, 22 Oct 2026 16:13:32 +0000
Message-ID: <179268561245.3290.10488272547860177966@kernel.org>
In-Reply-To: <179268538303.70821.3493915601694605045@gmail.com>
References: <179268538303.70821.3493915601694605045@gmail.com>
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
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
