From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <4DE0DDFE.9080308@debian.org>
References: <bug-35992-17701@https.bugzilla.kernel.org/>
	<201105281013.p4SADfPS024949@demeter1.kernel.org>
	<4DE0DDFE.9080308@debian.org>
Content-Type: text/plain; charset="utf-8"
Date: Mon, 30 May 2011 04:58:11 +0200
Message-ID: <1306724291.6368.3.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
To: Bernd Zeimetz <bzed@debian.org>
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Le samedi 28 mai 2011 à 13:35 +0200, Bernd Zeimetz a écrit :
> Hi,
> 
> > OK, this sounds like an already fixed bug.
> > 
> > (commit : 33eb9873a283a bridge: initialize fake_rtable metrics)
> > 
> > Could you try latest linux-2.6 tree ?
> 
> I've picked the commit into 2.6.39 and it fixed the issue, thanks for the pointer.
> 
> 
> Could we please get that included in 2.6.39.1?
> 

It will, David and Greg took care of this, thanks.



