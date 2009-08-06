Date: Thu, 6 Aug 2009 15:16:06 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20090806151606.6c9f0ffb@nehalam>
In-Reply-To: <COL102-DS8EEFACEAA0D1A8E3D5CA2CF0A0@phx.gbl>
References: <COL102-DS8EEFACEAA0D1A8E3D5CA2CF0A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge on colinux: need to configure bridging in kernel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Song Ping (pubic emailbox)" <itestitest@hotmail.com>
Cc: bridge@linux-foundation.org

On Thu, 6 Aug 2009 13:10:21 +0800
"Song Ping \(pubic emailbox\)" <itestitest@hotmail.com> wrote:

> Hi:
> 
> I'm trying to setup dynamips to simulate some cisco routers in ubuntu and I
> need to bridge the router interface out of the linux NIC (so two virtual
> routers hold by 2 linux can talk), and it looks I need this fancy bridge
> tool, but.
> 
> When I install the bridge-utils and start to configure a bridge, it reports
> the following error:
> 
> # brctl addbr br0
> 
> add bridge failed: Package not installed
> 
>  
> 
> read through the document and realize I probably need to "configure Ethernet
> bridging into my kernel", here is my kernel version:
> 
> root@ubuntu-1:/home/ping1# uname -r
> 
> 2.6.22.18-co-0.7.4
> 
>  
> 
> So , yes I'm using colinux (running on top of winxp), but I don't think that
> should be the root cause, problem is now how do I "configure Ethernet
> bridging into my kernel"? 
> 
> Sorry this may sound a stupid question for experts but I'm not an export of
> linux so that sound real hard and dangrious for me , any step-by-step
> suggestion on that?
> 

If bridging is not in the kernel, you will have to reconfigure and
recompile the kernel. If you don't have source and/or tools to do
that, there is no other clean solution.
