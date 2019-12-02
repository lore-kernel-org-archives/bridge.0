Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=A7xwm8gC8IFcmIwrDFz1mUiBMU42HvgoLpPYOdX1CWQ=;
 b=ZOtyJo+O+ea+CUdCTEPU394bFqI2NW2JOOFXR228offjrOPoiKp17JEx7YHrvCwtxL
 ayfcNnftnWN18v0ZWzqlEVSXvl0U0g6v+VfVLIsH1m6m9VNtPL7xBsrJ0HhQ/HWCx51P
 Zlt6UvKJNGWGnBcUfO9q/briMSRbhlOnfg3UU=
References: <0000000000001821bf0598bb955c@google.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <76434004-ca0b-0917-78bd-a0332af2a716@cumulusnetworks.com>
Date: Mon, 2 Dec 2019 22:20:38 +0200
MIME-Version: 1.0
In-Reply-To: <0000000000001821bf0598bb955c@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] memory leak in fdb_create (2)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: syzbot <syzbot+2add91c08eb181fea1bf@syzkaller.appspotmail.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, roopa@cumulusnetworks.com, syzkaller-bugs@googlegroups.com

On 02/12/2019 19:05, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    ceb30747 Merge tag 'y2038-cleanups-5.5' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=142b3e7ee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=26f873e40f2b4134
> dashboard link: https://syzkaller.appspot.com/bug?extid=2add91c08eb181fea1bf
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12976feee00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10604feee00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2add91c08eb181fea1bf@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff888124fa7080 (size 128):
>   comm "syz-executor163", pid 7170, jiffies 4294954254 (age 12.500s)

I'll look into this tomorrow, I think see the issue.

Thanks!
