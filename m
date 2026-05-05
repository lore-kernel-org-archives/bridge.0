Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621154654;
	Tue,  5 May 2026 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946958; cv=none; b=daUC4kdYjYXXmCmD0yfPCduxh6qR+ttbqbQOBqX8FqrWrp762K8P6Tjjbs+88f8Ko4BzjaEQkfmT33cBE+Csr36A/Sq4dex8Xq4ug3KOrlcUOjYRw9eTyPNR3iyBH86A4BVbpRdfxwB1wxwOVkjsRd1nS3YN+i0kwiT15cwA99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946958; c=relaxed/simple;
	bh=QtDHwztUbtw1r8LVMFG5qgo2DJenZ9aKj8SbaeEsMfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rq/BHMNshDyH3mLD670Dt3ZDlTuyeYeBGsco1Yb4yR6icT5x8ONgHjQ2SlKhw+rLwVdB6G0ffAi2E6FXdMR72Kp727tmCqa5omEOLrkb4zMwJFBNiEMTbKyHrWargZc2XPiXUmoIEmmCY+aaGINC+X+IaBTQTrMvmySI787hJBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE6JLjxK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE6JLjxK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EB8C2BCB8;
	Tue,  5 May 2026 02:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777946957;
	bh=QtDHwztUbtw1r8LVMFG5qgo2DJenZ9aKj8SbaeEsMfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XE6JLjxKZC4HEko31wkvlqePBhoxYjIBWP+jqh7gKzFtXLH2TzbpvbsNbxc6fwWpA
	 UjjV9tfoCWnB6yfJm86bJt1OW3jm+unx1t0rfaGddO30KasIEzBjTcnaFJ1X8RQBtR
	 HWR6rXCzwEUIZMRYyISRLaelEmyFTkt20181JqEzIVbVucYttYER/AHj3RrY6Ery8b
	 iFbJF2IkuHvARaeD6+T9pHtt4F63G0YAwyVomtB969ggxhnds7cUyAKpVPZtdZu5uK
	 aXsr36b7Hb9SmZljhpMaQldmd8775uYDcjw2QpSYJHjwW/GKq++QWrJ+BAhsPUtq7B
	 2VsRYvcdrubuQ==
Date: Mon, 4 May 2026 19:09:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ujjal Roy <royujjal@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, Yong Wang
 <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy
 <ujjal@alumnux.com>, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v6 0/5] net: bridge: mcast: support exponential
 field encoding
Message-ID: <20260504190914.0070bbc3@kernel.org>
In-Reply-To: <20260502131907.987-1-royujjal@gmail.com>
References: <20260502131907.987-1-royujjal@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  2 May 2026 13:19:01 +0000 Ujjal Roy wrote:
> - Added Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

You don't have to repost just to add tags.
Our tooling will pick them up when applying the series.
