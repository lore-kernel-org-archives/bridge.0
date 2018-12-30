Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-language:content-transfer-encoding;
	bh=c9KG5owWNPdBn7AYfRPUjZUIbVn9OuA4tUdeEItY8O0=;
	b=cwV7lJh+uu+lBmMsGzTiHe8Dua3oPYrf8GrPFCzERh0uYKWKGLGxaN0+VoXreglmac
	GKAQu+O74pE/JfAgrDp9Swxb9wZsBKNlQmWsbGx82cmqas9WnRoFtc22gzyH4jJ95HUg
	eQEaZ2dJ7GX//QTdp3ZcwVz38xdLm/uRonC00=
References: <0000000000004e8a91057e355803@google.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <663bc6d0-f6ec-796d-54bb-b9afa3c0bce1@cumulusnetworks.com>
Date: Sun, 30 Dec 2018 13:34:34 +0200
MIME-Version: 1.0
In-Reply-To: <0000000000004e8a91057e355803@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] general protection fault in fdb_find_rcu
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: syzbot <syzbot+017b1f61c82a1c3e7efd@syzkaller.appspotmail.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, roopa@cumulusnetworks.com, syzkaller-bugs@googlegroups.com

On 30/12/2018 06:01, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    90cadbbf341d Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1745c69b400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9d41c8529d7e7362
> dashboard link: https://syzkaller.appspot.com/bug?extid=017b1f61c82a1c3e7efd
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15babaab400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c6142d400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+017b1f61c82a1c3e7efd@syzkaller.appspotmail.com
> 

Ah yes, good catch. We've missed this obvious bug during the review.
A patch is on its way, just need to run a few tests.

Cheers,
 Nik

