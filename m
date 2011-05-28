From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <4DE0B91E.1080407@debian.org>
References: <bug-35992-10286@https.bugzilla.kernel.org/>
	<20110527152158.0453899d.akpm@linux-foundation.org>
	<4DE0B91E.1080407@debian.org>
Content-Type: text/plain; charset="utf-8"
Date: Sat, 28 May 2011 12:13:07 +0200
Message-ID: <1306577587.2533.30.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
To: Bernd Zeimetz <bzed@debian.org>
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Le samedi 28 mai 2011 à 10:58 +0200, Bernd Zeimetz a écrit :
> On 05/28/2011 12:21 AM, Andrew Morton wrote:
> > 2.6.38->2.6.39 regression, appears to be bridge-related.  There's a
> > partial screencap of the oops linked below.
> 
> The oops happens as soon as I add the lxc veth interface to the bridge, before
> everything works as expected.
> 
> 
> A new, full screenshot is attached
> https://bugzilla.kernel.org/attachment.cgi?id=59732
> 
> 
> (For yet unknows reasons I can't access the serial port redirection via ssh and
> I won't be able to attach a real serial port cable before Monday, so I'm afraid
> you have to work with the screenshot for now.)
> 
> 
> > Bernd, it would be helpful if you could set the screen to more rows
> > (50?) and then retake that photo.  Documentation/svga.txt might help
> > out.  Thanks.
> 
> (the kernel says that vga=... is deprecated, guess that documentation is outdated?)
> 

OK, this sounds like an already fixed bug.

(commit : 33eb9873a283a bridge: initialize fake_rtable metrics)

Could you try latest linux-2.6 tree ?

By the way, if panic stills happen, could you try netconsole ?

Here I just add
"netconsole=4444@192.168.20.108/eth1,4444@192.168.20.112/00:1e:0b:ec:c3:e4" to my boot param

192.168.20.108 is my ip addr,
192.168.20.112 the ip addr of "remote machine",
00:1e:0b:ec:c3:e4 the mac addr of "remote machine"

On "remote machine" I start : netcat -l -u -p 4444 </dev/null


Thanks


