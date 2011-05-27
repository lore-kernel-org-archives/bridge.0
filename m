Date: Fri, 27 May 2011 15:21:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20110527152158.0453899d.akpm@linux-foundation.org>
In-Reply-To: <bug-35992-10286@https.bugzilla.kernel.org/>
References: <bug-35992-10286@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [Bugme-new] [Bug 35992] New: Regression: oops when
 using a bridge interface with tg3
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bzed@debian.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, bridge@lists.linux-foundation.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

2.6.38->2.6.39 regression, appears to be bridge-related.  There's a
partial screencap of the oops linked below.

Bernd, it would be helpful if you could set the screen to more rows
(50?) and then retake that photo.  Documentation/svga.txt might help
out.  Thanks.


On Fri, 27 May 2011 15:28:17 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=35992
> 
>            Summary: Regression: oops when using a bridge interface with
>                     tg3
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 2.6.39
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Network
>         AssignedTo: drivers_network@kernel-bugs.osdl.org
>         ReportedBy: bzed@debian.org
>         Regression: Yes
> 
> 
> Created an attachment (id=59712)
>  --> (https://bugzilla.kernel.org/attachment.cgi?id=59712)
> backtrace image
> 
> Using a bridge interface with
> - eth0 from a Tigeon3 card (Broadcom Corporation NetXtreme BCM5704 Gigabit
> Ethernet [14e4:1648] (rev 10))
> - 3 veth interfaces from LXC
> results in a kernel oops on 2.6.39. Up and until 2.6.38.7 I did not run into
> the issue.
> 
> Unfortunately I'm only able to provide a screenshot or a part of the backtrace
> as I don't have a proper serial console available.
> 
> -- 
> Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
> ------- You are receiving this mail because: -------
> You are on the CC list for the bug.
