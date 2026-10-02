Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32755425867;
	Fri,  2 Oct 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970608; cv=none; b=Q4L2vc/nQ7lipRuiyTX+fVevtsclKHHWjnCB45HGG1rW1c/G4bQHfklUTq1zaP+5lXpLxMy3jNBY+BLPj7eAZ6+TwkFqSZqwWkBadeayyfkBvZr9v7rpflHvesorMcgcEeNFjlYzS5tqkNf6fIEfcSsUKDn7CN4bc1IOUNYXih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970608; c=relaxed/simple;
	bh=/isEbr+69JykiNEfJcLylAKHqHC5ielkFjbzPdNAD8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxNhI02ICpW0Fp9zooCpX923trkAd/BlEHNFMwYPOZQoJj1jtH7knxeufZbhGgo6UDLeifbijmQy0d2BqF/Yskm2NJdxJniW3pC9W+/d+hN+Nr/XxZvc8JVUk/DNFhShyBuWeXXPciqBDdUHVSZfYiQlxzuNFP821/rtkrnojWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhMcn6VW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhMcn6VW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CA91F000FF;
	Fri,  2 Oct 2026 19:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790970606;
	bh=XEZH86Bry2aPfq4awiYyr4REOeRzpJPkJIn2vSdLKiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PhMcn6VWgLR7baMW4isisFIRgeBOflcVRl/uWLv/2dTdrL9bIBguPDfhIZLzhDX2o
	 NNw4mSLzq3Lw6YTQ2Jy6YfSaCBMawan0Pjlc2l4HSTT2Fn0rPQDUYYrFo7wlign5bt
	 1PqRQ+9rroeKl1B50Kg/sxyfpVDsBM3N+xvehIEmSEy1aos2kKjcVtB13fYRXFhleR
	 oL7CiI6pFAn81imEEjrL0EOAlu49QubYVulSw+PhDWmMpnISEn49Ow1AbljDETrPMv
	 QYVn8Es90Su1NWQ+g/q0lo50LjZlseY/kfaLUACfpzsUxyKq4NsUYj1lM3ny3Eaejz
	 rST+y/lpkWjTA==
Date: Fri, 2 Oct 2026 12:50:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH net-next 08/12] net: bridge: vlan: quiesce readers
 before freeing port VLANs
Message-ID: <20261002125005.15b6b56e@kernel.org>
In-Reply-To: <f529d8a9-a4ab-4398-8754-d6c7528133c7@blackwall.org>
References: <20260930071411.2786201-9-razor@blackwall.org>
	<179085595119.434549.4421493167752460988@kernel.org>
	<f529d8a9-a4ab-4398-8754-d6c7528133c7@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Oct 2026 15:07:21 +0300 Nikolay Aleksandrov wrote:
> - Yes, they can be batched and I had them batched initially but when
>   I ran my tests I didn't notice any problems deleting a full VLAN
>   range. It took 79ms on my host to delete 4k VLANs. As I've stated in
>   my cover letter - the complexity is not worth it, so I dropped that
>   patch.

For the 79ms number - how big was the system and was it busy?
