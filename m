Message-ID: <4DE0DDFE.9080308@debian.org>
Date: Sat, 28 May 2011 13:35:26 +0200
From: Bernd Zeimetz <bzed@debian.org>
MIME-Version: 1.0
References: <bug-35992-17701@https.bugzilla.kernel.org/>
	<201105281013.p4SADfPS024949@demeter1.kernel.org>
In-Reply-To: <201105281013.p4SADfPS024949@demeter1.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [Bug 35992] Regression: oops when using a bridge
 interface with tg3
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Eric Dumazet <eric.dumazet@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org
Cc: bzed@debian.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, bridge@lists.linux-foundation.org

Hi,

> OK, this sounds like an already fixed bug.
> 
> (commit : 33eb9873a283a bridge: initialize fake_rtable metrics)
> 
> Could you try latest linux-2.6 tree ?

I've picked the commit into 2.6.39 and it fixed the issue, thanks for the pointer.


Could we please get that included in 2.6.39.1?

Thanks,

Bernd

-- 
 Bernd Zeimetz                            Debian GNU/Linux Developer
 http://bzed.de                                http://www.debian.org
 GPG Fingerprint: ECA1 E3F2 8E11 2432 D485  DD95 EB36 171A 6FF9 435F
