Date: Thu, 1 Sep 2005 09:24:53 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] unregister_netdevice: waiting for br0 to become free.
	Usage count = 1 (2.6.12.3)
Message-ID: <20050901092453.29c45716@dxpl.pdx.osdl.net>
In-Reply-To: <4E543B45-7887-419E-9E72-36643093C0AC@axentra.net>
References: <8189B9F5-DF6E-4032-8D2D-D5301A02A081@axentra.net>
	<20050831213749.6bc8dd50@localhost.localdomain>
	<4E543B45-7887-419E-9E72-36643093C0AC@axentra.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Robert Scott <rbscott@axentra.net>
Cc: bridge@lists.osdl.org

On Wed, 31 Aug 2005 23:33:22 -0700
Robert Scott <rbscott@axentra.net> wrote:

> > Two other recent reports are:
> > 1. Buggy applications that hold packets in their input queue forever,
> >    and/or netfilters.  The socket buffer's contain a reference for
> >    packets in flight.
> 
> that may be it, but I am not sure which queue you are talking about,  
> but there is an application that is using the netfiler ip_queue to  
> queue packets to user space.  in this application, these packets can  
> be held in user space for extended periods of time (up to 30/60  
> seconds), and then they are either dropped or released.  Could this  
> possibly be creating a problem?

That could be it, ask Patrick McHardy, Harald, or netfilter-devel
