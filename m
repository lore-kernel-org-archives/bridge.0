Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA743199237;
	Tue,  9 Sep 2025 02:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384151; cv=none; b=XmCQEzffo62sBeTCc1AE54Ptc2idv/nF6fu/74Ec9pok/BSxwmxyboDT8IblEDguZILjtszJBVhJ00fS0HX4pWX8YHhBM/g+nDjdaw0iXto14jUC3WPkQ1FRYhOGLzMGzGpfmZBwSNC+Ug3sfyWB7wjN4ZVPzv05zWpgDnIzTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384151; c=relaxed/simple;
	bh=7Scujo2X/uh+B46a7JkfPJXMqTNw66TRE7Wf7WUGpUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liLOi5ndT4cAyIHvVWYLgjBm2dlzGb5DTpZ77Nb+R11grzMUWknTPShGtlNJqkkMO7lEuzCHHWusXQXrs9qQnwWI6DZmv6muqfS2wvh9bzmBFRR3hq7YAYaINK8tL44MGZlY4P88ujp5PSevJlqGeG1v5dOiBsfXn+6Xqyyh7rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVFab32/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVFab32/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119F8C4CEF7;
	Tue,  9 Sep 2025 02:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757384151;
	bh=7Scujo2X/uh+B46a7JkfPJXMqTNw66TRE7Wf7WUGpUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eVFab32/9vZMTa6FvZVXoOatK3Et75hPRBXxQWUfw0wlVfXxMT31Jhg2AAB5OoGW1
	 RhwwaNHnlJpKr4EFshmVpzpJJK0UnbHaQUsoXqBFB+KALgtmcqGpVkNQydquidoL8K
	 J30fz3CFu/ho9lRCQqeyGEVXPNACRNx0kIgVBKO7JpsDdNx/5qd7B6fqAdD40HhQRg
	 PZiBTTcsVThYLR9UMDBnjunbY7EgMH/XODSMsInSmSb0rUXmfRnc3gJ0pFEPJFKHUp
	 YEfPfH7G2PE33EiqoJWALQL05xRPshmleEsnDkv3CyPu3G8Eoc/iRQ4fPuZs6aR+BI
	 u8HSDqmSJV4ZA==
Date: Mon, 8 Sep 2025 19:15:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 <bridge@lists.linux.dev>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 02/10] net: bridge: BROPT_FDB_LOCAL_VLAN_0:
 Look up FDB on VLAN 0 on miss
Message-ID: <20250908191550.11beb208@kernel.org>
In-Reply-To: <8087475009dce360fb68d873b1ed9c80827da302.1757004393.git.petrm@nvidia.com>
References: <cover.1757004393.git.petrm@nvidia.com>
	<8087475009dce360fb68d873b1ed9c80827da302.1757004393.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 19:07:19 +0200 Petr Machata wrote:
>  		dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, vid);
> +		if (unlikely(!dst && vid &&
> +			     br_opt_get(br, BROPT_FDB_LOCAL_VLAN_0))) {

What does the assembly look like for this? I wonder if we're not better
off with:

	unlikely(!dst) && vid && br_opt..

Checking dst will be very fast here, and if we missed we're already 
on the slow path. So maybe we're better off moving the rest of the
condition out of the fast path, too?
