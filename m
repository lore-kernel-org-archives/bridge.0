Date: Fri, 4 Feb 2005 23:32:04 +0100
Subject: Re: [Bridge] recent 2.6 kernels hang on bridge shutdown - solved
Message-ID: <20050204223204.GA15585@stilzchen.informatik.tu-chemnitz.de>
References: <20050202175652.GA1531@stilzchen.informatik.tu-chemnitz.de>
	<20050203115407.5e7fc195@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203115407.5e7fc195@dxpl.pdx.osdl.net>
From: Mirko Parthey <mirko.parthey@informatik.tu-chemnitz.de>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

On Thu, Feb 03, 2005 at 11:54:07AM -0800, Stephen Hemminger wrote:
> > With recent 2.6 kernels, the command
> >   brctl delbr br0
> > hangs during shutdown, and the kernel prints this message again and again:
> >   unregister_netdevice: waiting for br0 to become free. Usage count = 1
> 
> Are you running IPV6? if so it is most likely related to IPV6.

Yes, indeed.
Since I currently don't need IPv6, I disabled it - problem solved.

Thanks a lot!
Mirko
