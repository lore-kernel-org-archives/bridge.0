Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612938D3FD
	for <bridge@lists.linux.dev>; Tue, 12 May 2026 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591866; cv=none; b=WU5jTAOQb1zpZXWTF7QMecA6OEe89ZZ+9YOSZYaHwQILDryelFKFUiD9rP0jPUjGyp47FeRiPM87hQjm4HEXV4ovCWyvDx6vtWWaNhRG8ibdsqaxvDfdVWutnwKcqmLPW2smQfviJvSamwTVbxuYo8s3VlhD1+exbDFcPT66Vbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591866; c=relaxed/simple;
	bh=AaSElHOtQvI/PMMQbN50yT1nLckA2+tupeEMNVvVjEU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyYGhj2eFwL16b5x5dinbkYo6+RBdn4wkXRGTsGFAX45lV6XoYGqHTk9ah9Ocr88XgbfAnw4P2iVBg8h+BzlQQsJw5LPowqRgp1W+L78CwfWegW7zzvrXeNe6EZRKKhUTYfzAub1GPWza6mn2e0pkJ/SjKCRG2FFmcJrLi0W1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ko6Y/BCy; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ko6Y/BCy"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-393a44854d2so42918681fa.3
        for <bridge@lists.linux.dev>; Tue, 12 May 2026 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591862; x=1779196662; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pslgnpi6oJHX0FC9c/oZUmb0rO29LqRdvT8VmcUjOsw=;
        b=Ko6Y/BCyU6iL4HhVMgkbbLTWRjZbCoJYu1W0lmWje/rRNfmVrlO7nl18tdyinwcmqA
         zgXKbdEpfBmcGaiVdYB+cjBBZFL+h1QXuDEq46rUG7toVDonfB+nVdxOy0v/xNMy0XFT
         lbgAkRFPRmwdIdcxG/ZskuGpVjCthFhvmuAmyIbQDA9+ILUIV0XCJbuaB0/xQMGdNXUw
         0yV1fAZuuqsk8Kiw1hkywkNwYgUzmx/CRB96iafXLn0GwDLd7HNtdRWPNyDD2t5puAl8
         CBoiB0KVeueDQZoS9txKXREN1n8rpSchwqOQERM1lEVuqgvKG00BCpYkc+rkGQz6CMCe
         fMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591862; x=1779196662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pslgnpi6oJHX0FC9c/oZUmb0rO29LqRdvT8VmcUjOsw=;
        b=g5tpsN+g/SOmZMOWANxjuyIZ5T/lVZfeuTcM8j5ktJkXYL0jqdSMzwXz1dKW5zJjIC
         aBTmjoobmzBQkcqFU103fIVDAscbjSLhTPijGIAtPFWtVwu5w0Gv8pQVp+yhwgvwxKq8
         9+XwoC+LQFxh/iVVyzuHVj/Q0pvUTWMBnhXfvAOPjKsDkYnV71vpO0Qt1II+EAE+LLdl
         pCnWtp6mehfcQgM3X6+MT548zLcgRdmdDS8Yarw4qp3ZkaPk153Cuxqv1iLeTxkaBkQa
         34ZSorELy4mtf7Q+4YBT/NHxedsOUNBN4QgFNtHq5v9O9VzC+i88KVzvWzrWZcxFoagC
         0wkg==
X-Forwarded-Encrypted: i=1; AFNElJ97/RSzfmvG+csJGxra7IdCL7ICM0s9URgKURgeO5SRvFcoa/BkP2AeZi5VQy9T5RL0U5kJuw0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzMlK1yzaoREIP4Vu4gw4fvYjXaThFPeQEthcI7f3ajYycIKQw8
	zb2EK2+pX80EEaHTVfzuIOGPcn1Ahv752qy8MJB2cIc13qmxuh95H9HC
X-Gm-Gg: Acq92OHO8XDIfiEA6wJPr1/6oktk3SejXS9X54/DfXJZGd/bLVf85pf0drjNTTibaok
	pru0cwgQzP52NWDyu44LU2Ypqb/v3krmws+PbDMm21m6O/uulpotyOUNPKazZ9WFI08dmRYAE1X
	Qhw8Skxvf8D1atXMKxE4NKudQQ4pvyMxd8zEAPQ2uHcAu5Pvrdwa7Fk6sNaHoFvGuyxjyzN3otw
	hEG9n9fBOL2cE8bZKGWubG4N/pHKSLRBXiMSmYpUsSL48yeMAOzbP/7OojPznzC+Jp+Ije625H8
	GwxxD+HtDaZanV1xJni8b//XYyRFPkMc3Vsgu+VJiu0D5GXrudN2cghirMMv8OWmUqwZ3bwSSX2
	CynWCF16gbeaHKQ56U3hGqmTUNoKKeR24lVipC89+XRnEN44nO9ZF86yxGHtTthml
X-Received: by 2002:a2e:a80b:0:b0:38c:63df:8298 with SMTP id 38308e7fff4ca-3940819a961mr45586531fa.28.1778591861755;
        Tue, 12 May 2026 06:17:41 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393fa029671sm32172131fa.36.2026.05.12.06.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:17:41 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Tue, 12 May 2026 15:17:39 +0200
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ido Schimmel <idosch@nvidia.com>,
	syzbot <syzbot+8b12fc6e0fb139765b58@syzkaller.appspotmail.com>,
	bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, razor@blackwall.org,
	syzkaller-bugs@googlegroups.com, fw@strlen.de
Subject: Re: [syzbot] [bridge?] kernel BUG in __get_vm_area_node
Message-ID: <agMoc9Bvcxis8mT7@milan>
References: <69ff8c7c.050a0220.1036b8.000b.GAE@google.com>
 <20260512084754.GA181587@shredder>
 <agLyLko3Et-V2mRV@pc636>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agLyLko3Et-V2mRV@pc636>

On Tue, May 12, 2026 at 11:26:06AM +0200, Uladzislau Rezki wrote:
> On Tue, May 12, 2026 at 11:47:54AM +0300, Ido Schimmel wrote:
> > On Sat, May 09, 2026 at 12:35:24PM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    9207d47f966b Merge tag 'for-linus' of git://git.kernel.org..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17e44d06580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=d0f0911eedbc130a
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=8b12fc6e0fb139765b58
> > > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > > userspace arch: i386
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-9207d47f.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/6c5e883f31aa/vmlinux-9207d47f.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/19f3e863ae5c/bzImage-9207d47f.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+8b12fc6e0fb139765b58@syzkaller.appspotmail.com
> > > 
> > > ------------[ cut here ]------------
> > > kernel BUG at mm/vmalloc.c:3206!
> > 
> > It seems that this bug was fixed by commit 30c19366636f ("mm: fix BUG
> > splat with kvmalloc + GFP_ATOMIC"), but then commit c6307674ed82 ("mm:
> > kvmalloc: add non-blocking support for vmalloc") re-introduced it.
> > 
> > Uladzislau, can you please look into it?
> > 
> > Note that the bridge is calling rhashtable_lookup_insert_fast() with BH
> > disabled.
> > 
> Yep, since vmalloc can be called with ATOMIC/NOWAIT flags now. I am
> checking this. Probably we can just remove below check:
> 
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 676851d5cfe7..3d338e4bcbf7 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3209,7 +3209,6 @@ struct vm_struct *__get_vm_area_node(unsigned long size,
>         struct vm_struct *area;
>         unsigned long requested_size = size;
> 
> -       BUG_ON(in_interrupt());
>         size = ALIGN(size, 1ul << shift);
>         if (unlikely(!size))
>                 return NULL;
> <snip>
> 
> We have already the check:
> 
> 	gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
> 	allow_block = gfpflags_allow_blocking(gfp_mask);
> 	might_sleep_if(allow_block);
> 
> in alloc_vmap_area().
> 
Actually since we are not allowed to call vmalloc from NMI nor IRQ
context. We should keep the check. But in a slightly different form:

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 676851d5cfe7..273bbe49eaef 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3209,7 +3209,7 @@ struct vm_struct *__get_vm_area_node(unsigned long size,
 	struct vm_struct *area;
 	unsigned long requested_size = size;
 
-	BUG_ON(in_interrupt());
+	BUG_ON(in_nmi() || in_hardirq());
 	size = ALIGN(size, 1ul << shift);
 	if (unlikely(!size))
 		return NULL;
<snip>

if any context disables BH, i.e. local_bh_disable() it does not mean we
are in IRQ context. Furthermore the documentation about in_interrupt()
says:

<snip>
/*
 * The following macros are deprecated and should not be used in new code:
 * in_softirq()   - We have BH disabled, or are processing softirqs
 * in_interrupt() - We're in NMI,IRQ,SoftIRQ context or have BH disabled
 */
#define in_softirq()		(softirq_count())
#define in_interrupt()		(irq_count())
<snip>

those are should not be used.

--
Uladzislau Rezki
