Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100DD3C088
	for <bridge@lists.linux-foundation.org>; Mon, 12 Feb 2024 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751737; cv=none; b=oV2/MOipoM5K3xIpIvaRh8/RJDnipQUsEwZdC0J6OqWZ+9fSZ3LfgM+FT5z3taOo/LBu+9Y6lMJbrrMEPz+F/3rPpBtJ/rAD3y5c/ewBtGuhBdkLUhcx6uBNFyRpVixtAVlv8UT0+yV0nl0v78UJS5yiMPz8POCNaKY3h70lGws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751737; c=relaxed/simple;
	bh=UlNQdXdEu8GFaDckGHWpz0bCZpO+hsGs9qo4St9gRCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHAWr5RGxpCisAct8QWjUFIsrnvlKcdqBRAqVaVuJXntRUYB8IWatxxeM6VxLOuiu0ozhjudgQ24Zu+8915geLmcJ/wyrwaO+03E7sad/RIj1DolOG/5kMtot661i3uUoaVMpSOTqeEPm/Hi+Hh96kv18p5B8yD7y1LRUJhrVCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95D4E83CED
	for <bridge@lists.linux-foundation.org>; Mon, 12 Feb 2024 15:28:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P_5juWEQzOVI for <bridge@lists.linux-foundation.org>;
	Mon, 12 Feb 2024 15:28:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.107.17.39; helo=air.basealt.ru; envelope-from=oficerovas@altlinux.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8118283CEC
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=altlinux.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8118283CEC
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8118283CEC
	for <bridge@lists.linux-foundation.org>; Mon, 12 Feb 2024 15:28:54 +0000 (UTC)
Received: by air.basealt.ru (Postfix, from userid 490)
	id 2601B2F20241; Mon, 12 Feb 2024 15:28:52 +0000 (UTC)
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id 7DF152F2023B;
	Mon, 12 Feb 2024 15:28:49 +0000 (UTC)
From: Alexander Ofitserov <oficerovas@altlinux.org>
To: astrajoan@yahoo.com
Cc: arnd@arndb.de,
	bridge@lists.linux-foundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	ivan.orlov0322@gmail.com,
	keescook@chromium.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mudongliangabcd@gmail.com,
	netdev@vger.kernel.org,
	nikolay@nvidia.com,
	pabeni@redhat.com,
	razor@blackwall.org,
	roopa@nvidia.com,
	skhan@linuxfoundation.org,
	syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	vladimir.oltean@nxp.com,
	dutyrok@altlinux.org,
	Alexander Ofitserov <oficerovas@altlinux.org>
Subject: Re: [Bridge] [PATCH] net: bridge: Fix refcnt issues in dev_ioctl
Date: Mon, 12 Feb 2024 18:28:28 +0300
Message-ID: <20240212152828.4049756-2-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20230823093846.7wzrhnqdk2wyqud2@Astras-Ubuntu>
References: <20230823093846.7wzrhnqdk2wyqud2@Astras-Ubuntu>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 23, 2023 at 00:38:46PM +0300, Ziqi Zhao wrote:
> On Tue, Aug 22, 2023 at 01:40:45PM +0300, Nikolay Aleksandrov wrote:
> > Thank you for testing, but we really need to understand what is going on
> > and why the device isn't getting deleted for so long. Currently I don't
> > have the time to debug it properly (I'll be able to next week at the
> > earliest). We can't apply the patch based only on tests without
> > understanding the underlying issue. I'd look into what
> > the reproducer is doing exactly and also check the system state while the
> > deadlock has happened. Also you can list the currently held locks (if
> > CONFIG_LOCKDEP is enabled) via magic sysrq + d for example. See which
> > process is holding them, what are their priorities and so on.
> > Try to build some theory of how a deadlock might happen and then go
> > about proving it. Does the 8021q module have the same problem? It uses
> > similar code to set its hook.
>
> Hi Nik,
>
> Thank you so much for the instructions! I was able to obtain a decoded
> stacktrace showing the reproducer behavior in my QEMU VM running kernel
> 6.5-rc4, in case that would give us more context for pinpointing the
> problem. Here's a link to the output:
>
> https://pastecat.io/?p=IlKZlflN9j2Z2mspjKe7
>
> Basically, after running the reproducer (line 1854) for about 180
> seconnds or so, the unregister_netdevice warning was shown (line 1856),
> and then after another 50 seconds, the kernel detected that some tasks
> have been stalled for more than 143 seconds (line 1866), so it panicked
> on the blocked tasks (line 2116). Before the panic, we did get to see
> all the locks held in the system (line 2068), and it did show that many
> processes created by the reproducer were contending the br_ioctl_mutex.
> I'm now starting to wonder whether this is really a deadlock, or simply
> some tasks not being able to grab the lock because so many processes
> are trying to acquire it.
>
> Let me know what you think about the situation shown in the above log,
> and let's keep in touch for any future debugging. Thank you again for
> guiding me through the problem!
>
> Best regards,
> Ziqi

Hello,

I've also encountered this bug while fuzzing. Is there any going work on this
bug?


-- 
2.42.1

