Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877607;
	b=Vt6Cu02MyWP5Yx3q6ES+S2QpecnGJ4Ht1UjeNDyPc3kzkkXelR7TrL10WizrIs7PCGwH
	 Gpin3yjvCOTlztTuX/B/LPqijocGzlPU/vJBxhSf+QVORqE8AKPnDgNu5hEuAkI9xRO64
	 rPtPCv9qEDeyPaROmVY/hIh9cv6IOR24qh42jAobYr0gmfh3QpYffu/7N3h7gqy2LTrOh
	 2aO3hwFVaNQJRHW3oR0WvFnlyF/9oORdETbmPLqbpm4bsajKRku8VxCOwlVVKeWrvCYDC
	 yH05BKIwzLuuvEi/Bq17krHKbHTiDKyaHPi5dLF/ccaU3JuOnS5u02jcXS9KWpB+iSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=fbwKP6oKm59DXiDgiVS6j7DYr4fQoPbEbnIQIw0kOz4=;
	b=5a4GyjNC16GYPTBVWQMNXW8AiD/nY7yn8iEvHMQInsyOmZ9Y6BZ7teZp93QX1hkXvIgs
	 TTP7r1eByqjLSPjzSjpjo2M+r8RovB5TJyaE20gb2aGcoPyqyUQ9G4VE6P0BlHF03hcZu
	 tBgYXTn1gDijHqfj19cOmgd50fY7NEl2w+7Zj2Yjf3BO6t1kEw1SZV+eR7mR6z0KwKO/3
	 7JVAEWbNH4zSfMDnHnp8hzCHlakxS3pWw4V3Nv8CJaUoe0kqIQe6a7/Joio0xZmn70HVn
	 Y75Nbs9DKkvroJlxvClcQ6dpe+gTw5Qbzyi13PhuzqUdxDQpbAYiYmSAqskNU1YaWiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZqTvHxDb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32A606A326;
	Thu,  5 Nov 2026 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZqTvHxDb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C323B1F00919;
	Thu,  5 Nov 2026 11:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877606;
	bh=fbwKP6oKm59DXiDgiVS6j7DYr4fQoPbEbnIQIw0kOz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZqTvHxDbZEmeWh9Q84+rTflIIgUb4IovuegtaHIVwCriVa+9z1WpZvDF9OM7rwJD0
	 8O1dt6QiLTtkqXhL9HS4waS37qNp/uRc8oDzx1iuawCABlH3auYfHJYPcqwNcth67L
	 qp8YrIy6Ee+GAT4rwBkFgnToL2//ypInm+oAzPYKJI4QGqcrKp0DtjFdo+/UvEyL+m
	 k/VAJPvgoqR4BRv0K80NMYM/3J4HD2RZFwBt4BU0Pbk7pvpLRb9HGcT+alxIeT3e+w
	 c82pr/MiRowV64uQct83sHMhRjSOPY4r1DhlJ6prCZj0jlnaMiJkWsd/OHH3IzILZx
	 grwHiB+RLfJeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA4A6391AFCF;
	Thu,  5 Nov 2026 11:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: bridge: disable MRP ports before the FDB
 flush in
 del_nbp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179387760556.3608225.7629650989179782563.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 11:20:05 +0000
References: <20261101044840.1595584-1-1020691186@qq.com>
In-Reply-To: <20261101044840.1595584-1-1020691186@qq.com>
To: Cheng Yongkang <teel4res@gmail.com>
Cc: idosch@nvidia.com, razor@blackwall.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 horatiu.vultur@microchip.com, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 31 Oct 2026 21:48:40 -0700 you wrote:
> From: Cheng Yongkang <teel4res@gmail.com>
> 
> del_nbp() flushes the port's FDB entries before it unregisters the RX
> handler. For a normal port, br_stp_disable_port() moves the port to
> BR_STATE_DISABLED before this cleanup.
> 
> That does not hold for an MRP ring port. br_set_state() ignores state
> changes while BR_MRP_AWARE_BIT is set, so br_stp_disable_port() leaves
> the port state alone. br_mrp_port_del() then restores forwarding when
> the bridge is up before clearing the bit. A frame received between
> br_fdb_cleanup_by_dst() and netdev_rx_handler_unregister() can therefore
> create a new FDB entry referencing the dying port. Nothing removes that
> entry before destroy_nbp_rcu() frees the port, so a later frame to the
> learned MAC can be forwarded through the freed port.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: bridge: disable MRP ports before the FDB flush in del_nbp()
    https://git.kernel.org/netdev/net/c/37dfd0efbfff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


