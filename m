Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE3114D443;
	Fri,  2 Feb 2024 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898761; cv=none; b=ZbToZplM9PofaUuZEzS2ahLsiSbHvDY3cqhjEnqQnmUsgtvd/kTjb0cYes4XfsTSs7b++iw9IZZXePX6DRGTbnh4R6TzV5BT179hfrcG2htjx++kyWzg/PQz7itasC/T0rJCxiTdUw5fm0O55SESsnt3Ag19U5fCUEuRZZ0XaZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898761; c=relaxed/simple;
	bh=LXnUA9uLDfsc51JXxSgjMp6dsTQZv+8fYhk4eTTjY8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKaiUj4tnDm65a0ZMFjHY90iDG7kghCgQehWXctXRW44DShwRadtTwRuVFc73aBmse7Y8R6EiP5qhDkhT7k2U41GcvrSTTcHjMHykioEsD2G2AunzWLIyfT7M0gbGZp8SYWINldtdyzS07Qy8tBSgRMSqZWKqr7j13dsRRRsXHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbr10d3m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbr10d3m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4321C433C7;
	Fri,  2 Feb 2024 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706898761;
	bh=LXnUA9uLDfsc51JXxSgjMp6dsTQZv+8fYhk4eTTjY8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qbr10d3mY2jGaUrsflP5eunrMqgkEefU3XzrTPLE6FaUw3DSk75plfuPm4qnvPkjJ
	 ogZ7YvZaoOkrrI+zsMpfNLazFVwAyAPWzHdq6yEblCy3Yt8IG0WjYFBBZKryCO0Iuv
	 yNWqlZ5KRaxmuOkGTjDPQVaTaVzRsdLIyia3TIOpVr3l+hWrgSaYgaeO+do6kncBHf
	 CDVRL0jQ/uxlnZ6vey5fQPvYgaQoGdoXmuRW89I0e4l4wNw+PCeM5p6Y8vdt2V9evu
	 l/Cg+zSm8gdRzq2j1Wu481ixBqDQ7G7mc+Q+/S7ThcNKf98TkEcmSe+6mpeMjUiglx
	 QoZkCcgzLBF3g==
Date: Fri, 2 Feb 2024 10:32:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com,
 netdev@vger.kernel.org, roopa@nvidia.com, razor@blackwall.org,
 bridge@lists.linux.dev, rostedt@goodmis.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/5] net: switchdev: Tracepoints
Message-ID: <20240202103239.05f224c1@kernel.org>
In-Reply-To: <8734ubtjqa.fsf@waldekranz.com>
References: <20240130201937.1897766-1-tobias@waldekranz.com>
	<20240201204459.60fea698@kernel.org>
	<8734ubtjqa.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 Feb 2024 08:21:01 +0100 Tobias Waldekranz wrote:
> My idea now is to get the fix accepted, wait for the next merge of net
> back to net-next, then fixup this series so that it does not reintroduce
> the MDB sync issue. I already have a version of the fix that applies on
> top of this series, so I'll just work it in to the switchdev refactor
> steps in the next version.
> 
> Is there a better way to go about this?

No no, that's perfect! This set was still active in patchwork
yesterday, tho, so we could have applied it by mistake..
If you realize there's a conflict it's worth sending a comment 
to the already-posted net-next series notifying maintainers of
the situation.
