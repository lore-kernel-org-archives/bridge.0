Date: Mon, 13 Sep 2004 09:28:59 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] sparc64: add bridge failed: Operation not supported
Message-Id: <20040913092859.5e8e84da@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040912171952.E15021@macwheel.xs4all.nl>
References: <20040910223011.Q15021@macwheel.xs4all.nl>
	<20040911080956.T15021@macwheel.xs4all.nl>
	<20040911152908.U15021@macwheel.xs4all.nl>
	<20040912171952.E15021@macwheel.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Geert Stappers <stappers@stappers.nl>
Cc: bridge@lists.osdl.org

On Sun, 12 Sep 2004 17:19:52 +0200
stappers@stappers.nl (Geert Stappers) wrote:

> On Sat, Sep 11, 2004 at 03:29:08PM +0200, Geert Stappers wrote:
> > On Sat, Sep 11, 2004 at 08:09:56AM +0200, Geert Stappers wrote:
> > > On Fri, Sep 10, 2004 at 10:30:11PM +0200, Geert Stappers wrote:
> > > > Hello,
>  <snip/>
> > > > My questions are:
> > > > 
> > > > * Are there succesfull reported sparc64 systems doing bridging?
> sparc64 seems indeed be some what special on the bridging aspect ...
> 
> > > > * What should I do to get that sparc64 acting as a bridge?
> > > A recompile with gcc-2.95 did not show improvement.
> > AFAICT it is brctl 1.0.4 that needs a 2.6 kernel.
> 
> Installing kernel 2.6.8 allowed me to do bridging on a sparc64

Yes, the cross 32/64 bit environment is not supported on 2.4.
In order to get size independence it meant changing the API to use sysfs which
is not available on 2.4
