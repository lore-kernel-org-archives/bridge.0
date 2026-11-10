Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.190.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272911;
	b=rmHBtSsH8eRPYK+uBExDxb+lETMJGQtAyqXS4PNbtktYdYxDTRKH2KWMCcURKTqM2+WK
	 Piud73hirTJ31Nk9upFQNOQMhCv4Rg80pnCnqvHKWpeEQSvHZB9ASh2V9eViGFViuHjqs
	 ALoAkEaDTbIblN4DCMELarWOg/alPqb0NlFt51k/0JmV+mB/V+FwBJpa8nzDp5PHeG3tm
	 7+r2bCgcuBhuZMfHJ8gmKJlOnL43JeaSMpYca9XdKEX3rfhLA+Yq2qOwkl694acBVqXMM
	 PRpzQ+oAt83z0cOAxYaCmMIa8TuvAht4eGq79Bj9zomhMnONZPy0fFdJm8J7dQTbmvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272911;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=x36i1u1Ug+CsRO14sJNtHgtErxuuo8Mk9cH4G1xa/s4=;
	b=ssEweJKp1ve9NiGMvB0rPMAAcmRv/Z7UQf2Ev6aY9rrA6u9kJJd5n0euMWalAZbcVC5P
	 LFlyyqV6WXjf7DSjxrAEK5OCirqglV5hBtqc2og5S0DJE6BhjIC90TP5NxJpFVAe6uhaL
	 rlrVcOeX7VhJYOpQtBtsP97TIYt3PmjlfWL+2/4rGzSd2c8KAfxmOkKhQwzs4hJJo3kG5
	 TkQr6N0zCitQOu8svpZrp7KbIGL0AYIWJelg6GDlBcuB87m5fknjC9wKYc3H0LFQtgKef
	 IKLw5GELQ1cFTg5Tpt/U3opbi6NLNnSKWUpCx0S+RkkWzC7iotXz0UeJCVFvIWVg54w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=netfilter.org;
	spf=pass smtp.mailfrom=netfilter.org;
	dkim=pass header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=MdsVN4E4;
	arc=none smtp.remote-ip=217.70.190.124
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B3DB1606A31C
	for <bridge@lists.linux.dev>; Tue, 10 Nov 2026 01:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3DB1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=MdsVN4E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1794272909;
	bh=x36i1u1Ug+CsRO14sJNtHgtErxuuo8Mk9cH4G1xa/s4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MdsVN4E4iogadZhZ7ORSwt0JptmXZKE9Us7gR3oCWvLOqMMkL+9bl6sQEoYNBy38p
	 qPE6DOfvXgo+w6Y8hupDpGG8gSet1Lw17pKNtG/V8awdSWb5YBloR0Mk1I8i7qQelq
	 Dfb0HLiH88Fcvr8ZxvyaaV730A+RBly4n09VMRHxc1g82EStp0LrLx02IY4zZAL/wT
	 QG8tyqcwgqdoBhxUMCNyYqBgDTQR35vfv6vGiQh7VsJOsh8hVa4NBIwQ12CqCdh0GJ
	 ftuEAnqjcPyEjhk4496fHKAdGiKaevYwdy56CVDU8WC70XFJ7bz6Poq10UnWeO8hz+
	 /vpxzE/zToGxg==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id F28146005B;
	Tue, 10 Nov 2026 02:08:28 +0100 (CET)
Date: Tue, 10 Nov 2026 02:08:26 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: Florian Westphal <fw@strlen.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	syzbot+a8ba738fe2db6b4bb27f@syzkaller.appspotmail.com,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH nf-next 0/2] netfilter: bridge: refragment packets with a
 vlan tag moved by the bridge
Message-ID: <avJuijtALFuuk7yd@chamomile>
References: <avJo2nhgnulY776l@chamomile>
 <20261110010450.68995-1-laveeshb@laveeshbansal.com>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261110010450.68995-1-laveeshb@laveeshbansal.com>

On Mon, Nov 09, 2026 at 05:04:50PM -0800, Laveesh Bansal wrote:
> On Tue, Nov 10, 2026 at 01:44:10AM +0100, Pablo Neira Ayuso wrote:
> > Do you have a usecase for this?
> 
> I found this through the syzbot report and haven't seen a user report of
> it.

Yes, there is a patch to fix replace the WARN_ON_ONCE() that could be
found. But does it make sense what syzbot is trying in real life?

> This is the follow-up for nf-next we discussed in
> https://lore.kernel.org/r/atck-NoWvemxIsF6@chamomile.

Yes, I remember, thanks for the link.
