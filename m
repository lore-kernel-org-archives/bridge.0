Date: Sat, 12 Jun 2004 02:42:11 -0600
From: Erik Andersen <andersen@codepoet.org>
Subject: Re: [uClibc] Re: [Bridge] Little problem with 1.x versions
	(if_indextoname)
Message-ID: <20040612084211.GB3491@codepoet.org>
References: <s0bef17a.034@post2.controlware.de>
	<20040603104100.2ae94cb2@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603104100.2ae94cb2@dell_ss3.pdx.osdl.net>
Reply-To: andersen@codepoet.org
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: uclibc@uclibc.org, "Harald =?ISO-8859-1?B?S/x0aGUi?= <Harald.Kuethe@controlware.de>"@osdl.org, bridge@lists.osdl.org

On Thu Jun 03, 2004 at 10:41:00AM -0700, Stephen Hemminger wrote:
> Rather than copy more code back into the bridge-utilities, how
> about applying this change to uClibc?  I hate when packages get
> cluttered for workarounds for other incompatibilities.
> 
> The problem is that SIOCGIFCONF only lists interfaces that have
> IP addresses, so it doesn't find the other interfaces that are
> being used for bridging. It could be fixed in the kernel to
> return all interfaces, but then something else might break; and
> still it mean a kernel update for the 2.4 users. 
> 
> The whole use of ifindex in the bridge API is a bad idea. But
> we probably have to live with it for compatibility.

Thanks.  Patch applied,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
