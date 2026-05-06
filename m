Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994772848A7;
	Wed,  6 May 2026 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032846; cv=none; b=G3IfT3tXDwrWQtYloAOpX4FDUxoZt9zm5Z3BAmjZavJiVN7uZMRT4jhwBwkVHI1qt9hVbTi9X7dwYADcso4X3PnYXjOtzS4rZttSmR3Zl9ZTsuzfmNxhS818eQjOe3BKsUISE/L3f9HTB50uRevYOvUeizMd69w68g6ObK89G5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032846; c=relaxed/simple;
	bh=Tpn1+GLPOFLHfW94Gj/ouzTOmClJD5e1kKuEtI4CZLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/cMtVAl82oUGa6Xl/rpw50yOHTXFZ346Nj2BfWfJbiSftZfdLKYVGb+Xke64OsqSNsznp0kvD5X2JrMzf9zH4F46JUACyuPAJ8o0z+PAvPQgmEHfJV9JiShXCEy0Eo/+Gqmr4VxX/3KkgI45wGiGRIW8Boxw1p9MGMRPhjq1Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzlYjG5I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzlYjG5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB46C2BCB4;
	Wed,  6 May 2026 02:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032846;
	bh=Tpn1+GLPOFLHfW94Gj/ouzTOmClJD5e1kKuEtI4CZLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NzlYjG5Iu8CZf1apZG127EADiOV8FJGmoRYlVrLssPGA1XIS04pDFqXFyUWZwhYUR
	 aXG5chJRmG/B5OeCEaRB/BPxTq5E+CiD4aTrgEe2dTlOpjMqJPpOFElfNYknVlTzPw
	 eej8d6eo2j7Xi0JxXOsHrhiDLe3K/TLviD6t35y/kiafCuQhbSo5WTdOkOfdFy3J/D
	 3u0WLMKnnuYud3qKe3fmnKrm3WomloaE8+GcnaCEEPaEP2x+5M9SBarq2CQ0nJnczK
	 NwQRHyHj2X7uyHd3zXz09bzU1doo0eUrFARlsYxCyAkSOgCT3rMfY6vvOL1EQfXhIA
	 SKtohhG+ytRvw==
Date: Tue, 5 May 2026 19:00:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <donald.hunter@gmail.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <razor@blackwall.org>, <idosch@nvidia.com>,
 <andrew+netdev@lunn.ch>, <shuah@kernel.org>, <ast@fiberby.net>,
 <liuhangbin@gmail.com>, <daniel@iogearbox.net>, <aroulin@nvidia.com>,
 <fmaurer@redhat.com>, <sdf.kernel@gmail.com>, <sd@queasysnail.net>,
 <kees@kernel.org>, <nickgarlis@gmail.com>, <amorenoz@redhat.com>,
 <alasdair@mcwilliam.dev>, <johannes.wiesboeck@aisec.fraunhofer.de>,
 <petrm@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <bridge@lists.linux.dev>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 1/6] bridge: uapi: Add neigh_forward_grat
 netlink attributes
Message-ID: <20260505190044.0608dfb1@kernel.org>
In-Reply-To: <20260503073532.2138165-2-danieller@nvidia.com>
References: <20260503073532.2138165-1-danieller@nvidia.com>
	<20260503073532.2138165-2-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 May 2026 10:35:27 +0300 Danielle Ratson wrote:
> --- a/Documentation/netlink/specs/rt-link.yaml
> +++ b/Documentation/netlink/specs/rt-link.yaml
> @@ -1700,6 +1700,9 @@ attribute-sets:
>        -
>          name: backup-nhid
>          type: u32
> +      -
> +        name: neigh-forward-grat
> +        type: flag

I think this should be u8 ? neigh-vlan-suppress looks buggy too

flag is a type without a payload, the presence of the attr is
the entire information

None of the AIs seem to catch this, I think you may have over-split
this submission a little bit. This patch may have been better off
squashed into patch 4 ?
-- 
pw-bot: cr
