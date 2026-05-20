Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DDC1CDFCA;
	Wed, 20 May 2026 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240188; cv=none; b=NcMIW4wQb6rgm9IJrfiiFnqoomoPNdImc6OlDk4rO8bwDeOGzsDG3Dafy/GSIZg+Zc323Y8Pg4O57xsT5HcktCp3sgebU71icwR2T0LGLo+nBvj4YS94a0OoLKd4BLepqrNqnVzZtbAr/fpS76CimD2rbgaTLpdH5O94WbLnjmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240188; c=relaxed/simple;
	bh=MP0THJ5nhNz5mIlnL4GtxbFW1eIpQDm8FSbqAaFPSO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKJ0iUbNz3+BVOXPKkkzd4UG6Vi3UIz5Ig+nJhocDLr/oabPgpDkkdgiplmKvzt+xRfVwDeWSexXbzSmSWBJysXWKc+MS5fbnhTdETv+ZCRmgm6el6rfYFgT0ryFeOFyd1BTLdQGE2pilAMA30QmH3Lzt6gFziFutBPm5JE39fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciCC/e9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciCC/e9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4D71F000E9;
	Wed, 20 May 2026 01:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779240187;
	bh=MLEa82qiTECphtMRr9+pbBP9zMHAGZSW6vFOaouKx/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ciCC/e9J/+jI5jvE+QLps41GW1FUsNTPg9T18w3pzBKTlNTn60PW9ariawVfdTgoL
	 noTu8hw+haAg/BEaJNc9wrGn3IxFgltM0AZl7l3ej5/HPygp+0ditLXnzURA3NTH0n
	 tXTXdRnqGslTApNFu92Z7PEdEeaLvhFiNC1ltNKNaz+X63i0hhYqyiRAlYYhBuYYyO
	 emkdsCvQjDWVq9zaHaMzR4oMfYCmM8QWCmriHrnsKmJQ/xYZQPOq8Zy5dM/KeuiHuX
	 l+yscGhbvHrDeFhChr9Lex04P40dxXwSZGV2cbI59Yjgq1ar++p8dBf8Xd5PbOmFQW
	 /dvm1T+r1hanQ==
Message-ID: <2a7322e6-690b-4d3f-b675-231619ea87cf@kernel.org>
Date: Tue, 19 May 2026 19:23:06 -0600
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] iplink: bridge: add stp_mode support
Content-Language: en-US
To: Andy Roulin <aroulin@nvidia.com>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, bridge@lists.linux.dev, razor@blackwall.org,
 nikolay@nvidia.com, idosch@nvidia.com, petrm@nvidia.com, danieller@nvidia.com
References: <20260518163647.1935156-1-aroulin@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260518163647.1935156-1-aroulin@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/18/26 10:36 AM, Andy Roulin wrote:
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index df3264c3..d15221b2 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -120,6 +122,20 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
>  				invarg("invalid stp_state", *argv);
>  
>  			addattr32(n, 1024, IFLA_BR_STP_STATE, val);
> +		} else if (strcmp(*argv, "stp_mode") == 0) {
> +			__u32 stp_mode;
> +
> +			NEXT_ARG();
> +			if (strcmp(*argv, "auto") == 0)
> +				stp_mode = BR_STP_MODE_AUTO;
> +			else if (strcmp(*argv, "user") == 0)
> +				stp_mode = BR_STP_MODE_USER;
> +			else if (strcmp(*argv, "kernel") == 0)
> +				stp_mode = BR_STP_MODE_KERNEL;
> +			else if (get_u32(&stp_mode, *argv, 0))
> +				invarg("invalid stp_mode", *argv);
> +
> +			addattr32(n, 1024, IFLA_BR_STP_MODE, stp_mode);
>  		} else if (matches(*argv, "priority") == 0) {
>  			__u16 prio;
>  
> @@ -512,6 +528,20 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  			   "stp_state %u ",
>  			   rta_getattr_u32(tb[IFLA_BR_STP_STATE]));
>  
> +	if (tb[IFLA_BR_STP_MODE]) {
> +		static const char *stp_modes[] = {
> +			"auto", "user", "kernel"
> +		};

Make this a single table used for both set and show.

> +		__u32 mode = rta_getattr_u32(tb[IFLA_BR_STP_MODE]);
> +
> +		if (mode < ARRAY_SIZE(stp_modes))
> +			print_string(PRINT_ANY, "stp_mode",
> +				     "stp_mode %s ", stp_modes[mode]);
> +		else
> +			print_uint(PRINT_ANY, "stp_mode",
> +				   "stp_mode %u ", mode);
> +	}
> +
>  	if (tb[IFLA_BR_PRIORITY])
>  		print_uint(PRINT_ANY,
>  			   "priority",

