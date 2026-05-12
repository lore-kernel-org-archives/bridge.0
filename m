Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6315137F8C2
	for <bridge@lists.linux.dev>; Tue, 12 May 2026 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577973; cv=none; b=I5hJdFhA9GPBtO48KMHM46pMtrcv4bjwAwTN0xE1di1q/gJgPs4yXZQp19a5wEFr1Y+TUbUhLtUrukjN5UX3UFD/+GQpyc0EAVRaZs1T9IO4d5LG29YSNn67hI2OibLkDkCg3V6hwLF+luVfWXua799pQCpSt1DPDFmLaCmzHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577973; c=relaxed/simple;
	bh=Aa9k4JIXMfWoBEywcAjfDBCQBqZfhCo9Ags0Jb9ayFA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siRsiQQ4aQS7IbyBo9afTSEPIv2hCHQPPn2jEvHfCNqwJifCa40VdZJ9v0zJhVpuK3aS8+8K3GqIb1L2Ii3CNw5vCp+hAm7K/yq2R5PFy7zoowCnpXJVr9T3R+asTvHAXPWSEXCzBWggEtmQAZr4zgJoZWjxU7VBH/QQOaAZibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPmxkQF9; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPmxkQF9"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3922b35e69cso44934281fa.0
        for <bridge@lists.linux.dev>; Tue, 12 May 2026 02:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778577971; x=1779182771; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOgcSNGt805XiQUX+Fq6Uz2xukIsUi5hMysVvClcsfY=;
        b=aPmxkQF9/b1uGLJ7RevUoz2KCZ94PfzMtO2GTb6m53lAdg76y0hLRmKnZFJkSTYJ04
         Zpr6uxlkM6u/UUG0ORRTqUJFXJG3CNoP2FnqB12ZhnnnB0ZIGzWUQfeHYHy7s37qj1KP
         7Rn8m92INvxBMUfz1FoiRaALfCdkUFnzHau+ji96yVSy6GftIjLYdiiDxxhJvMuuStHx
         m57/7/2AI/rqSuaeLFbXHierNkh+ddRJMQsuLphK4uvLs861+VfFVnvEA5OXhtbHjTWM
         loaeEUk1rwXpF/M/75NvlW5eRUnsAS2puY/9Axc214wQVRFMhWvmq4BaCUwfVotDQXLg
         KRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778577971; x=1779182771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOgcSNGt805XiQUX+Fq6Uz2xukIsUi5hMysVvClcsfY=;
        b=rV48Qh4/La7Bnyel9kmp4kRvbLXFDl4yDiVDEnJapSzCEWoqrdc+HeGoHKdO1SaFmV
         kWQb77um65p+4Atro7CHm08SMPdrC1ZM2A38Bp80cw1bcM2Z7ff7CFgT94Yh0cw9xO8L
         2BEUGl5zykBg8K7QOyLemw89KQH0gmA9rfzVHQwnSUyQ460he7DCiug8NXLqn57rCAXi
         qFl6oE/I3Fgl6EvSYPp/kQ9tjLQ0JZcrd0RPGUsYAhDkKI1U0A4imEW2FAmuJ8q8mOYl
         43upuq5q+UoXLUFNiedfEKjFqukADwd2YP9bYySw7XPsBKWTr9xhPPMD+BYBkX4bSSda
         OkjA==
X-Forwarded-Encrypted: i=1; AFNElJ/D0K1Cf105Mp5pTxjIyfPJ2yNl4nGmmh9G57qi1FCSsC88t47uHXBfrS3g2UItiMI5pyIQS5c=@lists.linux.dev
X-Gm-Message-State: AOJu0YzrHHMKuTnf+WI6QuDEn6yNOPKsovGzvXOKyqa/y5tqfN8OY8bU
	SfOUWP2Bkcu4E4RYn2X/gf0vGPxChhFRohuGe0kT9ktUY7PxMAl8Ycdh
X-Gm-Gg: Acq92OGzLUUHyH69A29IMJxBcxlYt3TmqwzIduXwBHrmcf8weTQVltsDL0QSY4G3k9f
	HsRS6Nj+KMpJtBZdqWOYmTOjbl4R8/Oay0uxPNh1wv33ZuHxmCqYrZfBOrHKwvwmrICQt52xB+T
	tkCpTJQhRvkxpL+d2eSgulULMnv4wcfEMJhxzsETQeBp0/VakJlpPsQSLixa/X2KVflpuj0fxgQ
	+WsgNAixRscF9ZbzOfTupOToDB7pgBqwtw5QXbaK3ybTDD1TokREejSmi9Fyyw3Y1xuBB9vkzh2
	all/aYEj2H4vBKNKidcFE/4TMvRbCqsx3uoc1nPUKHusCuiGEJ/6KnPmLCkDJOKKnlxwEfXH83Y
	U08SP30k2IzDXyhC+qv8dnO7rHTSYUutYZgigrvmoke6VKeQFlhBj3UX3CIqajteHL6OWAh55BN
	Il63bIVkmhf7JtPOpixlLA0SopKyYFRe4/uzPqfzDT9lQZJm7nbcY=
X-Received: by 2002:a05:651c:3241:b0:38e:49e6:a363 with SMTP id 38308e7fff4ca-3943cb812d3mr7142681fa.15.1778577970282;
        Tue, 12 May 2026 02:26:10 -0700 (PDT)
Received: from pc636 (host-95-203-23-125.mobileonline.telia.com. [95.203.23.125])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f9ffa0a0sm30618831fa.21.2026.05.12.02.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 02:26:09 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 12 May 2026 11:26:06 +0200
To: Ido Schimmel <idosch@nvidia.com>
Cc: syzbot <syzbot+8b12fc6e0fb139765b58@syzkaller.appspotmail.com>,
	urezki@gmail.com, bridge@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, razor@blackwall.org,
	syzkaller-bugs@googlegroups.com, fw@strlen.de
Subject: Re: [syzbot] [bridge?] kernel BUG in __get_vm_area_node
Message-ID: <agLyLko3Et-V2mRV@pc636>
References: <69ff8c7c.050a0220.1036b8.000b.GAE@google.com>
 <20260512084754.GA181587@shredder>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512084754.GA181587@shredder>

On Tue, May 12, 2026 at 11:47:54AM +0300, Ido Schimmel wrote:
> On Sat, May 09, 2026 at 12:35:24PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    9207d47f966b Merge tag 'for-linus' of git://git.kernel.org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17e44d06580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d0f0911eedbc130a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8b12fc6e0fb139765b58
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > userspace arch: i386
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-9207d47f.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6c5e883f31aa/vmlinux-9207d47f.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/19f3e863ae5c/bzImage-9207d47f.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+8b12fc6e0fb139765b58@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > kernel BUG at mm/vmalloc.c:3206!
> 
> It seems that this bug was fixed by commit 30c19366636f ("mm: fix BUG
> splat with kvmalloc + GFP_ATOMIC"), but then commit c6307674ed82 ("mm:
> kvmalloc: add non-blocking support for vmalloc") re-introduced it.
> 
> Uladzislau, can you please look into it?
> 
> Note that the bridge is calling rhashtable_lookup_insert_fast() with BH
> disabled.
> 
Yep, since vmalloc can be called with ATOMIC/NOWAIT flags now. I am
checking this. Probably we can just remove below check:

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 676851d5cfe7..3d338e4bcbf7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3209,7 +3209,6 @@ struct vm_struct *__get_vm_area_node(unsigned long size,
        struct vm_struct *area;
        unsigned long requested_size = size;

-       BUG_ON(in_interrupt());
        size = ALIGN(size, 1ul << shift);
        if (unlikely(!size))
                return NULL;
<snip>

We have already the check:

	gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
	allow_block = gfpflags_allow_blocking(gfp_mask);
	might_sleep_if(allow_block);

in alloc_vmap_area().

--
Uladzislau Rezki
