Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DC52222C5;
	Sun, 29 Mar 2026 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774805339; cv=none; b=tImilwltYO/kWuWslYBQmUP986dHwp1bfE8rA0k5fN98OEJ1ZZQUBEwanreivgE5TUnTBHPYZQ8nPq/7ERqbq906r24duUP+yHbd2sI32gT0dxO1MC4CO7Ufw5Rbn2TDkKjS/bN8RAN3L/3slo7jpRtWSbrPQTI+aC6I2PDazE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774805339; c=relaxed/simple;
	bh=oZkNJFwRMBUJPUgRLYjcVEySOTzxsy6JnxlH6Js23T0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqfRL96PJangbaNp6uftK7EYstaKajyiAJm7vLyI1urTUXHR41lB621FT1PNqp78WXck7cAnxH5MH74qdZ9+7H4CjhhKly69t6eQMNxjGXfuMaPjEu2lOFp/iPGUXW2NkkNg4ApuBR8rNS6ky9uJ4CBWZ9329m+DUhIRsKf1SZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG0aBaRA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG0aBaRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F1BC116C6;
	Sun, 29 Mar 2026 17:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774805339;
	bh=oZkNJFwRMBUJPUgRLYjcVEySOTzxsy6JnxlH6Js23T0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XG0aBaRAbsvpFIMFDRWYoB/lu4EWuZIjgsNcuOyvsXA/8b7dPbslnyihrOtTiCOyG
	 Uw0Ta6bNt+gwXWb4rjnAWPusOyViXuID+1Cbk7sEZ2HGF/Fnss9BOXhGPu78wKoSfd
	 upFSId4sVl8IWVnj0TWf2+slkKcNXyTVXI4sTc85i9C1CWn/KON8YRtfKID6haqPvx
	 zBuodR9HS59IKhAP+WjI32K1B2jceU98q+SPZ5pWDiyP5H98EmOL6uZMlm2XBy7XB2
	 QB6YdGQbeKZqbVw8qHYynLfl/tQaKXrN8z+RK1O4NNwfPqkSgr1Fo0jfTUKEo8KC7s
	 1tVgRM2ONT+9A==
Date: Sun, 29 Mar 2026 10:28:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Roulin <aroulin@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>, Donald Hunter
 <donald.hunter@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] net: bridge: add stp_mode attribute for
 STP mode selection
Message-ID: <20260329102857.621a0c26@kernel.org>
In-Reply-To: <20260329025858.330620-1-aroulin@nvidia.com>
References: <20260329025858.330620-1-aroulin@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Mar 2026 19:58:55 -0700 Andy Roulin wrote:
> The bridge-stp usermode helper is currently restricted to the initial
> network namespace, preventing userspace STP daemons like mstpd from
> operating on bridges in other namespaces. Since commit ff62198553e4
> ("bridge: Only call /sbin/bridge-stp for the initial network
> namespace"), bridges in non-init namespaces silently fall back to
> kernel STP with no way to request userspace STP.

Does not build, try:

 make -C tools/net/ynl/
