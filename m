Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CD4361946;
	Fri,  2 Oct 2026 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970334; cv=none; b=NqjdszdTFjoYhPdoA3fg3dyZOKqKfZnFfE/KYGEX0KYuTX+s148Q4xCDiUcC99PGhxWizzJKzoXq/OjRzpasSHXvEWZQIabcJ6svJ3BsDAbZr4CwYh7TLxhzVhr6XorrFJV+iAdFWl9nzTe4uhv/mQ/6Zt+9zDTs40Vvv5Mr7ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970334; c=relaxed/simple;
	bh=y4DUkH91HBfDep+cEvE0C+1oS/MqW8HDb9GtJj56oBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W53g/SS0LMLYZzYaF7qfqH0OWqVs9+dCxFb3yOF9lVE7lEh+jLnJYvpfj5GkEhoyFTkpr7jFPR7GQxW9NBQDWQCON1GgkWeF/9gbMOZo3jqqHvrVVWepa/hShr3NbVeonxbgPjq2jvijWdfm+/Tu1zlmSlMLnDV4SWd3MVMmioU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J30KO5Uu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J30KO5Uu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482701F000FF;
	Fri,  2 Oct 2026 19:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790970332;
	bh=y4DUkH91HBfDep+cEvE0C+1oS/MqW8HDb9GtJj56oBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J30KO5UuooHkRDjWmlumzQcxnC8D1C1rVL2pJokiOudcPNtRFVpp5uNvIc2vNnZGt
	 To/rgG25PJzTPCT0XUzrIteEG90G3SKhyTV6d04YvNHzDz+Q27H2tRD6OR29mlsdNm
	 /DC64afnIisxWHslDI4PakMzZla8G/lYViv3sXXCklq747aLPpo7bzuTwIkPH2+WRM
	 IvGQMrpUlFE8iIb4K/SaQLtKM0vSPvglzZFGwzt4Y6NioCot/jKoOMmPQlHDqXyOu2
	 ZH4iOzVrlk3tsEzjoh+Tq3j0GTYgD/zX8ove5PE2UfXdmHaSzIZqzmw/IECzoZtCTt
	 ofbBggwhfrKng==
Date: Fri, 2 Oct 2026 12:45:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev
Subject: Re: [PATCH net-next 01/12] net: bridge: introduce a bridge
 destination type
Message-ID: <20261002124531.49e3eaa3@kernel.org>
In-Reply-To: <20260930071411.2786201-2-razor@blackwall.org>
References: <20260930071411.2786201-1-razor@blackwall.org>
	<20260930071411.2786201-2-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Sep 2026 10:14:00 +0300 Nikolay Aleksandrov wrote:
> Add an opaque destination type and helpers for representing bridge port
> destinations. Using a separate structure makes raw pointer assignments and
> comparisons fail at build time while marking its value member __private
> makes sparse warn about accesses that bypass the helpers.

First time I'm seeing the __private thing. FTR feels quite foreign to C.
__bitwise works very nicely for the same thing =F0=9F=A4=B7=EF=B8=8F
