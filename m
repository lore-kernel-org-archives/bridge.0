Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01952877EA
	for <bridge@lists.linux.dev>; Tue,  7 Oct 2025 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835292; cv=none; b=a/yyo8SPWovDzETJ3YK3k+J51ug7mNO534qQ9g5tM7uvB9n3Pw6CQKTmsK2TBIE0pQitlWvRaO2LHxEpnw6IrVrnJLe74K45xEXh/lUKOfeOyJHr/a4pU+O4c1wCAFfJ2vQd6lKoxRfNPgIKxm4KZPByTdjbO7bvPOu7VPvuSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835292; c=relaxed/simple;
	bh=TlzaEHv2Kypr40jJY1wIdrwQoo+uK/cxkq+U4OldIUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBqUtD8eKcHSFXnlhEt3K8k8UO0ZlbU8TUiz9vTjL8qBgv0XV4W0nrs5Pztw3HEmnBELfccKdy6lWr9RCeS4jiNakKD0RtvLo/9vABEJxa0zsdhfAmkGcvVKhYN2s2S61Jj/RejbrjhbEUvTN+M/bEFn3OBgD/GOfy3+u/yZ5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=qcxRcdK3; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=h6nbr56Q; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="qcxRcdK3";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="h6nbr56Q"
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 5FA1D60269; Tue,  7 Oct 2025 13:08:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1759835283;
	bh=+g3fL2cw06Ac2SbpkzNP/E42Y27Abj0WqG9P/o6zQtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcxRcdK37bbLd5J5D+lC+0+w2sdszpbNiegbdT6wmJS9mf4aOH6vNBx9Xm+NZrKnh
	 ElwbHOZAX0EycF5AmNR9gI4Ul6AuNhiF5Q1Fj7MdlREBRsmS3+CS0gFLOnTWfmYkYp
	 bMhGM9jIVLvBKeNG86UipsaQuXIgwxI1Ovgo03wmTvu5N8/q3WY/SOOWytjp0N+eYG
	 ngmKGGg53BNh/01cvoTn6Qd2gXYCrCsrL14LeDoFa4ixV8zS11+Stpv98KLEkmD5Vn
	 M0jTD8/yt9RQ0HgAbsL9CGUZytVU+s6mKxwiGP9cbOsx3wH44mJbr/XafU6YnzAchG
	 +F7M/kCOpS0fA==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id BAB29600B9;
	Tue,  7 Oct 2025 13:08:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1759835280;
	bh=+g3fL2cw06Ac2SbpkzNP/E42Y27Abj0WqG9P/o6zQtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6nbr56QAFP7HKiIsitfy90E9iSweZogqtKnlEzd2YAWYFnDihlEyfJg2ZuK1tHvV
	 lKOEt5+wSfnfa1llF7pE6HFv8uE0MX9C3tq/dawAJ+BnzGoRmJyys70WaLMAK9LlDk
	 Ga2ApCf7U3OvqoIIe3AzQLJNDXrrJ/wj6PHUi71Vnztnt2Ixth4W+A8m2toEK8ccMY
	 VQN9+ddX1Ob5HqUNaERGsQsI06FbGpmgZAiEXl+yieektPw2E3+BaYPKUfAFCqQ7uQ
	 nlIuE06ZzK7EIUpoOUxHndRRERM+h0gYeNuGVHqNPfIrI62j+wNeSE9IJLQVC2im/p
	 CuTlrBdy/kDoA==
Date: Tue, 7 Oct 2025 13:07:57 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v1 nf] bridge: br_vlan_fill_forward_path_pvid: use
 br_vlan_group_rcu()
Message-ID: <aOT0jTumQq39V7p2@calendula>
References: <20251007081501.6358-1-ericwouds@gmail.com>
 <aOTm6AUL8qeOw0Sp@strlen.de>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOTm6AUL8qeOw0Sp@strlen.de>

On Tue, Oct 07, 2025 at 12:09:51PM +0200, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
> > Bug: br_vlan_fill_forward_path_pvid uses br_vlan_group() instead of
> > br_vlan_group_rcu(). Correct this bug.
> 
> @netdev maintainers:
> 
> In case you wish to take this via net tree:
> 
> Reviewed-by: Florian Westphal <fw@strlen.de>
> 
> Else I will apply this to nf.git and will pass it to -net
> in next PR.

There are more fixes cooking, probably we can prepare a batch.
