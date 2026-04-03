Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622337BE7B;
	Fri,  3 Apr 2026 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205260; cv=none; b=o+IRsfjVxz8y25DN10MBqnSivPjpNoVDEgoc2yLmiZ7G7OgY9yNOU2X4kemgwuokc4oo4Io0hHljvS3aolhIz+1CWvQVYu7wG0vF1NbWMQoQmyUTIF9xQ1RkeXnxGR20GnR8O8cKuKdPEX9yMWcBVEwmzHYBXa+ONbg6io0xqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205260; c=relaxed/simple;
	bh=nuJlVlBMINRwMCs4rlFUzaFahCcjaazDoKvrppFfk8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M85UALe2kYYudoASI0PLT+2AHZFP9TaiiHKi0OskDcuie4IjvmdFZelV0bEEVmMCnkiIXRXuJFK+8JWALLhof3D5YmAWgfCTKr+8H0htiAQzVR8c3CbqYP62X55yQ+JCxqgTkf+5JzOa5vu8OupM+uJwz4m1d1L35zEgV7tuxE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlzcT3kt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlzcT3kt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF93C4CEF7;
	Fri,  3 Apr 2026 08:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775205259;
	bh=nuJlVlBMINRwMCs4rlFUzaFahCcjaazDoKvrppFfk8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlzcT3ktMNBhQGb2efXdQEHeRmVfmpMayOW+2XCHj8eDXCcN/Y+kzJvqAhPFx0qXZ
	 QubrChyXOqNjk/DG2RbdXgbENMamtMJRzhapF8tqBZRVumHu3oybgQS7SuPXL+/nrV
	 fCJY6R3uXU85Bh8IUdQafaR1CBV90B7aJelvytKqFNon0xNE7rvAPgUkOCwVK/dZiL
	 o4FJ/hyarwWAL0dH1JKEQsLN3yTPrGLafVaUS+Ibk/qvE6FRw+kuUShH+WOJpVJqD5
	 A49jYun/rZVBHM8U2gV5t3P/9QNGrhFjB8Q8cPW4eLQtdBj9jfCMDX8RhVsHBIAb+8
	 jKLNKIjCQIj4g==
Date: Fri, 3 Apr 2026 09:34:15 +0100
From: Simon Horman <horms@kernel.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org,
	bridge@lists.linux.dev, idosch@nvidia.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, bestswngs@gmail.com
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
Message-ID: <20260403083415.GC11973@horms.kernel.org>
References: <20260326032438.3307549-1-xmei5@asu.edu>
 <20260327113412.GD567789@horms.kernel.org>
 <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org>

On Fri, Mar 27, 2026 at 01:46:39PM +0200, Nikolay Aleksandrov wrote:
> On 27/03/2026 13:34, Simon Horman wrote:
> > On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
> > > br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> > > interval value from netlink without validation. When interval is 0,
> > > usecs_to_jiffies(0) yields 0, causing the delayed work
> > > (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> > > itself with zero delay. This creates a tight loop on system_percpu_wq
> > > that allocates and transmits MRP test frames at maximum rate, exhausting
> > > all system memory and causing a kernel panic via OOM deadlock.
> > 
> > I would suspect the primary outcome of this problem is high CPU consumption
> > rather than memory exhaustion. Is there a reason to expect that
> > the transmitted fames can't be consumed as fast as they are created?
> > 
> 
> +1
> More so with CAP_NET_ADMIN you can cause all sorts of OOM and high-cpu usage
> conditions. This is a configuration error and OOM doesn't lead to panic unless
> instructed to. I don't think this is worth changing at all.

Right, I was getting to think that too.

...
