Message-ID: <4DE0B91E.1080407@debian.org>
Date: Sat, 28 May 2011 10:58:06 +0200
From: Bernd Zeimetz <bzed@debian.org>
MIME-Version: 1.0
References: <bug-35992-10286@https.bugzilla.kernel.org/>
	<20110527152158.0453899d.akpm@linux-foundation.org>
In-Reply-To: <20110527152158.0453899d.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: netdev@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, bridge@lists.linux-foundation.org

On 05/28/2011 12:21 AM, Andrew Morton wrote:
> 2.6.38->2.6.39 regression, appears to be bridge-related.  There's a
> partial screencap of the oops linked below.

The oops happens as soon as I add the lxc veth interface to the bridge, before
everything works as expected.


A new, full screenshot is attached
https://bugzilla.kernel.org/attachment.cgi?id=59732


(For yet unknows reasons I can't access the serial port redirection via ssh and
I won't be able to attach a real serial port cable before Monday, so I'm afraid
you have to work with the screenshot for now.)


> Bernd, it would be helpful if you could set the screen to more rows
> (50?) and then retake that photo.  Documentation/svga.txt might help
> out.  Thanks.

(the kernel says that vga=... is deprecated, guess that documentation is outdated?)

Thanks and cheers,

Bernd

-- 
 Bernd Zeimetz                            Debian GNU/Linux Developer
 http://bzed.de                                http://www.debian.org
 GPG Fingerprint: ECA1 E3F2 8E11 2432 D485  DD95 EB36 171A 6FF9 435F
