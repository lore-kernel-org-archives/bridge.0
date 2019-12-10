Return-Path: <vivien.didelot@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:message-id:from:to:cc:subject:in-reply-to:references
 :mime-version:content-disposition:content-transfer-encoding;
 bh=k9StEROeVFHgDma5h9VD+gMFs/72EafIdPmXm2r7ghk=;
 b=PsL8HeIF/pbv1HxDF4LzH/nSUtms0dwXA+dzZvwl/Wc9lv1sPtkRc4eDbX5ufVHO0A
 ez8TgCSMBNY/INVzWaE3Yu0NUdG0QQTUTJlq4M3pLXpdMXOmW4f5ljjU3DIYfUEmUIvN
 gjWJ5zGNX8qjWLGzHIg2dOLeZimFsS08SsAwv+xAPk8fVNpIuQIxFcwqN8OA26R8xFpU
 58ksFGwwl/iuODPS2x4Mn1AremLP+NxYbsai1vErzb/pR50tsMhwRbgNmWvU7G5Kl3Lo
 6jO8H81GG1vQJ/wW8Zg0ghFF6UryCCgLrdZJxpQJ2vCEJsp2Yu4XnLWgm5Ux6G3zAioi
 yGhw==
Date: Tue, 10 Dec 2019 15:34:41 -0500
Message-ID: <20191210153441.GB1429230@t480s.localdomain>
From: Vivien Didelot <vivien.didelot@gmail.com>
In-Reply-To: <1aa8b6e4-6a73-60b0-c5fb-c0dfa05e27e6@cumulusnetworks.com>
References: <20191209230522.1255467-1-vivien.didelot@gmail.com>
 <a3b8e24d-5152-7243-545f-8a3e5fbaa53a@cumulusnetworks.com>
 <20191210143931.GF1344570@t480s.localdomain>
 <2f4e351c-158a-4f00-629f-237a63742f66@cumulusnetworks.com>
 <20191210151047.GB1423505@t480s.localdomain>
 <1aa8b6e4-6a73-60b0-c5fb-c0dfa05e27e6@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On Tue, 10 Dec 2019 22:15:26 +0200, Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> >>>> Why do you need percpu ? All of these seem to be incremented with the
> >>>> bridge lock held. A few more comments below.
> >>>
> >>> All other xstats are incremented percpu, I simply followed the pattern.
> >>>
> >>
> >> We have already a lock, we can use it and avoid the whole per-cpu memory handling.
> >> It seems to be acquired in all cases where these counters need to be changed.
> > 
> > Since the other xstats counters are currently implemented this way, I prefer
> > to keep the code as is, until we eventually change them all if percpu is in
> > fact not needed anymore.
> > 
> > The new series is ready and I can submit it now if there's no objection.
> 
> There is a reason other counters use per-cpu - they're incremented without any locking from fast-path.
> The bridge STP code already has a lock which is acquired in all of these paths and we don't need
> this overhead and the per-cpu memory allocations. Unless you can find a STP codepath which actually
> needs per-cpu, I'd prefer you drop it.

Ho ok I understand what you mean now. I'll drop the percpu attribute.


Thanks,

	Vivien
