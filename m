Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561A337C0EB;
	Fri,  4 Sep 2026 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788562290; cv=none; b=guu4ojhlZXKiUeyXRt/PeGKPIfwX8chR51nPfnLK/eH4k+e6W1OGo22D1qZPqcB0RUf3Wh/mvCu+IzSTLwxZOHZlYgjsOlHv4LvvOOMgubSQRx8V195fQD3Ny6VdamqNax+3Rpd5U2vF2a8FoVtCX6I4PPAduo7W5l6AyKbGk+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788562290; c=relaxed/simple;
	bh=/i7p4gHciX25bGYdJiZazeizbBDFsFvWtrFAsmOlwB8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pzZPtnM8psPwjC/fyRrllheSQBdY2PWkpcLlkemswZPjsKupRuCTveLHB8gqxEqBlEFQ1rlKF3CVjfnKuOpBPbjFbPjNFIg/EWJg3JgPhhUdYReKj+8GbSDz8rbU1nLEdTVay/QsX7g+8wTQiWG7FohlLzxpMAb0sIEPkDPyvDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTjlLOhC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTjlLOhC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF471F00A3D;
	Fri,  4 Sep 2026 22:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788562289;
	bh=69wPxxkKPd2iCd8JHR6c67dG7OFr6nDG88KCuFs2mzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eTjlLOhC7/0uX+D4fCmDjCubXWc92Vdc3ZhdOcdLsjik0/0DK2Ff8jabK66+np5DC
	 m5ZDD0aJcc9kV+X4PcH/Ml0UURg2JsYmOzveMPLB7A8aSzMu7SarhZQyNBbEEMiDjK
	 5vjIwILQ3r9jgdfR8bKOSjsN+/o9+yeB2/nOo/j3U94n1+NZI+h0aXMiyYshxQI24A
	 nVbqzceKRc2sKHjnxsZAptIKJC3+w6BpXLa14iujJcaJEgdkTmHl+AUDztANmynZ4W
	 VZc5xijPdZpvQ6b2i9Y8agWqzaG7fNpI5MRCiUhMCRDGxMo97ar3hxXlW08KUxGWfI
	 CBr9MBAX7NVPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1996D3924A7F;
	Fri,  4 Sep 2026 22:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: bridge: mcast: properly convert mglist to rcu
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856222964.1003513.16860802841606767335.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 22:50:29 +0000
References: <20260903093851.1494297-1-razor@blackwall.org>
In-Reply-To: <20260903093851.1494297-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linus.luessing@c0d3.blue, bridge@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Sep 2026 12:38:51 +0300 you wrote:
> Sashiko reported a bug [1] that br_multicast_del_port_group unlists the
> port group not using proper rcu helper that preserves the next pointer and
> after that immediately frees the port group without waiting for rcu grace
> period. The only rcu walker of mglist is br_multicast_list_adjacent() and
> it turns out that function has always been buggy because mglist was never
> properly converted to RCU. Fix it by converting it to rcu and moving its
> initialization after eth_addr's. Initializing p->next can use
> RCU_INIT_POINTER because we have a barrier from the hlist_add_head_rcu call
> later, besides we're initializing an unpublished structure anyway.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: bridge: mcast: properly convert mglist to rcu
    https://git.kernel.org/netdev/net/c/4b772869a1e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


