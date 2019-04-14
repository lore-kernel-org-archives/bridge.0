Return-Path: <luto@amacapital.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amacapital-net.20150623.gappssmtp.com; s=20150623;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=APE1+5Wvf+xwt+gAjLgAiPB8zAu3NBFsDQCMn4otx0w=;
	b=hNTJTAJ2tkSO2jsnr2m80fzaBiOmdbfaPsIcE0EHbZby0KMa+1zY3IsmEMGsd4T6fy
	UO26mMe4ADsd+iVe4YNUzwq4WITSs6lF6iiaOGK+KdhCXZu1uFHgvzHXSrVr6eeRhQhP
	maf+oNQLMKAFkUbwSCmQ5JB20Pds032OHVkvy/7at2dGrguGu+cSoqRLsY/ksY4Hb0Bt
	jFxnwuYgnVcB6rwzP34/IylEQQH0gF/jHc0U6HbwGR+sjRJur5qKrcjEcORKM2F81WCX
	TQA/b1thezdRQxoxrtzYNIGnPfepbShEn5++VelOHAtmyjWlfOQuvAMfaz5QgS057LOH
	TVYQ==
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <00000000000019eb000586826c2a@google.com>
Date: Sun, 14 Apr 2019 13:08:09 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <0E15851D-59E4-455D-985E-65F066E7A85A@amacapital.net>
References: <00000000000019eb000586826c2a@google.com>
Subject: Re: [Bridge] WARNING in compat_copy_entries (2)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: syzbot <syzbot+659574e7bcc7f7eb4df7@syzkaller.appspotmail.com>
Cc: peterz@infradead.org, mingo@kernel.org, nicholson@endlessm.com, cosimo@endlessm.com, bridge@lists.linux-foundation.org, raji@linux.vnet.ibm.com, coreteam@netfilter.org, kadlec@blackhole.kfki.hu, pablo@netfilter.org, syzkaller-bugs@googlegroups.com, alexl@redhat.com, luto@kernel.org, tglx@linutronix.de, dvyukov@google.com, libc-alpha@sourceware.org, netdev@vger.kernel.org, tuliom@linux.vnet.ibm.com, fw@strlen.de, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, torvalds@linux-foundation.org, davem@davemloft.net

This is likely a confused bisection.  I bet that reverting this patch breaks=
 your test but has nothing to do with the bug. Try reproducing with socketca=
ll() to bisect farther.

--Andy

> On Apr 14, 2019, at 12:20 PM, syzbot <syzbot+659574e7bcc7f7eb4df7@syzkalle=
r.appspotmail.com> wrote:
>=20
> syzbot has bisected this bug to:
>=20
> commit 9dea5dc921b5f4045a18c63eb92e84dc274d17eb
> Author: Andy Lutomirski <luto@kernel.org>
> Date:   Tue Jul 14 22:24:24 2015 +0000
>=20
>    x86/entry/syscalls: Wire up 32-bit direct socket calls
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1736919f200=
000
> start commit:   ce380619 Merge tag 'please-pull-ia64_misc' of git://git.ke=
..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10b6919f200000=

> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D36fbc8c97ef985=
d3
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D659574e7bcc7f7eb=
4df7
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D179b4d8b8000=
00
>=20
> Reported-by: syzbot+659574e7bcc7f7eb4df7@syzkaller.appspotmail.com
> Fixes: 9dea5dc921b5 ("x86/entry/syscalls: Wire up 32-bit direct socket cal=
ls")
>=20
> For information about bisection process see: https://goo.gl/tpsmEJ#bisecti=
on
