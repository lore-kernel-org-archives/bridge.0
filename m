Date: Fri, 13 Mar 2009 15:12:00 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20090313151200.1cc16255@nehalam>
In-Reply-To: <20090313.142718.21189207.davem@davemloft.net>
References: <cover.1236702228.git.scott@canonical.com>
	<74b87ec3359e6e65d59cd6fb62a83fb469e6c8ae.1236702228.git.scott@canonical.com>
	<20090313.142718.21189207.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 01/31] bridge: Auto-load bridge module when
 socket opened.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: scott@canonical.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On Fri, 13 Mar 2009 14:27:18 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Scott James Remnant <scott@canonical.com>
> Date: Mon, 2 Mar 2009 16:40:10 +0000
> 
> > The bridge module is missing the net-pf-7 alias that would cause it to
> > be auto-loaded when a socket of that type is opened.  This patch adds
> > the alias.
> > 
> > Signed-off-by: Scott James Remnant <scott@canonical.com>
> > Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> 
> Bridging has no sockets, so this patch won't do anything.
> 
> Did you verify that these changes actually do something?
> Or did you blindly run around peppering source files with
> these annotations?

I think this all started when I was debugging a problem where LLC
was not getting autoloaded properly. It turned out that distro's
like Debian (and therefore Ubuntu) had incorrect modprobe.d/alias file
entries. I raised the bug that, "hey you have wrong data and you
really don't need these alias entries at all anymore". There was some
comparison of what was being shipped versus what was in the kernel
and the Debian/Ubuntu guys stepped in to try and unify this.

Let's be supportive of Ubuntu maintainers actually working on upstream
resolution for a change. The normal distro maintainer is "patch and ignore".
In this case, many of these are correct, but several of them are cases
where there is no point in having a module alias because there is no
functiona user visible API. You can try and open a PF_BRIDGE socket, there just
is no point.
