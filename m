Return-Path: <fw@strlen.de>
Date: Mon, 15 Apr 2019 00:32:36 +0200
From: Florian Westphal <fw@strlen.de>
Message-ID: <20190414223236.amahulln6fw4hwaw@breakpoint.cc>
References: <00000000000019eb000586826c2a@google.com>
	<0E15851D-59E4-455D-985E-65F066E7A85A@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E15851D-59E4-455D-985E-65F066E7A85A@amacapital.net>
Subject: Re: [Bridge] WARNING in compat_copy_entries (2)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andy Lutomirski <luto@amacapital.net>
Cc: peterz@infradead.org, tuliom@linux.vnet.ibm.com, mingo@kernel.org, nicholson@endlessm.com, cosimo@endlessm.com, bridge@lists.linux-foundation.org, raji@linux.vnet.ibm.com, coreteam@netfilter.org, kadlec@blackhole.kfki.hu, pablo@netfilter.org, syzkaller-bugs@googlegroups.com, alexl@redhat.com, luto@kernel.org, tglx@linutronix.de, dvyukov@google.com, libc-alpha@sourceware.org, netdev@vger.kernel.org, syzbot <syzbot+659574e7bcc7f7eb4df7@syzkaller.appspotmail.com>, fw@strlen.de, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, torvalds@linux-foundation.org, davem@davemloft.net

Andy Lutomirski <luto@amacapital.net> wrote:
> This is likely a confused bisection.  I bet that reverting this patch breaks your test but has nothing to do with the bug. Try reproducing with socketcall() to bisect farther.

No need, this WARN_ON can be removed. I'll send a patch.
