From: Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20050127171023.2e8547e1.davem@davemloft.net>
References: <1131604877.20041218092730@mail.ru.suse.lists.linux.kernel>
	<p73zn0ccaee.fsf@verdi.suse.de>
	<1105117559.11753.34.camel@baythorne.infradead.org>
	<20050107100017.454ddadc@dxpl.pdx.osdl.net>
	<1105133241.3375.16.camel@localhost.localdomain>
	<20050118135735.4b77d38d.davem@davemloft.net>
	<1106433059.4486.11.camel@localhost.localdomain>
	<1106436153.20995.42.camel@tux.rsn.bth.se>
	<1106484019.3376.5.camel@localhost.localdomain>
	<1106496509.1085.1.camel@tux.rsn.bth.se>
	<20050125220558.6e824f8a.davem@davemloft.net>
	<1106730510.4041.4.camel@localhost.localdomain>
	<41F82C6D.7020006@trash.net>
	<20050126231801.7bf90338.davem@davemloft.net>
	<41F929FA.3050800@trash.net>
	<20050127114726.2205b4ed.davem@davemloft.net>
	<41F96FA4.4000105@trash.net>
	<20050127152450.6daba4fa.davem@davemloft.net>
	<1106872169.18360.6.camel@localhost.localdomain>
	<20050127171023.2e8547e1.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 12:32:25 +1100
Message-Id: <1106875946.18360.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH/RFC] Reduce call chain length in netfilter
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@oss.sgi.com, bdschuym@pandora.be, bridge@osdl.org, snort2004@mail.ru, gandalf@wlug.westbo.se, Netfilter development mailing list <netfilter-devel@lists.netfilter.org>, dwmw2@infradead.org, ak@suse.de, shemminger@osdl.org

On Thu, 2005-01-27 at 17:10 -0800, David S. Miller wrote:
> On Fri, 28 Jan 2005 11:29:29 +1100
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > No, let's just fix them all.
> 
> In tree, yes.  But leaving the NF_HOOK()/NF_HOOK_THRESH() compat
> macros in there for out-of-tree modules I feel is mandatory, it's
> a major API change.

I'm not so sure.  The hook functions which are registered, sure (ie.
keep the calling convention the same).  But do any external modules use
NF_HOOK()?  That implies they're writing their own network stack for
some protocol, which I would expect to be uncommon.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

